//
//  CalendarAvailabilityRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 14/6/2568 BE.
//

import XCTest
import Mockable

final class CalendarAvailabilityRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchAvailability_WillGetValidResponse() async throws {
        // Given
        let expectedCalendarAvailability = CalendarAvailability(
            availableRoomTypes: [
                CalendarAvailability.AvailableRoomType(
                    id: 179,
                    name: "Duluxe Room",
                    description: "test description",
                    limitedNumberOfCmUnits: nil,
                    order: 0,
                    hotelId: 105,
                    availableRooms: [642, 625, 621, 620],
                    availableDates: [
                        CalendarAvailability.AvailableDate(
                            date: Date(timeIntervalSince1970: 1577836800), // 2020-01-01
                            hmsUnselectedReservedCount: 0,
                            hmsSelectedReservedCount: 0,
                            hmsReservedCount: 0,
                            cmReservedCount: 0,
                            availableUnitCount: 4,
                            unavailableUnitCount: 0,
                            blackoutUnitCount: 0,
                            totalUnits: 4
                        )
                    ]
                )
            ]
        )
        
        // Stub the API manager to return the expected availability
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCalendarAvailability)

        let service = CalendarAvailabilityRemoteService(localStorage: localStorage,
                                                       apiManager: apiManager)
        let checkInDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let checkOutDate = Date(timeIntervalSince1970: 1578096000) // 2020-01-04
        let request = CalendarAvailabilityServiceRequest.FetchAvailability(
            hotelId: "105",
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            roomIds: [1, 2]
        )

        // When
        let result = try await service.fetchAvailability(request: request)

        // Then
        XCTAssertEqual(result.availableRoomTypes.count, expectedCalendarAvailability.availableRoomTypes.count)
        XCTAssertEqual(result.availableRoomTypes.first?.id, 179)
        XCTAssertEqual(result.availableRoomTypes.first?.name, "Duluxe Room")
        XCTAssertEqual(result.availableRoomTypes.first?.description, "test description")
        XCTAssertEqual(result.availableRoomTypes.first?.hotelId, 105)
        XCTAssertEqual(result.availableRoomTypes.first?.availableRooms, [642, 625, 621, 620])
        XCTAssertEqual(result.availableRoomTypes.first?.availableDates.count, 1)
        XCTAssertEqual(result.availableRoomTypes.first?.availableDates.first?.availableUnitCount, 4)
        XCTAssertEqual(result.availableRoomTypes.first?.availableDates.first?.totalUnits, 4)
    }

    func testFetchAvailability_WithoutRoomIds_WillGetValidResponse() async throws {
        // Given
        let expectedCalendarAvailability = CalendarAvailability(
            availableRoomTypes: []
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCalendarAvailability)

        let service = CalendarAvailabilityRemoteService(localStorage: localStorage, apiManager: apiManager)
        let checkInDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let checkOutDate = Date(timeIntervalSince1970: 1578096000) // 2020-01-04
        let request = CalendarAvailabilityServiceRequest.FetchAvailability(
            hotelId: "1",
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            roomIds: nil
        )

        // When
        let result = try await service.fetchAvailability(request: request)

        // Then
        XCTAssertEqual(result.availableRoomTypes.count, 0)
    }

    func testFetchAvailability_WithMultipleRoomTypes_WillGetValidResponse() async throws {
        // Given
        let expectedCalendarAvailability = CalendarAvailability(
            availableRoomTypes: [
                CalendarAvailability.AvailableRoomType(
                    id: 179,
                    name: "Duluxe Room",
                    description: "test description",
                    limitedNumberOfCmUnits: nil,
                    order: 0,
                    hotelId: 105,
                    availableRooms: [642, 625],
                    availableDates: []
                ),
                CalendarAvailability.AvailableRoomType(
                    id: 180,
                    name: "Standard Room",
                    description: "standard room description",
                    limitedNumberOfCmUnits: 2,
                    order: 1,
                    hotelId: 105,
                    availableRooms: [621, 620],
                    availableDates: []
                )
            ]
        )
        
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedCalendarAvailability)

        let service = CalendarAvailabilityRemoteService(localStorage: localStorage, apiManager: apiManager)
        let checkInDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let checkOutDate = Date(timeIntervalSince1970: 1578096000) // 2020-01-04
        let request = CalendarAvailabilityServiceRequest.FetchAvailability(
            hotelId: "105",
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            roomIds: [642, 625, 621, 620]
        )

        // When
        let result = try await service.fetchAvailability(request: request)

        // Then
        XCTAssertEqual(result.availableRoomTypes.count, 2)
        XCTAssertEqual(result.availableRoomTypes.first?.id, 179)
        XCTAssertEqual(result.availableRoomTypes.last?.id, 180)
        XCTAssertEqual(result.availableRoomTypes.first?.name, "Duluxe Room")
        XCTAssertEqual(result.availableRoomTypes.last?.name, "Standard Room")
        XCTAssertNil(result.availableRoomTypes.first?.limitedNumberOfCmUnits)
        XCTAssertEqual(result.availableRoomTypes.last?.limitedNumberOfCmUnits, 2)
    }
} 
