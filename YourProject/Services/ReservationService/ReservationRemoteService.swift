//
//  ReservationRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol ReservationServiceProtocol: AnyObject {
    func fetchReservations(request: ReservationServiceRequest.FetchReservations) async throws -> Reservations
    func fetchReservation(request: ReservationServiceRequest.FetchReservation) async throws -> Reservation
    func createReservation(request: ReservationServiceRequest.CreateReservation) async throws -> Reservation
    func updateReservation(request: ReservationServiceRequest.UpdateReservation) async throws -> Reservation
    func deleteReservation(request: ReservationServiceRequest.DeleteReservation) async throws
    func checkIn(request: ReservationServiceRequest.CheckIn) async throws -> Reservation
    func checkOut(request: ReservationServiceRequest.CheckOut) async throws -> Reservation
}

class ReservationRemoteService: ReservationServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchReservations(request: ReservationServiceRequest.FetchReservations) async throws -> Reservations {
        let router = ReservationServiceRouter.fetchReservations(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchReservation(request: ReservationServiceRequest.FetchReservation) async throws -> Reservation {
        let router = ReservationServiceRouter.fetchReservation(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func createReservation(request: ReservationServiceRequest.CreateReservation) async throws -> Reservation {
        let router = ReservationServiceRouter.createReservation(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func updateReservation(request: ReservationServiceRequest.UpdateReservation) async throws -> Reservation {
        let router = ReservationServiceRouter.updateReservation(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func deleteReservation(request: ReservationServiceRequest.DeleteReservation) async throws {
        let router = ReservationServiceRouter.deleteReservation(request: request)
        try await apiManager.requestACK(router: router,
                                        requiredAuthorization: true)
    }
    
    func checkIn(request: ReservationServiceRequest.CheckIn) async throws -> Reservation {
        let router = ReservationServiceRouter.checkIn(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func checkOut(request: ReservationServiceRequest.CheckOut) async throws -> Reservation {
        let router = ReservationServiceRouter.checkOut(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
} 
