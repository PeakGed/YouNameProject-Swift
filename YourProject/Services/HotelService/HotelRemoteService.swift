//
//  HotelRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol HotelServiceProtocol: AnyObject {
    func fetchHotels(request: HotelServiceRequest.FetchHotels) async throws -> Hotels
    func createHotel(request: HotelServiceRequest.CreateHotel) async throws -> Hotel
    func updateHotel(request: HotelServiceRequest.UpdateHotel) async throws -> Hotel
}

class HotelRemoteService: HotelServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchHotels(request: HotelServiceRequest.FetchHotels) async throws -> Hotels {
        let router = HotelRouterService.fetchHotels(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func createHotel(request: HotelServiceRequest.CreateHotel) async throws -> Hotel {
        let router = HotelRouterService.createHotel(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func updateHotel(request: HotelServiceRequest.UpdateHotel) async throws -> Hotel {
        let router = HotelRouterService.updateHotel(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
} 
