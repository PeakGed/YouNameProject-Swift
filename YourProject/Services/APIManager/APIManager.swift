//
//  APIManager.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//

import Foundation
import Alamofire
import Mockable

enum APIError: Error, LocalizedError {
    case invalidURL
    case unauthorized(error: APIErrorResponse)
    case networkError(error: Error)
    case decodingError(error: Error)
    case httpError(error: Error)
    case serverError(statusCode: Int)
    case unexpectedError(error: Error)
    case unknownError(title: String? = nil,
                      subtitle: String? = nil,
                      underlying: Error? = nil)
}

enum AuthorizationType {
    case bearer(token: String)
}


@Mockable
protocol AlamofireBaseRouterProtocol {
    func asURLRequest() throws -> URLRequest
}

@Mockable
protocol APIManagerProtocal: AnyObject {
    
    func request<T>(
        _ url: String,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        requiredAuthorization: Bool
    ) async throws -> T where T: Decodable
    
    func request<T>(
        router: AlamofireBaseRouterProtocol,
        requiredAuthorization: Bool
    ) async throws -> T where T: Decodable
    
    func requestACK(
        router: AlamofireBaseRouterProtocol,
        requiredAuthorization: Bool
    ) async throws
    
    func requestData(
        router: AlamofireBaseRouterProtocol,
        requiredAuthorization: Bool
    ) async throws -> Data?
    
}

class APIManager: APIManagerProtocal {
    
    static let shared = APIManager()
    
    var baseURL: String {
        AppConfiguration.shared.baseURL
    }
    
    private var session: Session
    private var authSession: Session
    
    private var localStorageManager: LocalStorageManagerProtocal
    private let authInterceptor: AuthInterceptor
    
    init(localStorageManager: LocalStorageManagerProtocal = LocalStorageManager(),
         authRemoteService: AuthServiceProtocol = AuthRemoteService()) {
        self.localStorageManager = localStorageManager
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30  // 30 seconds timeout
        configuration.timeoutIntervalForResource = 300  // 5 minutes
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        authInterceptor = AuthInterceptor(
            localStorageManager: localStorageManager,
            authRemoteService: authRemoteService
        )
        
        authSession = Session(
            configuration: configuration,
            interceptor: authInterceptor
        )
        
        session = Session(configuration: configuration)
    }
    
    /// For setup Units or UI tests
    func setupURLSession(with configuration: URLSessionConfiguration) {
        self.authSession = Session(
            configuration: configuration,
            interceptor: authInterceptor
        )
        authSession.sessionConfiguration.timeoutIntervalForRequest = 30
        authSession.sessionConfiguration.timeoutIntervalForResource = 30
        
        session = Session(configuration: configuration)
        session.sessionConfiguration.timeoutIntervalForRequest = 30
        session.sessionConfiguration.timeoutIntervalForResource = 30
       
    }
    
    func request<T>(
        _ url: String,
        method: Alamofire.HTTPMethod,
        parameters: Alamofire.Parameters?,
        encoding: any Alamofire.ParameterEncoding,
        requiredAuthorization: Bool
    ) async throws -> T where T : Decodable {
        
        let session = self.session(requiredAuthorization: requiredAuthorization)
        let reqPath = fullPath(path: url)
        
        let response = await session.request(reqPath,
                                             method: method,
                                             parameters: parameters,
                                             encoding: encoding)
            .serializingData()
            .response
        
        return try handleResponse(response)
    }
    
    func request<T: Decodable>(
        router: AlamofireBaseRouterProtocol,
        requiredAuthorization: Bool = true
    ) async throws -> T {
        let session = self.session(requiredAuthorization: requiredAuthorization)
        let urlRequest = try router.asURLRequest()
        
        let response = await session.request(urlRequest)
            .serializingData()
            .response
        
        return try handleResponse(response)
    }
    
    
    func requestACK(
        router: AlamofireBaseRouterProtocol,
        requiredAuthorization: Bool = true
    ) async throws {
        let session = self.session(requiredAuthorization: requiredAuthorization)
        let urlRequest = try router.asURLRequest()
        
        let response = await session.request(urlRequest)
            .serializingData()
            .response
        
        let rawBody: String = try handleResponse(response)
        print(rawBody)
    }
    
    func requestData(
        router: AlamofireBaseRouterProtocol,
        requiredAuthorization: Bool = true
    ) async throws -> Data? {
        let session = self.session(requiredAuthorization: requiredAuthorization)
        let urlRequest = try router.asURLRequest()
        
        let response = await session.request(urlRequest)
            .serializingData()
            .response
        
        return try handleResponseData(response)
    }
    
}

private extension APIManager {
    func isAuthenticated() -> Bool {
        return localStorageManager.accessToken != nil
    }
    
    func fullPath(path: String) -> String {
        return "\(baseURL)\(path)"
    }
    
    func session(requiredAuthorization: Bool) -> Session {
        if requiredAuthorization {
            return authSession
        }
        return session
    }
    
    func handleResponse<T: Decodable>(_ response: AFDataResponse<Data>) throws -> T {
        // handel error
        if let error = response.error?.asAFError {
            switch error {
            case .requestRetryFailed(let retryError, let originalError):
                
                
                print(error.localizedDescription)
                throw APIError.unexpectedError(error: error)
            case .requestAdaptationFailed(let err):
                if let err = err as? APIErrorResponse {
                    if let _ = err.authErorKey {
                        throw APIError.unauthorized(error: err)
                    }
                    
                    throw APIError.unexpectedError(error: err)
                }
                
                throw APIError.unexpectedError(error: err)
                
            default:
                print(error.localizedDescription)
                throw APIError.unexpectedError(error: error)
            
            }
        }
        
        // case no response
        guard let serverResponse = response.response else {
            throw APIError.serverError(statusCode: 500)
        }
      
        // case no response value
        guard let value = response.value else {
            throw APIError.serverError(statusCode: serverResponse.statusCode)
        }
        
        // try to decode data to APIErrorResponse
        if let apiError: APIErrorResponse = try? JSONDecoder().decode(APIErrorResponse.self, from: value) {
//            if apiError.isAccessTokenExpired {
//                // retry fetch refresh token
//                try await authInterceptor.refreshToken()
//            }
//            if let authErorKey = apiError.authErorKey {
//                switch authErorKey {
//                case .accessTokenExpired:
//                    try await authInterceptor
//                        .retry(response.request,
//                               for: session,
//                               dueTo: apiError,
//                               completion: <#T##(RetryResult) -> Void#>
//                        )
//                default:
//                    break
//                }
//            }
            
            throw apiError
        }
        
        
        // try to decode to <T>
        if let decoded: T = try? JSONDecoder().decode(T.self, from: value) {
            return decoded
        }
        
        // try to decode data to String
        if let string: String = String(data: value, encoding: .utf8),
           string.count > 0 {
            throw APIError.unknownError(title: "Error",
                                        subtitle: string,
                                        underlying: nil)
        }
      
        
        print("error 500")
        throw APIError.serverError(statusCode: 500)
    }

    func handleResponseData(_ response: AFDataResponse<Data>) throws -> Data? {
        // case no response
        guard let serverResponse = response.response else {
            throw APIError.serverError(statusCode: 500)
        }
        
        // cast to Data
        guard let value = response.value else {
            throw APIError.serverError(statusCode: serverResponse.statusCode)
        }
        // try to decode data to APIErrorResponse
        if let apiError: APIErrorResponse = try? JSONDecoder().decode(APIErrorResponse.self, from: value) {
            throw apiError
        }
        
        if let error = response.error {
            print(error.localizedDescription)
            throw APIError.unexpectedError(error: error)
        }
                
        return value
    }

}
