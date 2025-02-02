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
        
        return try handleResponse(response)
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
}
