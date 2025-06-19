//
//  ReservationRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation
import Mockable

@Mockable
protocol ReservationServiceProtocol: AnyObject {
    // MARK: - Fetch Methods
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
    func fetchReservation(request: ReservationServiceRequest.FetchById) async throws -> Reservation
    
    // MARK: - CM Endpoints
    func fetchReservationByCMBooking(request: ReservationServiceRequest.FetchReservationByCMBooking) async throws -> Reservation
    func createReservationByCMBooking(request: ReservationServiceRequest.CreateReservationByCMBooking) async throws -> Reservation
    
    // MARK: - CRUD Operations
    func createReservation(request: ReservationServiceRequest.CreateReservation) async throws -> Reservation
    func updateReservation(request: ReservationServiceRequest.UpdateReservation) async throws -> Reservation
    
    // MARK: - Status Change Operations
    func checkIn(request: ReservationServiceRequest.CheckIn) async throws -> Reservation
    func checkOut(request: ReservationServiceRequest.CheckOut) async throws -> Reservation
    func cancel(request: ReservationServiceRequest.Cancel) async throws -> Reservation
    func noShow(request: ReservationServiceRequest.NoShow) async throws -> Reservation
    
    // MARK: - Customer Management
    func getFirstGuest(request: ReservationServiceRequest.SetFirstGuest) async throws -> Reservation
    func dropCustomer(request: ReservationServiceRequest.DropCustomer) async throws -> Reservation
    func appendCustomer(request: ReservationServiceRequest.AppendCustomer) async throws -> Reservation
    func replaceCustomers(request: ReservationServiceRequest.ReplaceCustomers) async throws -> Reservation
    
    // MARK: - Additional Operations
    func fetchConfirmation(request: ReservationServiceRequest.FetchConfirmation) async throws -> RerservationServiceResponse.ConfirmationInfo
    func createConfirmation(request: ReservationServiceRequest.CreateConfirmation) async throws -> RerservationServiceResponse.ConfirmationInfo
    func splitReservation(request: ReservationServiceRequest.SplitReservation) async throws -> Reservations
}

class ReservationRemoteService: ReservationServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    // MARK: - Fetch Methods
    
    func fetchReservations(request: ReservationServiceRequest.FetchReservations) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservations(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchReservationsByFlags(request: ReservationServiceRequest.FetchReservationsByFlags) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservationsByFlags(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchReservationsByGuest(request: ReservationServiceRequest.FetchReservationsByGuest) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservationsByGuest(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchReservationsByCompany(request: ReservationServiceRequest.FetchReservationsByCompany) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservationsByCompany(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchReservationsByPeriod(request: ReservationServiceRequest.FetchReservationsByPeriod) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservationsByPeriod(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchReservationsByCreatedAt(request: ReservationServiceRequest.FetchReservationsByCreatedAt) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservationsByCreatedAt(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchReservationsByTags(request: ReservationServiceRequest.FetchReservationsByTags) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservationsByTags(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchReservationsByKeyword(request: ReservationServiceRequest.FetchReservationsByKeyword) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservationsByKeyword(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchReservationsByBatchIds(request: ReservationServiceRequest.FetchReservationsByBatchIds) async throws -> Paginator<Reservations> {
        let router = ReservationServiceRouter.fetchReservationsByBatchIds(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchReservationByUid(request: ReservationServiceRequest.FetchReservationByUid) async throws -> Reservation {
        let router = ReservationServiceRouter.fetchReservationByUid(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func fetchReservation(request: ReservationServiceRequest.FetchById) async throws -> Reservation {
        let router = ReservationServiceRouter.fetchReservation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    // MARK: - CM Endpoints
    
    func fetchReservationByCMBooking(request: ReservationServiceRequest.FetchReservationByCMBooking) async throws -> Reservation {
        let router = ReservationServiceRouter.fetchReservationByCMBooking(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createReservationByCMBooking(request: ReservationServiceRequest.CreateReservationByCMBooking) async throws -> Reservation {
        let router = ReservationServiceRouter.createReservationByCMBooking(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }        
    
    // MARK: - CRUD Operations
    
    func createReservation(request: ReservationServiceRequest.CreateReservation) async throws -> Reservation {
        let router = ReservationServiceRouter.createReservation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateReservation(request: ReservationServiceRequest.UpdateReservation) async throws -> Reservation {
        let router = ReservationServiceRouter.updateReservation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    // MARK: - Status Change Operations
    
    func checkIn(request: ReservationServiceRequest.CheckIn) async throws -> Reservation {
        let router = ReservationServiceRouter.checkIn(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func checkOut(request: ReservationServiceRequest.CheckOut) async throws -> Reservation {
        let router = ReservationServiceRouter.checkOut(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func cancel(request: ReservationServiceRequest.Cancel) async throws -> Reservation {
        let router = ReservationServiceRouter.cancel(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func noShow(request: ReservationServiceRequest.NoShow) async throws -> Reservation {
        let router = ReservationServiceRouter.noShow(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    // MARK: - Customer Management
    
    func getFirstGuest(request: ReservationServiceRequest.SetFirstGuest) async throws -> Reservation {
        let router = ReservationServiceRouter.getFirstGuest(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func dropCustomer(request: ReservationServiceRequest.DropCustomer) async throws -> Reservation {
        let router = ReservationServiceRouter.dropCustomer(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func appendCustomer(request: ReservationServiceRequest.AppendCustomer) async throws -> Reservation {
        let router = ReservationServiceRouter.appendCustomer(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func replaceCustomers(request: ReservationServiceRequest.ReplaceCustomers) async throws -> Reservation {
        let router = ReservationServiceRouter.replaceCustomers(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    // MARK: - Additional Operations
    
    func fetchConfirmation(request: ReservationServiceRequest.FetchConfirmation) async throws -> RerservationServiceResponse.ConfirmationInfo {
        let router = ReservationServiceRouter.getConfirmation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func createConfirmation(request: ReservationServiceRequest.CreateConfirmation) async throws -> RerservationServiceResponse.ConfirmationInfo {
        let router = ReservationServiceRouter.createConfirmation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func splitReservation(request: ReservationServiceRequest.SplitReservation) async throws -> Reservations {
        let router = ReservationServiceRouter.splitReservation(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
}
