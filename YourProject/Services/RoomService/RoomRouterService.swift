//
//  RoomRouterService.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//

import Alamofire
import Foundation

enum RoomRouterService: AlamofireBaseRouterProtocol {
    
    case fetchRooms(request: RoomServiceRequest.FetchRooms)
    case fetchRoomDetail(request: RoomServiceRequest.FetchRoomDetail)
    case createRoom(request: RoomServiceRequest.CreateRoom)
    case updateRoom(request: RoomServiceRequest.UpdateRoom)
    case deleteRoom(request: RoomServiceRequest.DeleteRoom)
    case changeRoomType(request: RoomServiceRequest.ChangeRoomType)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchRooms(_):
            return "/api/v4/rooms"
        case .fetchRoomDetail(let request):
            return "/api/v4/rooms/\(request.id)"
        case .createRoom(_):
            return "/api/v4/rooms"
        case .updateRoom(let request):
            return "/api/v4/rooms/\(request.id)"
        case .deleteRoom(let request):
            return "/api/v4/rooms/\(request.id)"
        case .changeRoomType(let request):
            return "/api/v4/rooms/\(request.id)/change_room_type"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchRooms(_), .fetchRoomDetail(_):
            return .get
        case .createRoom(_), .changeRoomType(_):
            return .post
        case .updateRoom(_):
            return .put
        case .deleteRoom(_):
            return .delete
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .createRoom(_), .updateRoom(_), .changeRoomType(_):
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "Accept": "application/json"]
        case .fetchRoomDetail(_):
            return ["Accept": "application/json"]
        default:
            return nil
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchRooms(let request):
            return nil 
        case .fetchRoomDetail(_):
            return nil
        case .createRoom(let request):
            return request.asParameters()
        case .updateRoom(let request):
            return request.asParameters()
        case .deleteRoom(_):
            return nil
        case .changeRoomType(let request):
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
        let encoding: ParameterEncoding = (method == .get) ? URLEncoding.default : URLEncoding.default
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
