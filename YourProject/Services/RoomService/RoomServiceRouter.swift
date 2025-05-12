//
//  RoomServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//

import Alamofire
import Foundation

enum RoomServiceRouter: AlamofireBaseRouterProtocol {
    
    case fetchRooms(request: RoomServiceRequest.FetchRooms)
    case fetchRoom(request: RoomServiceRequest.FetchRoom)
    case createRoom(request: RoomServiceRequest.CreateRoom)
    case updateRoom(request: RoomServiceRequest.UpdateRoom)
    case deleteRoom(request: RoomServiceRequest.DeleteRoom)
    case changeRoomType(request: RoomServiceRequest.ChangeRoomType)
    case batchCreateRooms(request: RoomServiceRequest.BatchCreateRooms)
    case batchDeleteRooms(request: RoomServiceRequest.BatchDeleteRooms)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchRooms(_):
            return "/api/v4/rooms"
        case .fetchRoom(let request):
            return "/api/v4/rooms/\(request.id)"
        case .createRoom(_):
            return "/api/v4/rooms"
        case .updateRoom(let request):
            return "/api/v4/rooms/\(request.id)"
        case .deleteRoom(let request):
            return "/api/v4/rooms/\(request.id)"
        case .changeRoomType(let request):
            return "/api/v4/rooms/\(request.id)/change_room_type"
        case .batchCreateRooms(_):
            return "/api/v4/rooms/batch_create"
        case .batchDeleteRooms(_):
            return "/api/v4/rooms/batch_delete"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchRooms(_), .fetchRoom(_):
            return .get
        case .createRoom(_), .changeRoomType(_), .batchCreateRooms(_):
            return .post
        case .updateRoom(_):
            return .put
        case .deleteRoom(_), .batchDeleteRooms(_):
            return .delete
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case .createRoom(let request):
            return try? JSONEncoder().encode(request)
        case .updateRoom(let request):
            return try? JSONEncoder().encode(request)
        case .changeRoomType(let request):
            return try? JSONEncoder().encode(request)
        case .batchCreateRooms(let request):
            return try? JSONEncoder().encode(request)
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
