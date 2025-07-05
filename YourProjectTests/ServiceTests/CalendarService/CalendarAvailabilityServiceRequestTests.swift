//
//  CalendarAvailabilityServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 14/6/2568 BE.
//

import XCTest

final class CalendarAvailabilityServiceRequestTests: XCTestCase {
    
    // MARK: - FetchAvailability Tests
    
    func testFetchAvailability_WillGenerateCorrectParameters() throws {
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
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? String, "105")
        XCTAssertEqual(parameters?["check_in_date"] as? String, "2020-01-01")
        XCTAssertEqual(parameters?["check_out_date"] as? String, "2020-01-04")
        XCTAssertEqual(parameters?["room_ids"] as? String, "1,2")
    }
    
    func testFetchAvailability_WithoutRoomIds_WillGenerateCorrectParameters() throws {
        // Given
        let checkInDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let checkOutDate = Date(timeIntervalSince1970: 1578096000) // 2020-01-04
        let request = CalendarAvailabilityServiceRequest.FetchAvailability(
            hotelId: "105",
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            roomIds: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? String, "105")
        XCTAssertEqual(parameters?["check_in_date"] as? String, "2020-01-01")
        XCTAssertEqual(parameters?["check_out_date"] as? String, "2020-01-04")
        XCTAssertNil(parameters?["room_ids"])
    }
    
    func testFetchAvailability_WithPeriodDate_WillGenerateCorrectParameters() throws {
        // Given
        let startDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let endDate = Date(timeIntervalSince1970: 1578096000) // 2020-01-04
        let period = PeriodDate(start: startDate, end: endDate)
        let request = CalendarAvailabilityServiceRequest.FetchAvailability(
            hotelId: "1",
            period: period,
            roomIds: [642, 625, 621, 620]
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? String, "1")
        XCTAssertEqual(parameters?["check_in_date"] as? String, "2020-01-01")
        XCTAssertEqual(parameters?["check_out_date"] as? String, "2020-01-04")
        XCTAssertEqual(parameters?["room_ids"] as? String, "642,625,621,620")
    }
    
    func testFetchAvailability_WithEmptyRoomIds_WillExcludeRoomIdsParameter() throws {
        // Given
        let checkInDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let checkOutDate = Date(timeIntervalSince1970: 1578096000) // 2020-01-04
        let request = CalendarAvailabilityServiceRequest.FetchAvailability(
            hotelId: "105",
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            roomIds: []
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? String, "105")
        XCTAssertEqual(parameters?["check_in_date"] as? String, "2020-01-01")
        XCTAssertEqual(parameters?["check_out_date"] as? String, "2020-01-04")
        XCTAssertNil(parameters?["room_ids"]) // Should be excluded because empty array
    }
    
    func testFetchAvailability_Encoding_WillGenerateCorrectJSON() throws {
        // Given
        let checkInDate = Date(timeIntervalSince1970: 1577836800) // 2020-01-01
        let checkOutDate = Date(timeIntervalSince1970: 1578096000) // 2020-01-04
        let request = CalendarAvailabilityServiceRequest.FetchAvailability(
            hotelId: "2",
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            roomIds: [1, 2, 3]
        )
        
        // When
        let jsonData = try JSONEncoder().encode(request)
        let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
        let json = jsonObject as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? String, "2")
        XCTAssertEqual(json?["check_in_date"] as? String, "2020-01-01")
        XCTAssertEqual(json?["check_out_date"] as? String, "2020-01-04")
        XCTAssertEqual(json?["room_ids"] as? String, "1,2,3")
    }
} 