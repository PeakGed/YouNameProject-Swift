//
//  StaffRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol GuestServiceProtocol: AnyObject {
    func fetchGuests(request: GuestServiceRequest.FetchGuests) async throws -> Paginator<Guest>
    func fetchGuestsQuery(request: GuestServiceRequest.FetchGuestsQuery) async throws -> Paginator<Guest>
    func fetchGuestsCompany(request: GuestServiceRequest.FetchGuestsCompany) async throws -> Paginator<Guest>
    func fetchGuestsReservation(request: GuestServiceRequest.FetchGuestsReservation) async throws -> Paginator<Guest>
    func fetchGuestsDatetimeOffset(request: GuestServiceRequest.FetchGuestsDatetimeOffset) async throws -> Paginator<Guest>
    func fetchGuest(id: Int) async throws -> Guest
    func createGuest(request: GuestServiceRequest.CreateGuest) async throws -> Guest
    func updateGuest(id: Int, request: GuestServiceRequest.UpdateGuest) async throws -> Guest
    func deleteGuest(id: Int) async throws
}

class GuestRemoteService: GuestServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchGuests(request: GuestServiceRequest.FetchGuests) async throws -> Paginator<Guest> {
        let router = GuestRouterService.fetchGuests(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuestsQuery(request: GuestServiceRequest.FetchGuestsQuery) async throws -> Paginator<Guest> {
        let router = GuestRouterService.fetchGuestsQuery(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuestsCompany(request: GuestServiceRequest.FetchGuestsCompany) async throws -> Paginator<Guest> {
        let router = GuestRouterService.fetchGuestsCompany(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuestsReservation(request: GuestServiceRequest.FetchGuestsReservation) async throws -> Paginator<Guest> {
        let router = GuestRouterService.fetchGuestsReservation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuestsDatetimeOffset(request: GuestServiceRequest.FetchGuestsDatetimeOffset) async throws -> Paginator<Guest> {
        let router = GuestRouterService.fetchGuestsDatetimeOffset(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuest(id: Int) async throws -> Guest {
        let router = GuestRouterService.fetchGuest(id: id)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createGuest(request: GuestServiceRequest.CreateGuest) async throws -> Guest {
        let router = GuestRouterService.createGuest(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateGuest(id: Int, request: GuestServiceRequest.UpdateGuest) async throws -> Guest {
        let router = GuestRouterService.updateGuest(id: id, request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteGuest(id: Int) async throws {
        let router = GuestRouterService.deleteGuest(id: id)
        try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
}
