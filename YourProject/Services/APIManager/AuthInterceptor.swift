//
//  AuthInterceptor.swift
//  YourProject
//
//  Created by IntrodexMini on 1/2/2568 BE.
//
import Foundation
import Alamofire

//@unchecked Sendable
class AuthInterceptor: RequestInterceptor {
    
    nonisolated let localStorageManager: LocalStorageManagerProtocal
    nonisolated let authRemoteService: AuthServiceProtocol
    
    init(
        localStorageManager: LocalStorageManagerProtocal = LocalStorageManager(),
        authRemoteService: AuthServiceProtocol = AuthRemoteService()
    ) {
        self.localStorageManager = localStorageManager
        self.authRemoteService = authRemoteService
    }
    
    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping @Sendable (_ result: Result<URLRequest, any Error>) -> Void) {
        var request = urlRequest
                        
        if let token = localStorageManager.accessToken {
            request.headers.add(.authorization(bearerToken: token))
        }
        else {
            let errorResponse = APIAuthErrorResponse.ErrorCode.missingAccessToken.errorResponse
            
            completion(.failure(errorResponse))
            return
        }
        
        completion(.success(request))
    }

    /// Inspects and adapts the specified `URLRequest` in some manner and calls the completion handler with the Result.
    ///
    /// - Parameters:
    ///   - urlRequest: The `URLRequest` to adapt.
    ///   - state:      The `RequestAdapterState` associated with the `URLRequest`.
    ///   - completion: The completion handler that must be called when adaptation is complete.
    func adapt(_ urlRequest: URLRequest,
               using state: RequestAdapterState,
               completion: @escaping @Sendable (RetryResult) -> Void) {
        guard
            let refreshToken = localStorageManager.refreshToken
        else {
            let errorResponse = APIAuthErrorResponse.ErrorCode.invalidRefreshToken.errorResponse
            completion(.doNotRetryWithError(errorResponse))
            return
        }
        
        Task {
            do {
                try await authRemoteService.tokenRefresh(
                    request: .init(token: refreshToken)
                )
            } catch {
                completion(.doNotRetryWithError(error))
                return
            }
        }
        completion(.doNotRetry)
    }

}
