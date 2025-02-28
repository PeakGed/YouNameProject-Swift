//
//  StaffRouterService.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

import Alamofire
import Foundation

enum StaffRouterService: AlamofireBaseRouterProtocol {
    
    case fetchStaffs(request: StaffServiceRequest.FetchStaffs)
    case fetchStaff(request: StaffServiceRequest.FetchStaff)
    case createStaff(request: StaffServiceRequest.CreateStaff)
    case updateStaff(request: StaffServiceRequest.UpdateStaff)
    case deleteStaff(request: StaffServiceRequest.DeleteStaff)
    case changeHotel(request: StaffServiceRequest.ChangeHotel)
    case changePassword(request: StaffServiceRequest.ChangePassword)
    case updateStaffDetails(request: StaffServiceRequest.UpdateStaffDetails)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchStaffs(_):
            return "/api/v4/staffs"
        case .fetchStaff(let request):
            return "/api/v4/staffs/\(request.id)"
        case .createStaff(_):
            return "/api/v4/staffs"
        case .updateStaff(let request):
            return "/api/v4/staffs/\(request.id)"
        case .deleteStaff(let request):
            return "/api/v4/staffs/\(request.id)"
        case .changeHotel(let request):
            return "/api/v4/staffs/\(request.id)/change-hotel"
        case .changePassword(let request):
            return "/api/v4/staffs/\(request.id)/change-password"
        case .updateStaffDetails(let request):
            return "/api/v4/staffs/\(request.id)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchStaffs(_), .fetchStaff(_):
            return .get
        case .createStaff(_):
            return .post
        case .updateStaff(_), .changeHotel(_), .changePassword(_), .updateStaffDetails(_):
            return .put
        case .deleteStaff(_):
            return .delete
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .createStaff(_), .updateStaff(_), .changeHotel(_), .changePassword(_), .updateStaffDetails(_):
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "Accept": "application/json"]
        default:
            return ["Accept": "application/json"]
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchStaffs(_), .fetchStaff(_), .deleteStaff(_):
            return nil 
        case .createStaff(let request):
            return request.asParameters()
        case .updateStaff(let request):
            return request.asParameters()
        case .changeHotel(let request):
            return request.asParameters()
        case .changePassword(let request):
            return request.asParameters()
        case .updateStaffDetails(let request):
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