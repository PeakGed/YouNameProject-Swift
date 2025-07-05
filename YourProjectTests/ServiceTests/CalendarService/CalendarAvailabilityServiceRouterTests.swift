//
//  CalendarAvailabilityServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 14/6/2568 BE.
//

import XCTest

final class CalendarAvailabilityServiceRouterTests: XCTestCase {
    
    func testFetchAvailabilityRouter_WillHaveCorrectParameters() throws {
        // Given
        let checkInDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let checkOutDate = Date(timeIntervalSince1970: 1578096000) // 2020-01-04
        let request = CalendarAvailabilityServiceRequest.FetchAvailability(
            hotelId: "105",
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            roomIds: [1, 2]
        )
        
        // When
        let router = CalendarAvailabilityServiceRouter.fetchAvailability(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/availability")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? String, "105")
        XCTAssertEqual(parameters?["check_in_date"] as? String, "2020-01-01")
        XCTAssertEqual(parameters?["check_out_date"] as? String, "2020-01-04")
        XCTAssertEqual(parameters?["room_ids"] as? String, "1,2")
    }
    
    func testFetchAvailabilityRouter_WithoutRoomIds_WillHaveCorrectParameters() throws {
        // Given
        let checkInDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let checkOutDate = Date(timeIntervalSince1970: 1578096000) // 2020-01-04
        let request = CalendarAvailabilityServiceRequest.FetchAvailability(
            hotelId: "1",
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            roomIds: nil
        )
        
        // When
        let router = CalendarAvailabilityServiceRouter.fetchAvailability(request: request)
        
        // Then
        XCTAssertEqual(router.path, "/v4/availability")
        XCTAssertEqual(router.method.rawValue, "GET")
        
        let parameters = router.parameters
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? String, "1")
        XCTAssertEqual(parameters?["check_in_date"] as? String, "2020-01-01")
        XCTAssertEqual(parameters?["check_out_date"] as? String, "2020-01-04")
        XCTAssertNil(parameters?["room_ids"])
    }
    
    func testFetchAvailabilityRouter_WillHaveCorrectHeaders() throws {
        // Given
        let checkInDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let checkOutDate = Date(timeIntervalSince1970: 1578096000) // 2020-01-04
        let request = CalendarAvailabilityServiceRequest.FetchAvailability(
            hotelId: "1",
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            roomIds: [642, 625, 621, 620]
        )
        
        // When
        let router = CalendarAvailabilityServiceRouter.fetchAvailability(request: request)
        
        // Then
        XCTAssertEqual(router.headers?["Content-Type"], "application/json")
        XCTAssertNil(router.body)
    }
    
    func testFetchAvailabilityRouter_AsURLRequest_WillCreateValidRequest() throws {
        // Given
        let checkInDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let checkOutDate = Date(timeIntervalSince1970: 1578096000) // 2020-01-04
        let request = CalendarAvailabilityServiceRequest.FetchAvailability(
            hotelId: "1",
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            roomIds: [1, 2]
        )
        let router = CalendarAvailabilityServiceRouter.fetchAvailability(request: request)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("/v4/availability") == true)
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }
} 