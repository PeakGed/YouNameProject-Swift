//
//  RoomTypeRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

import XCTest
import Mockable

final class RoomTypeRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchRoomTypes_WillGetValidResponse() async throws {
        // Given
        let expectedRoomTypes = RoomTypes(array: [
            RoomType(
                id: 1,
                name: "Standard Room",
                baseRate: 1500.0,
                baseGuestNumber: 2,
                extraBedRate: 500.0,
                extraGuestRate: 300.0,
                maxExtraBedNumber: 1,
                maxExtraGuestNumber: 2,
                hotelId: 123,
                createdAt: Date(),
                updatedAt: Date(),
                limitedNumberOfCmUnits: 10,
                description: "Comfortable standard room",
                tags: ["standard", "city-view"],
                data: nil
            ),
            RoomType(
                id: 2,
                name: "Deluxe Room",
                baseRate: 2500.0,
                baseGuestNumber: 2,
                extraBedRate: 700.0,
                extraGuestRate: 400.0,
                maxExtraBedNumber: 1,
                maxExtraGuestNumber: 2,
                hotelId: 123,
                createdAt: Date(),
                updatedAt: Date(),
                limitedNumberOfCmUnits: 5,
                description: "Luxurious deluxe room",
                tags: ["deluxe", "ocean-view"],
                data: nil
            )
        ])
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedRoomTypes)
        
        let service = RoomTypeRemoteService(localStorage: localStorage,
                                           apiManager: apiManager)
        let request = RoomTypeServiceRequest.FetchRoomTypes(hotelId: 123)
        
        // When
        let result = try await service.fetchRoomTypes(request: request)
        
        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.lists.first?.id, 1)
        XCTAssertEqual(result.lists.first?.name, "Standard Room")
        XCTAssertEqual(result.lists.first?.baseRate, 1500.0)
        XCTAssertEqual(result.lists.first?.hotelId, 123)
        XCTAssertEqual(result.lists.last?.id, 2)
        XCTAssertEqual(result.lists.last?.name, "Deluxe Room")
        XCTAssertEqual(result.lists.last?.baseRate, 2500.0)
    }
    
    func testFetchRoomTypes_WithEmptyResult_WillGetValidResponse() async throws {
        // Given
        let expectedRoomTypes = RoomTypes(array: [])
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedRoomTypes)
        
        let service = RoomTypeRemoteService(localStorage: localStorage,
                                           apiManager: apiManager)
        let request = RoomTypeServiceRequest.FetchRoomTypes(hotelId: 123)
        
        // When
        let result = try await service.fetchRoomTypes(request: request)
        
        // Then
        XCTAssertEqual(result.count, 0)
        XCTAssertTrue(result.lists.isEmpty)
    }

    func testFetchRoomType_WillGetValidResponse() async throws {
        // Given
        let expectedRoomType = RoomType(
            id: 1,
            name: "Suite Room",
            baseRate: 3500.0,
            baseGuestNumber: 4,
            extraBedRate: 800.0,
            extraGuestRate: 500.0,
            maxExtraBedNumber: 2,
            maxExtraGuestNumber: 4,
            hotelId: 123,
            createdAt: Date(),
            updatedAt: Date(),
            limitedNumberOfCmUnits: 3,
            description: "Premium suite room",
            tags: ["suite", "balcony", "city-view"],
            data: nil
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedRoomType)

        let service = RoomTypeRemoteService(localStorage: localStorage, 
                                           apiManager: apiManager)
        let request = RoomTypeServiceRequest.FetchRoomType(id: 1)

        // When
        let result = try await service.fetchRoomType(request: request)

        // Then
        XCTAssertEqual(result.id, expectedRoomType.id)
        XCTAssertEqual(result.name, expectedRoomType.name)
        XCTAssertEqual(result.baseRate, expectedRoomType.baseRate)
        XCTAssertEqual(result.baseGuestNumber, expectedRoomType.baseGuestNumber)
        XCTAssertEqual(result.hotelId, expectedRoomType.hotelId)
        XCTAssertEqual(result.description, expectedRoomType.description)
        XCTAssertEqual(result.tags, expectedRoomType.tags)
    }

    func testCreateRoomType_WillGetValidResponse() async throws {
        // Given
        let expectedRoomType = RoomType(
            id: 3,
            name: "Executive Room",
            baseRate: 2000.0,
            baseGuestNumber: 2,
            extraBedRate: 600.0,
            extraGuestRate: 350.0,
            maxExtraBedNumber: 1,
            maxExtraGuestNumber: 2,
            hotelId: 123,
            createdAt: Date(),
            updatedAt: Date(),
            limitedNumberOfCmUnits: 8,
            description: "Executive business room",
            tags: ["executive", "business"],
            data: nil
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedRoomType)

        let service = RoomTypeRemoteService(localStorage: localStorage, 
                                           apiManager: apiManager)
        let request = RoomTypeServiceRequest.CreateRoomType(
            hotelId: 123,
            name: "Executive Room",
            baseRate: 2000.0,
            baseGuestNumber: 2,
            extraBedRate: 600.0,
            extraGuestRate: 350.0,
            maxExtraBedNumber: 1,
            maxExtraGuestNumber: 2,
            limitedNumberOfCmUnits: 8,
            description: "Executive business room",
            tagList: "executive,business",
            data: nil
        )

        // When
        let result = try await service.createRoomType(request: request)

        // Then
        XCTAssertEqual(result.id, expectedRoomType.id)
        XCTAssertEqual(result.name, expectedRoomType.name)
        XCTAssertEqual(result.baseRate, expectedRoomType.baseRate)
        XCTAssertEqual(result.hotelId, expectedRoomType.hotelId)
        XCTAssertEqual(result.description, expectedRoomType.description)
    }

    func testUpdateRoomType_WillGetValidResponse() async throws {
        // Given
        let expectedRoomType = RoomType(
            id: 1,
            name: "Updated Standard Room",
            baseRate: 1800.0,
            baseGuestNumber: 2,
            extraBedRate: 550.0,
            extraGuestRate: 320.0,
            maxExtraBedNumber: 1,
            maxExtraGuestNumber: 2,
            hotelId: 123,
            createdAt: Date(),
            updatedAt: Date(),
            limitedNumberOfCmUnits: 12,
            description: "Updated standard room",
            tags: ["standard", "renovated"],
            data: nil
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedRoomType)

        let service = RoomTypeRemoteService(localStorage: localStorage, 
                                           apiManager: apiManager)
        let request = RoomTypeServiceRequest.UpdateRoomType(
            id: 1,
            name: "Updated Standard Room",
            baseRate: 1800.0,
            baseGuestNumber: 2,
            extraBedRate: 550.0,
            extraGuestRate: 320.0,
            maxExtraBedNumber: 1,
            maxExtraGuestNumber: 2,
            limitedNumberOfCmUnits: 12,
            description: "Updated standard room",
            tagList: "standard,renovated",
            data: nil
        )

        // When
        let result = try await service.updateRoomType(request: request)

        // Then
        XCTAssertEqual(result.id, expectedRoomType.id)
        XCTAssertEqual(result.name, expectedRoomType.name)
        XCTAssertEqual(result.baseRate, expectedRoomType.baseRate)
        XCTAssertEqual(result.description, expectedRoomType.description)
    }

    func testDeleteRoomType_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = RoomTypeRemoteService(localStorage: localStorage, 
                                           apiManager: apiManager)
        let request = RoomTypeServiceRequest.DeleteRoomType(id: 3)

        // When/Then
        do {
            try await service.deleteRoomType(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Delete should not throw error")
        }
    }

    func testUpdateRoomTypesOrder_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = RoomTypeRemoteService(localStorage: localStorage, 
                                           apiManager: apiManager)
        let request = RoomTypeServiceRequest.UpdateRoomTypesOrder(
            hotelId: 123,
            roomTypeOrders: [
                RoomTypeServiceRequest.UpdateRoomTypesOrder.RoomTypeOrder(roomTypeId: 1, order: 0),
                RoomTypeServiceRequest.UpdateRoomTypesOrder.RoomTypeOrder(roomTypeId: 2, order: 1),
                RoomTypeServiceRequest.UpdateRoomTypesOrder.RoomTypeOrder(roomTypeId: 3, order: 2)
            ]
        )

        // When/Then
        do {
            try await service.updateRoomTypesOrder(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Update room types order should not throw error")
        }
    }
} 