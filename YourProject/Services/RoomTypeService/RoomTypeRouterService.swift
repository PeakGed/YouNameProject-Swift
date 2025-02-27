//
//  RoomTypeRouterService.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

import Alamofire
import Foundation

enum RoomTypeRouterService: AlamofireBaseRouterProtocol {
    
    case fetchRoomTypes(request: RoomTypeServiceRequest.FetchRoomTypes)
    case fetchRoomType(request: RoomTypeServiceRequest.FetchRoomType)
    case createRoomType(request: RoomTypeServiceRequest.CreateRoomType)
    case updateRoomType(request: RoomTypeServiceRequest.UpdateRoomType)
    case deleteRoomType(request: RoomTypeServiceRequest.DeleteRoomType)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchRoomTypes(_):
            return "/api/v4/room-types"
        case .fetchRoomType(let request):
            return "/api/v4/room-types/\(request.id)"
        case .createRoomType(_):
            return "/api/v4/room-types"
        case .updateRoomType(let request):
            return "/api/v4/room-types/\(request.id)"
        case .deleteRoomType(let request):
            return "/api/v4/room-types/\(request.id)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchRoomTypes(_), .fetchRoomType(_):
            return .get
        case .createRoomType(_):
            return .post
        case .updateRoomType(_):
            return .put
        case .deleteRoomType(_):
            return .delete
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .createRoomType(_), .updateRoomType(_):
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "Accept": "application/json"]
        default:
            return ["Accept": "application/json"]
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchRoomTypes(_), .fetchRoomType(_), .deleteRoomType(_):
            return nil 
        case .createRoomType(let request):
            return request.asParameters()
        case .updateRoomType(let request):
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
