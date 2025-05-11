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
    func fetchGuestsByHotel(request: GuestServiceRequest.FetchGuests) async throws -> Paginator<Guest>
    func fetchGuestsByQuery(request: GuestServiceRequest.FetchGuestsQuery) async throws -> Paginator<Guest>
    func fetchGuestsByCompany(request: GuestServiceRequest.FetchGuestsCompany) async throws -> Paginator<Guest>
    func fetchGuestsByReservation(request: GuestServiceRequest.FetchGuestsReservation) async throws -> Paginator<Guest>
    func fetchGuestsByDatetimeOffset(request: GuestServiceRequest.FetchGuestsDatetimeOffset) async throws -> Paginator<Guest>

    func fetchGuest(request: GuestServiceRequest.FetchGuest) async throws -> Guest
    func createGuest(request: GuestServiceRequest.CreateGuest) async throws -> Guest
    func updateGuest(request: GuestServiceRequest.UpdateGuest) async throws -> Guest
    func deleteGuest(request: GuestServiceRequest.DeleteGuest) async throws
    func hideGuest(request: GuestServiceRequest.HideGuest) async throws -> Guest
    func unhideGuest(request: GuestServiceRequest.UnhideGuest) async throws -> Guest
    func removeGuestCompany(request: GuestServiceRequest.RemoveGuestCompany) async throws -> Guest
    func fetchGuestProfile(request: GuestServiceRequest.FetchGuestProfile) async throws -> GuestProfile
}

class GuestRemoteService: GuestServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchGuestsByHotel(request: GuestServiceRequest.FetchGuests) async throws -> Paginator<Guest> {
        let router = GuestRouterService.fetchGuestsByHotel(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuestsByQuery(request: GuestServiceRequest.FetchGuestsQuery) async throws -> Paginator<Guest> {
        let router = GuestRouterService.fetchGuestsByQuery(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuestsByCompany(request: GuestServiceRequest.FetchGuestsCompany) async throws -> Paginator<Guest> {
        let router = GuestRouterService.fetchGuestsByCompany(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuestsByReservation(request: GuestServiceRequest.FetchGuestsReservation) async throws -> Paginator<Guest> {
        let router = GuestRouterService.fetchGuestsByReservation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuestsByDatetimeOffset(request: GuestServiceRequest.FetchGuestsDatetimeOffset) async throws -> Paginator<Guest> {
        let router = GuestRouterService.fetchGuestsByDatetimeOffset(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuest(request: GuestServiceRequest.FetchGuest) async throws -> Guest {
        let router = GuestRouterService.fetchGuest(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createGuest(request: GuestServiceRequest.CreateGuest) async throws -> Guest {
        let router = GuestRouterService.createGuest(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateGuest(request: GuestServiceRequest.UpdateGuest) async throws -> Guest {
        let router = GuestRouterService.updateGuest(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func deleteGuest(request: GuestServiceRequest.DeleteGuest) async throws {
        let router = GuestRouterService.deleteGuest(request: request)
        try await apiManager.requestACK(router: router, requiredAuthorization: true)
    }
    
    func hideGuest(request: GuestServiceRequest.HideGuest) async throws -> Guest {
        let router = GuestRouterService.hideGuest(id: request.id)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func unhideGuest(request: GuestServiceRequest.UnhideGuest) async throws -> Guest {
        let router = GuestRouterService.unhideGuest(id: request.id)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func removeGuestCompany(request: GuestServiceRequest.RemoveGuestCompany) async throws -> Guest {
        let router = GuestRouterService.removeGuestCompany(id: request.id)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchGuestProfile(request: GuestServiceRequest.FetchGuestProfile) async throws -> GuestProfile {
        let router = GuestRouterService.fetchGuestProfile(id: request.id)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
}
