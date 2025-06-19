//
//  ReservationRemoteServiceTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest
import Mockable

class ReservationRemoteServiceTests: XCTestCase {
    
    var sut: ReservationRemoteService!
    var mockAPIManager: MockAPIManagerProtocal!
    var mockLocalStorage: MockLocalStorageManagerProtocal!
    
    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManagerProtocal()
        mockLocalStorage = MockLocalStorageManagerProtocal()
        sut = ReservationRemoteService(localStorage: mockLocalStorage, apiManager: mockAPIManager)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIManager = nil
        mockLocalStorage = nil
        super.tearDown()
    }
    
    // MARK: - Test fetchReservations
    
    func test_fetchReservations_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservations(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            status: "CONFIRMED"
        )
        
        let expectedReservations = createMockReservationsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservations)
        
        // Act
        let result = try await sut.fetchReservations(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReservations.totalItems)
        XCTAssertEqual(result.items.first?.id, expectedReservations.items.first?.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    func test_fetchReservations_failure() async throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservations(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            status: "CONFIRMED"
        )
        
        let error = APIError.unknownError(title: "Stub Error",
                                          subtitle: nil,
                                          underlying: nil)
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willProduce { (a, b) -> Paginator<Reservations> in
                throw error
            }
        
        // Act & Assert
        do {
            _ = try await sut.fetchReservations(request: request)
            XCTFail("Expected error to be thrown")
        } catch {
            switch error as? APIError {
            case .unknownError(let title, _, _):
                XCTAssertEqual(title, "Stub Error")
            default:
                XCTFail("Unexpected error type")
            }
        }
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchReservationsByFlags
    
    func test_fetchReservationsByFlags_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationsByFlags(
            hotelId: 105,
            flags: "FLAG_RED,FLAG_BLUE",
            page: 1,
            perPage: .fifty,
            sortedBy: .checkInDate,
            sortedOrder: .descending
        )
        
        let expectedReservations = createMockReservationsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservations)
        
        // Act
        let result = try await sut.fetchReservationsByFlags(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReservations.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchReservationsByGuest
    
    func test_fetchReservationsByGuest_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationsByGuest(
            hotelId: 105,
            guestId: 123,
            page: 1,
            perPage: .ten,
            sortedBy: .createdAt,
            sortedOrder: .ascending
        )
        
        let expectedReservations = createMockReservationsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservations)
        
        // Act
        let result = try await sut.fetchReservationsByGuest(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReservations.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchReservationsByPeriod
    
    func test_fetchReservationsByPeriod_success() async throws {
        // Arrange
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)!
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = ReservationServiceRequest.FetchReservationsByPeriod(
            hotelId: 105,
            period: period,
            status: "CHECKED_IN",
            page: 1,
            perPage: .hundred,
            sortedBy: .checkOutDate,
            sortedOrder: .ascending
        )
        
        let expectedReservations = createMockReservationsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservations)
        
        // Act
        let result = try await sut.fetchReservationsByPeriod(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReservations.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchReservationsByKeyword
    
    func test_fetchReservationsByKeyword_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationsByKeyword(
            hotelId: 105,
            keyword: "Somchai",
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        let expectedReservations = createMockReservationsPaginator()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservations)
        
        // Act
        let result = try await sut.fetchReservationsByKeyword(request: request)
        
        // Assert
        XCTAssertEqual(result.totalItems, expectedReservations.totalItems)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test fetchReservationByUid
    
    func test_fetchReservationByUid_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationByUid(
            hotelId: 105,
            uid: "rsvt_thai_booking_001"
        )
        
        let expectedReservation = createMockReservation()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservation)
        
        // Act
        let result = try await sut.fetchReservationByUid(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReservation.id)
        XCTAssertEqual(result.uid, expectedReservation.uid)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test createReservation
    
    func test_createReservation_success() async throws {
        // Arrange
        let checkInDate = Date()
        let checkOutDate = Calendar.current.date(byAdding: .day, value: 3, to: checkInDate)!
        let contacts = ReservationContacts(
            title: "คุณ",
            fullname: "สมชาย ใจดี",
            email: "somchai@example.com",
            tel: "0812345678"
        )
        
        let request = ReservationServiceRequest.CreateReservation(
            hotelId: 105,
            roomTypeId: 5,
            roomId: 101,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            adultNumber: 2,
            extraAdultNumber: 0,
            childNumber: 1,
            contacts: contacts,
            note: "ห้องติดกัน",
            otaBookingId: nil,
            relatedReservationId: nil,
            guestComment: "ต้องการห้องชั้นสูง",
            channelId: 1,
            subChannelId: nil
        )
        
        let expectedReservation = createMockReservation()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservation)
        
        // Act
        let result = try await sut.createReservation(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReservation.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test checkIn
    
    func test_checkIn_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.CheckIn(id: 512)
        let expectedReservation = createMockReservation()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservation)
        
        // Act
        let result = try await sut.checkIn(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReservation.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test checkOut
    
    func test_checkOut_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.CheckOut(id: 512)
        let expectedReservation = createMockReservation()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservation)
        
        // Act
        let result = try await sut.checkOut(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReservation.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test cancel
    
    func test_cancel_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.Cancel(id: 512)
        let expectedReservation = createMockReservation()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservation)
        
        // Act
        let result = try await sut.cancel(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReservation.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test Customer Management
    
    func test_appendCustomer_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.AppendCustomer(
            id: 512,
            customerId: 789
        )
        let expectedReservation = createMockReservation()
        
        given(mockAPIManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedReservation)
        
        // Act
        let result = try await sut.appendCustomer(request: request)
        
        // Assert
        XCTAssertEqual(result.id, expectedReservation.id)
        
        verify(mockAPIManager)
            .request(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Test deleteReservation
    
    func test_deleteReservation_success() async throws {
        // Arrange
        let request = ReservationServiceRequest.DeleteReservation(id: 512)
        
        given(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())
        
        // Act
        try await sut.deleteReservation(request: request)
        
        // Assert
        verify(mockAPIManager)
            .requestACK(router: .any, requiredAuthorization: .value(true))
            .called(1)
    }
    
    // MARK: - Helper Methods
    
    private func createMockReservationsPaginator() -> Paginator<Reservations> {
        let reservation = createMockReservation()
        let reservations = Reservations(reservations: [reservation])
        
        return Paginator<Reservations>(
            page: 1,
            perPage: 20,
            totalPages: 1,
            totalItems: 1,
            items: [reservations]
        )
    }
    
    private func createMockReservation() -> Reservation {
        let checkInDate = Date()
        let checkOutDate = Calendar.current.date(byAdding: .day, value: 3, to: checkInDate) ?? Date()
        let createdAt = Date()
        let updatedAt = Date()
        
        let contacts = Reservation.Contacts(
            title: "คุณ",
            fullname: "สมชาย ใจดี",
            email: "somchai@example.com",
            tel: "0812345678"
        )
        
        return Reservation(
            id: 512,
            uid: "rsvt_thai_booking_001",
            status: .confirmed,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            adultNumber: 2,
            extraAdultNumber: 0,
            childNumber: 1,
            contacts: contacts,
            note: "ห้องติดกัน",
            canceledReason: nil,
            documentPhotos: nil,
            otaBookingId: "",
            relatedReservationId: nil,
            guestComment: "ต้องการห้องชั้นสูง",
            markers: [],
            flags: [.red],
            tags: ["VIP"],
            emoji: nil,
            hotelChannelReservationId: nil,
            hotelId: 105,
            creatorId: 38,
            channelId: 1,
            subChannelId: nil,
            checkedInAt: nil,
            checkedOutAt: nil,
            canceledAt: nil,
            noShowAt: nil,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
} 
