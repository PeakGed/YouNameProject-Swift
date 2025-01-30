//
//  APIManager.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//

import Foundation
import Alamofire

enum APIError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case serverError(Int)
    case unknownError
}

enum AuthorizationType {
    case none
    case bearer
    // Add other types if needed, like:
    // case basic(username: String, password: String)
    // case custom(String)
}

// Add this protocol before the APIManager class
protocol AlamofireBaseRouterProtocol {
    func asURLRequest() throws -> URLRequest
}

class APIManager {
    static let shared = APIManager()
    
    private var session: Session
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30  // 30 seconds timeout
        configuration.timeoutIntervalForResource = 300  // 5 minutes
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let interceptor = RequestInterceptor()
        
        self.session = Session(
            configuration: configuration,
            interceptor: interceptor
        )
    }
    
    func request<T: Codable>(
        router: AlamofireBaseRouterProtocol,
        authType: AuthorizationType = .bearer
    ) async throws -> T {
        let urlRequest = try router.asURLRequest()
        
        let request = session.request(urlRequest)
            .authenticate(with: authType)
        
        return try await withCheckedThrowingContinuation { continuation in
            request.responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                    
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        continuation.resume(throwing: APIError.serverError(statusCode))
                    } else {
                        continuation.resume(throwing: APIError.networkError(error))
                    }
                }
            }
        }
    }
    
    func request(
        router: AlamofireBaseRouterProtocol,
        authType: AuthorizationType = .bearer,
        expectedStatusCodes: Range<Int> = 200..<300
    ) async throws {
        let urlRequest = try router.asURLRequest()
        
        let request = session.request(urlRequest)
            .authenticate(with: authType)
            .validate(statusCode: expectedStatusCodes)
        
        return try await withCheckedThrowingContinuation { continuation in
            request.response { response in
                switch response.result {
                case .success:
                    continuation.resume()
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        continuation.resume(throwing: APIError.serverError(statusCode))
                    } else {
                        continuation.resume(throwing: APIError.networkError(error))
                    }
                }
            }
        }
    }

    
    func request<T: Codable>(
        url: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        authType: AuthorizationType = .bearer
    ) async throws -> T {
        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        let request = session.request(
            url,
            method: method,
            parameters: parameters,
            headers: headers
        )
        .authenticate(with: authType)
        
        return try await withCheckedThrowingContinuation { continuation in
            request.responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    continuation.resume(returning: value)
                    
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        continuation.resume(throwing: APIError.serverError(statusCode))
                    } else {
                        continuation.resume(throwing: APIError.networkError(error))
                    }
                }
            }
        }
    }
}

// Extend Request to handle authentication
extension Request {
    func authenticate(with type: AuthorizationType) -> Self {
        switch type {
        case .none:
            return self
        case .bearer:
            if let token = UserDefaults.standard.string(forKey: "accessToken") {
                return self.authenticate(username: token, password: "")
            }
            return self
        }
    }
}

// Update RequestInterceptor to handle common headers only
class RequestInterceptor: Alamofire.RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        
        // Add common headers here
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // Handle retry logic here if needed
        completion(.doNotRetry)
    }
}

