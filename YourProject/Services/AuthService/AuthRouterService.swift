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
    case refreshToken(request: AuthServiceRequest.TokenRefresh)
    case register
    case resetPassword
    case resendEmailConfirmation(request: AuthServiceRequest.ResendEmailConfirmation)
    case passwordReset(request: AuthServiceRequest.PasswordReset)
    case signup(request: AuthServiceRequest.Signup)

    var domain: String {
        return AppConfiguration.shared.baseURL
    }

    var path: String {
        switch self {
        case .emailLogin(_):
            return "/v4/auth/login"
        case .appleIdLogin(_):
            return "/v4/auth/login/apple"
        case .logout:
            return "/v4/auth/logout"
        case .refreshToken:
            return "/v4/auth/refresh"
        case .register:
            return "/v4/auth/register"
        case .resetPassword:
            return "/v4/auth/reset-password"
        case .resendEmailConfirmation:
            return "/v4/auth/resend_email_confirmation"
        case .passwordReset:
            return "/v4/auth/password_reset"
        case .signup:
            return "/v4/auth/signup"
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
        case .resendEmailConfirmation:
            return .post
        case .passwordReset:
            return .post
        case .signup:
            return .post
        }
    }

    var headers: [String: String]? {
        return nil
    }

    var parameters: [String: Any]? {
       switch self {
            case .emailLogin(let request):
           return ["username": request.username,
                   "password": request.password]
        case .refreshToken(let request):
           return ["refresh_token": request.token]
        case .resendEmailConfirmation(let request):
            return ["email": request.email]
        case .passwordReset(let request):
            return ["email": request.email]
        case .signup(let request):
            var params: [String: Any] = [
                "email": request.email,
                "password": request.password
            ]
            
            if let firstName = request.firstName {
                params["first_name"] = firstName
            }
            
            if let lastName = request.lastName {
                params["last_name"] = lastName
            }
            
            if let phoneNumber = request.phoneNumber {
                params["phone_number"] = phoneNumber
            }
            
            if let pinCode = request.pinCode {
                params["pin_code"] = pinCode
            }
            
            return params
        default:
            return nil
        }
    }

    var body: Data? {
        return nil
    }

    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: domain + path) else {
            throw APIError.invalidURL
        }
        //let encoding: ParameterEncoding = (method == .get) ? URLEncoding.default : JSONEncoding.default
        let encoding: ParameterEncoding = URLEncoding.default
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
