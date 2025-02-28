//
//  UserRouterService.swift
//  YourProject
//
//  Created by IntrodexMini on 28/2/2568 BE.
//

import Alamofire
import Foundation

enum UserRouterService: AlamofireBaseRouterProtocol {
    
    case fetchUsers(request: UserServiceRequest.FetchUsers)
    case fetchUser(request: UserServiceRequest.FetchUser)
    case createUser(request: UserServiceRequest.CreateUser)
    case updateUser(request: UserServiceRequest.UpdateUser)
    case deleteUser(request: UserServiceRequest.DeleteUser)
    case changeEmail(request: UserServiceRequest.ChangeEmail)
    case fetchNotificationSettings(request: UserServiceRequest.FetchNotificationSettings)
    case fetchUserDevices(request: UserServiceRequest.FetchUserDevices)
    case resendEmailLoginCode(request: UserServiceRequest.ResendEmailLoginCode)
    case emailLoginLink(request: UserServiceRequest.EmailLoginLink)
    case sendEmailLoginCode(request: UserServiceRequest.SendEmailLoginCode)
    case appleLoginLink(request: UserServiceRequest.AppleLoginLink)
    case fetchUserCompanies(request: UserServiceRequest.FetchUserCompanies)
    case changePassword(request: UserServiceRequest.ChangePassword)
    case updateUserProfile(request: UserServiceRequest.UpdateUserProfile)
    case fetchUserDetail(request: UserServiceRequest.FetchUserDetail)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchUsers(_):
            return "/api/v4/users"
        case .fetchUser(let request):
            return "/api/v4/users/\(request.id)"
        case .createUser(_):
            return "/api/v4/users"
        case .updateUser(let request):
            return "/api/v4/users/\(request.id)"
        case .deleteUser(let request):
            return "/api/v4/users/\(request.id)"
        case .changeEmail(_):
            return "/api/v4/users/change-email"
        case .fetchNotificationSettings(_):
            return "/api/v4/users/notification-settings"
        case .fetchUserDevices(_):
            return "/api/v4/users/devices"
        case .resendEmailLoginCode(_):
            return "/api/v4/users/email-login/resend-code"
        case .emailLoginLink(_):
            return "/api/v4/users/email-login/link"
        case .sendEmailLoginCode(_):
            return "/api/v4/users/email-login/send-code"
        case .appleLoginLink(_):
            return "/api/v4/users/apple-login/link"
        case .fetchUserCompanies(let request):
            return "/api/v4/users/\(request.userId)/companies"
        case .changePassword(let request):
            return "/api/v4/users/\(request.userId)/change-password"
        case .updateUserProfile(let request):
            return "/api/v4/users/\(request.userId)"
        case .fetchUserDetail(let request):
            return "/api/v4/users/\(request.userId)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchUsers(_), .fetchUser(_), .fetchNotificationSettings(_), .fetchUserDevices(_), .fetchUserCompanies(_), .fetchUserDetail(_):
            return .get
        case .createUser(_), .resendEmailLoginCode(_), .emailLoginLink(_), .sendEmailLoginCode(_), .appleLoginLink(_), .changeEmail(_):
            return .post
        case .updateUser(_), .updateUserProfile(_):
            return .put
        case .deleteUser(_):
            return .delete
        case .changePassword(_):
            return .put
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .createUser(_), .updateUser(_), .changeEmail(_), .resendEmailLoginCode(_), .emailLoginLink(_), .sendEmailLoginCode(_), .appleLoginLink(_), .changePassword(_), .updateUserProfile(_):
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "Accept": "application/json"]
        default:
            return ["Accept": "application/json"]
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchUsers(_), .fetchUser(_), .deleteUser(_), .fetchNotificationSettings(_), .fetchUserDevices(_), .fetchUserCompanies(_), .fetchUserDetail(_):
            return nil 
        case .createUser(let request):
            return request.asParameters()
        case .updateUser(let request):
            return request.asParameters()
        case .changeEmail(let request):
            return request.asParameters()
        case .resendEmailLoginCode(let request):
            return request.asParameters()
        case .emailLoginLink(let request):
            return request.asParameters()
        case .sendEmailLoginCode(let request):
            return request.asParameters()
        case .appleLoginLink(let request):
            return request.asParameters()
        case .changePassword(let request):
            return request.asParameters()
        case .updateUserProfile(let request):
            return request.asParameters()
        }
    }
    
    var body: Data? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: domain + path) else {
            throw APIError.invalidURL
        }
        let encoding: ParameterEncoding = (method == .get) ? URLEncoding.default : URLEncoding.httpBody
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