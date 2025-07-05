//
//  CalendarAvailabilityRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 14/6/2568 BE.
//
import Foundation
import Mockable

@Mockable
protocol CalendarAvailabilityServiceProtocol: AnyObject {
    func fetchAvailability(request: CalendarAvailabilityServiceRequest.FetchAvailability) async throws -> CalendarAvailability
}

class CalendarAvailabilityRemoteService: CalendarAvailabilityServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchAvailability(request: CalendarAvailabilityServiceRequest.FetchAvailability) async throws -> CalendarAvailability {
        let router = CalendarAvailabilityServiceRouter.fetchAvailability(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 