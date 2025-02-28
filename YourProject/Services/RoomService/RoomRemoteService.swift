//
//  RoomRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol RoomServiceProtocol: AnyObject {
    func fetchRooms(request: RoomServiceRequest.FetchRooms) async throws -> Rooms
    func fetchRoomDetail(request: RoomServiceRequest.FetchRoomDetail) async throws -> Room
    func createRoom(request: RoomServiceRequest.CreateRoom) async throws -> Room
    func updateRoom(request: RoomServiceRequest.UpdateRoom) async throws -> Room
    func deleteRoom(request: RoomServiceRequest.DeleteRoom) async throws
    func changeRoomType(request: RoomServiceRequest.ChangeRoomType) async throws -> Room
    
    func batchCreateRooms(request: RoomServiceRequest.BatchCreateRooms) async throws -> Rooms
    func batchDeleteRooms(request: RoomServiceRequest.BatchDeleteRooms) async throws
}

class RoomRemoteService: RoomServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchRooms(request: RoomServiceRequest.FetchRooms) async throws -> Rooms {
        let router = RoomRouterService.fetchRooms(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchRoomDetail(request: RoomServiceRequest.FetchRoomDetail) async throws -> Room {
        let router = RoomRouterService.fetchRoomDetail(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func createRoom(request: RoomServiceRequest.CreateRoom) async throws -> Room {
        let router = RoomRouterService.createRoom(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func updateRoom(request: RoomServiceRequest.UpdateRoom) async throws -> Room {
        let router = RoomRouterService.updateRoom(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func deleteRoom(request: RoomServiceRequest.DeleteRoom) async throws {
        let router = RoomRouterService.deleteRoom(request: request)
        try await apiManager.requestACK(router: router,
                                        requiredAuthorization: true)
    }
    
    func changeRoomType(request: RoomServiceRequest.ChangeRoomType) async throws -> Room {
        let router = RoomRouterService.changeRoomType(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func batchCreateRooms(request: RoomServiceRequest.BatchCreateRooms) async throws -> Rooms {
        let router = RoomRouterService.batchCreateRooms(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func batchDeleteRooms(request: RoomServiceRequest.BatchDeleteRooms) async throws {
        let router = RoomRouterService.batchDeleteRooms(request: request)
        try await apiManager.requestACK(router: router,
                                        requiredAuthorization: true)
    }
} 
