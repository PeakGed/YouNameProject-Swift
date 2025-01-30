//
//  LoginService.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//

import Alamofire
import Foundation

enum AuthRouterService: AlamofireBaseRouterProtocol {
    
    case emailLogin(request: AuthServiceRequest.EmailLogin)
    case appleIdLogin(request: AuthServiceRequest.AppleIdLogin)
    case logout
    case refreshToken
    case register
    case resetPassword

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .emailLogin(let request):
            return "/v4/auth/login"
        case .appleIdLogin(let req):
            return "/v4/auth/login/apple"
        case .logout:
            return "/v4/auth/logout"
        case .refreshToken:
            return "/v4/auth/refresh"
        case .register:
            return "/v4/auth/register"
        case .resetPassword:
            return "/v4/auth/reset-password"
        }
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .emailLogin,
             .appleIdLogin:
            return .post
        case .logout:
            return .post
        case .refreshToken:
            return .post
        case .register:
            return .post
        case .resetPassword:
            return .post
        
        }
    }

    var headers: [String: String]? {
        switch self {
        case .emailLogin, 
        .appleIdLogin:
            return nil
        default:
            return nil
        }
    }

    var parameters: [String: Any]? {
       return nil
    }

    var body: Data? {
        switch self {
        case .emailLogin(let request):
            return request.body
        default:
            return nil
        }
    }

    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: domain + path) else {
            throw APIError.invalidURL
        }
        let encoding: ParameterEncoding = (method == .get) ? URLEncoding.default : JSONEncoding.default
        var request = URLRequest(url: url)

        request.httpMethod = method.rawValue
        request.httpBody = body

        headers?.forEach {
            request.addValue($0.value,
                             forHTTPHeaderField: $0.key)
        }

        return try encoding.encode(request,
                                   with: parameters)
    }
}
