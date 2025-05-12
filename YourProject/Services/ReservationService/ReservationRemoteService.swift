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
    func fetchReservations(request: ReservationServiceRequest.FetchReservations) async throws -> Paginator<Reservations>
    func fetchReservationsByFlags(request: ReservationServiceRequest.FetchReservationsByFlags) async throws -> Paginator<Reservations>
    func fetchReservationsByGuest(request: ReservationServiceRequest.FetchReservationsByGuest) async throws -> Paginator<Reservations>
    func fetchReservationsByCompany(request: ReservationServiceRequest.FetchReservationsByCompany) async throws -> Paginator<Reservations>
    func fetchReservationsByPeriod(request: ReservationServiceRequest.FetchReservationsByPeriod) async throws -> Paginator<Reservations>
    func fetchReservationsByCreatedAt(request: ReservationServiceRequest.FetchReservationsByCreatedAt) async throws -> Paginator<Reservations>
    func fetchReservationsByTags(request: ReservationServiceRequest.FetchReservationsByTags) async throws -> Paginator<Reservations>
    func fetchReservationsByKeyword(request: ReservationServiceRequest.FetchReservationsByKeyword) async throws -> Paginator<Reservations>
    func fetchReservationsByBatchIds(request: ReservationServiceRequest.FetchReservationsByBatchIds) async throws -> Paginator<Reservations>
    func fetchReservationByUid(request: ReservationServiceRequest.FetchReservationByUid) async throws -> Reservation
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
    
    func fetchReservations(request: ReservationServiceRequest.FetchReservations) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservations(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchReservationsByFlags(request: ReservationServiceRequest.FetchReservationsByFlags) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservationsByFlags(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchReservationsByGuest(request: ReservationServiceRequest.FetchReservationsByGuest) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservationsByGuest(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchReservationsByCompany(request: ReservationServiceRequest.FetchReservationsByCompany) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservationsByCompany(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchReservationsByPeriod(request: ReservationServiceRequest.FetchReservationsByPeriod) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservationsByPeriod(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchReservationsByCreatedAt(request: ReservationServiceRequest.FetchReservationsByCreatedAt) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservationsByCreatedAt(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchReservationsByTags(request: ReservationServiceRequest.FetchReservationsByTags) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservationsByTags(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchReservationsByKeyword(request: ReservationServiceRequest.FetchReservationsByKeyword) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservationsByKeyword(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchReservationsByBatchIds(request: ReservationServiceRequest.FetchReservationsByBatchIds) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservationsByBatchIds(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func fetchReservationByUid(request: ReservationServiceRequest.FetchReservationByUid) async throws -> Reservation {
        let router = ReservationServiceRouter.fetchReservationByUid(request: request)
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
