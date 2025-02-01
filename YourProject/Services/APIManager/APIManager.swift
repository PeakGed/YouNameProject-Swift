//
//  APIManager.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//

import Foundation
import Alamofire

enum APIError: Error, LocalizedError {
    case invalidURL
    case unauthorized(error: APIAuthErrorResponse)
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

// Add this protocol before the APIManager class
protocol AlamofireBaseRouterProtocol {
    func asURLRequest() throws -> URLRequest
}

protocol APIManagerProtocol: AnyObject {
    
    func request<T>(
        _ url: String,
        method: HTTPMethod,
        parameters: Parameters?,
        requiredAuthorization: Bool
    ) async throws -> T where T: Decodable
    
    func request<T>(
        router: AlamofireBaseRouterProtocol,
        requiredAuthorization: Bool
    ) async throws -> T where T: Decodable

//    func requestACK(
//        router: AlamofireBaseRouterProtocol,
//        requiredAuthorization: Bool
//    ) async throws
//
//    func requestData(
//        router: AlamofireBaseRouterProtocol,
//        requiredAuthorization: Bool
//    ) async throws -> Data?
//
//    func request<T: Codable>(
//        url: String,
//        method: HTTPMethod,
//        parameters: Parameters?,
//        headers: HTTPHeaders?,
//        requiredAuthorization: Bool
//    ) async throws -> T
//
    func setCredential(auth: AuthTokenResponse)
    func resetCredential()
}

class APIManager {
    static let shared = APIManager()
    
    var baseURL: String {
        AppConfiguration.shared.baseURL
    }
    
    private var session: Session
    private var authSession: Session
    
    private var localStorageManager: LocalStorageManagerProtocal
    
    init(localStorageManager: LocalStorageManagerProtocal = LocalStorageManager()) {
        self.localStorageManager = localStorageManager
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30  // 30 seconds timeout
        configuration.timeoutIntervalForResource = 300  // 5 minutes
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let authInterceptor = AuthInterceptor()
        self.authSession = Session(
            configuration: configuration,
            interceptor: authInterceptor
        )
        
        self.session = Session(configuration: configuration)
    }
    
    /// Generic request handler
    func request<T: Decodable>(
        _ url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        requiredAuthorization: Bool = true
    ) async throws -> T {
        let session = self.session(requiredAuthorization: requiredAuthorization)
        let reqPath = fullPath(path: url)
        
        let response = await session.request(reqPath,
                                             method: method,
                                             parameters: parameters,
                                             encoding: encoding)
            .serializingData()
            .response
        
        // case no response
        guard let serverResponse = response.response else {
            throw APIError.serverError(statusCode: 500)
        }
        
        // case no response value
        guard let value = response.value else {
            throw APIError.serverError(statusCode: serverResponse.statusCode)
        }
        
        // try to decode to <T>
        if let decoded: T = try? JSONDecoder().decode(T.self, from: value) {
            return decoded
        }
        
        // try to decode data to APIErrorResponse
        if let apiError: APIErrorResponse = try? JSONDecoder().decode(APIErrorResponse.self, from: value) {
            throw apiError
        }
        
        // try to decode data to String
        if let string: String = String(data: value, encoding: .utf8),
           string.count > 0 {
            throw APIError.unknownError(title: "Error",
                                      subtitle: string,
                                      underlying: nil)
        }
        
        if let error = response.error {
            print(error.localizedDescription)
            throw APIError.unexpectedError(error: error)
        }
        
        print("error 500")
        throw APIError.serverError(statusCode: 500)
    }
    
    func request<T: Codable>(
        router: AlamofireBaseRouterProtocol,
        requiredAuthorization: Bool = true
    ) async throws -> T {
        var urlRequest = try router.asURLRequest()
        let request: DataRequest
        
        if requiredAuthorization {
            guard let accessToken = localStorageManager.accessToken else {
                throw AuthenticationError.missingCredential
            }
            //urlRequest = urlRequest
                //.authenticate(with: .bearer(token: accessToken))
            
            request = session
                .request(urlRequest)
        } else {
            request = session.request(urlRequest)
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            request.responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                    
                case .failure(let error):
                    // Logs
                    print(response.debugDescription)
                    print(String(data: response.data ?? Data(), encoding: .utf8) ?? "No data")
                    print(response.response?.allHeaderFields ?? [:])
                    print(response.response?.url ?? URL(string: "")!)
                    print(response.response?.statusCode ?? 0)
                    print(response.error ?? NSError(domain: "", code: 0, userInfo: nil))
                    
                    guard
                        let httpCode = response.response?.statusCode,
                        let respData = response.data
                    else {
                        continuation.resume(throwing: error)
                        return
                    }
                    
                    //case 401
                    switch httpCode {
                    case 401:
                        //self.localStorageManager.accessToken = nil
                        do {
                            if let authError = try? JSONDecoder().decode(APIAuthErrorResponse.self, from: respData) {
                                continuation.resume(throwing: APIError.unauthorized(error: authError))
                            } else {
                                continuation.resume(throwing: error)
                            }
                        }
                    default:
                        do {
                            if let apiError = try? JSONDecoder().decode(APIErrorResponse.self, from: respData) {
                                continuation.resume(throwing: APIError.httpError(error: apiError))
                            } else {
                                continuation.resume(throwing: error)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
//    func requestACK(
//        router: AlamofireBaseRouterProtocol,
//        requiredAuthorization: Bool = true,
//        expectedStatusCodes: Range<Int> = 200..<300
//    ) async throws {
//        let urlRequest = try router.asURLRequest()
//        
//        if requiredAuthorization {
//            guard 
//            let accessToken = localStorageManager.accessToken else {
//                throw APIError.unauthorized
//            }
//            
//            let authType = AuthorizationType.bearer(token: accessToken)
//            let request = session.request(urlRequest)
//                .authenticate(with: authType)
//        } else {
//            let request = session.request(urlRequest)
//        }
//            .validate(statusCode: expectedStatusCodes)
//        
//        return try await withCheckedThrowingContinuation { continuation in
//            request.response { response in
//                switch response.result {
//                case .success:
//                    continuation.resume()
//                case .failure(let error):
//                    if let statusCode = response.response?.statusCode {
//                        continuation.resume(throwing: APIError.serverError(statusCode))
//                    } else {
//                        continuation.resume(throwing: APIError.networkError(error))
//                    }
//                }
//            }
//        }
//    }
//
//    func requestData(
//        router: AlamofireBaseRouterProtocol,
//        requiredAuthorization: Bool = true,
//        expectedStatusCodes: Range<Int> = 200..<300
//    ) async throws -> Data? {
//        let urlRequest = try router.asURLRequest()
//        
//        if requiredAuthorization {
//            guard 
//            let accessToken = localStorageManager.accessToken else {
//                throw APIError.unauthorized
//            }
//            
//            let authType = AuthorizationType.bearer(token: accessToken)
//            let request = session.request(urlRequest)
//                .authenticate(with: authType)
//        } else {
//            let request = session.request(urlRequest)
//        }
//            .validate(statusCode: expectedStatusCodes)
//        
//        return try await withCheckedThrowingContinuation { continuation in
//            request.response { response in
//                switch response.result {
//                case .success(let data):
//                    continuation.resume(returning: data)
//                case .failure(let error):
//                    if let statusCode = response.response?.statusCode {
//                        continuation.resume(throwing: APIError.serverError(statusCode))
//                    } else {
//                        continuation.resume(throwing: APIError.networkError(error))
//                    }
//                }
//            }
//        }
//    }
//
//    
//    func request<T: Codable>(
//        url: String,
//        method: HTTPMethod = .get,
//        parameters: Parameters? = nil,
//        headers: HTTPHeaders? = nil,
//        requiredAuthorization: Bool = true,
//    ) async throws -> T {
//        guard let url = URL(string: url) else {
//            throw APIError.invalidURL
//        }
//
//        if requiredAuthorization {
//            let authType = AuthorizationType.bearer(token: localStorageManager.accessToken)
//            let request = session.request(
//                url,
//                method: method,
//                parameters: parameters,
//                headers: headers
//            )
//                .authenticate(with: authType)
//        } else {
//            let request = session.request(
//                url,
//                method: method,
//                parameters: parameters,
//                headers: headers
//            )
//        return try await withCheckedThrowingContinuation { continuation in
//            request.responseDecodable(of: T.self) { response in
//                switch response.result {
//                case .success(let value):
//                    continuation.resume(returning: value)
//                    
//                case .failure(let error):
//                    if let statusCode = response.response?.statusCode {
//                        continuation.resume(throwing: APIError.serverError(statusCode))
//                    } else {
//                        continuation.resume(throwing: APIError.networkError(error))
//                    }
//                }
//            }
//        }
//    }
//    
    func setCredential(auth: AuthTokenResponse) {
        localStorageManager.accessToken = auth.accessToken
        localStorageManager.refreshToken = auth.refreshToken
    }
    
    func resetCredential() {
        localStorageManager.accessToken = nil
        localStorageManager.refreshToken = nil
    }
}

private extension APIManager {
    func isAuthenticated() -> Bool {
        return localStorageManager.accessToken != nil
    }
    
    func handleFailure(
        response: DataResponse<Decodable, AFError>,
        continuation: CheckedContinuation<Decodable, Error>
    ) {
        if let statusCode = response.response?.statusCode {
            continuation.resume(throwing: APIError.serverError(statusCode: statusCode))
        } else {
            continuation.resume(throwing: APIError.networkError(error: response.error!))
        }
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
}
