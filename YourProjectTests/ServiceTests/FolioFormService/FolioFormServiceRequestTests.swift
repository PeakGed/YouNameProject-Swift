//
//  FolioFormServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//

import XCTest

final class FolioFormServiceRequestTests: XCTestCase {
    
    func testFetchByHotelRequest_ToDictionary() {
        // Given
        let request = FolioFormServiceRequest.FetchByHotel(
            hotelId: 105,
            page: 1,
            perPage: 20,
            sortedBy: "ID",
            sortedOrder: "ASC"
        )
        
        // When
        guard let parameters = request.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        // Then
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters["page"] as? Int, 1)
        XCTAssertEqual(parameters["per_page"] as? Int, 20)
        XCTAssertEqual(parameters["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByHotelRequest_ToDictionaryWithNilValues() {
        // Given
        let request = FolioFormServiceRequest.FetchByHotel(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // When
        guard let parameters = request.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        // Then
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters["page"])
        XCTAssertNil(parameters["per_page"])
        XCTAssertNil(parameters["sorted_by"])
        XCTAssertNil(parameters["sorted_order"])
    }
    
    func testFetchByQueryRequest_ToDictionary() {
        // Given
        let request = FolioFormServiceRequest.FetchByQuery(
            hotelId: 105,
            query: "test query",
            page: 2,
            perPage: 10,
            sortedBy: "CREATED_AT",
            sortedOrder: "DESC"
        )
        
        // When
        guard let parameters = request.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        // Then
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters["query"] as? String, "test query")
        XCTAssertEqual(parameters["page"] as? Int, 2)
        XCTAssertEqual(parameters["per_page"] as? Int, 10)
        XCTAssertEqual(parameters["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters["sorted_order"] as? String, "DESC")
    }
    
    func testFetchByPeriodRequest_ToDictionary() {
        // Given
        let request = FolioFormServiceRequest.FetchByPeriod(
            hotelId: 105,
            startDate: "2024-01-01",
            endDate: "2024-12-31",
            page: 1,
            perPage: 50,
            sortedBy: "UPDATED_AT",
            sortedOrder: "ASC"
        )
        
        // When
        guard let parameters = request.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        // Then
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters["start_date"] as? String, "2024-01-01")
        XCTAssertEqual(parameters["end_date"] as? String, "2024-12-31")
        XCTAssertEqual(parameters["page"] as? Int, 1)
        XCTAssertEqual(parameters["per_page"] as? Int, 50)
        XCTAssertEqual(parameters["sorted_by"] as? String, "UPDATED_AT")
        XCTAssertEqual(parameters["sorted_order"] as? String, "ASC")
    }
    
    func testFetchByReservationRequest_ToDictionary() {
        // Given
        let request = FolioFormServiceRequest.FetchByReservation(
            hotelId: 105,
            reservationId: 512,
            page: 1,
            perPage: 20,
            sortedBy: "ID",
            sortedOrder: "ASC"
        )
        
        // When
        guard let parameters = request.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        // Then
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters["reservation_id"] as? Int, 512)
        XCTAssertEqual(parameters["page"] as? Int, 1)
        XCTAssertEqual(parameters["per_page"] as? Int, 20)
        XCTAssertEqual(parameters["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters["sorted_order"] as? String, "ASC")
    }
    
    func testCreateFolioFormReservationRequest_Encoding() throws {
        // Given
        let request = FolioFormServiceRequest.CreateFolioFormReservation(
            hotelId: 105,
            hotelContactId: 8,
            customerContactId: 6,
            vatIncluded: false,
            remark: "test remark",
            internalNote: "test internal note",
            paymentInfo: "2, 2 (111-1-11111-2)",
            groupRoomCharge: true,
            groupAdditionalItem: false
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["hotel_contact_id"] as? Int, 8)
        XCTAssertEqual(json?["customer_contact_id"] as? Int, 6)
        XCTAssertEqual(json?["vat_included"] as? Bool, false)
        XCTAssertEqual(json?["remark"] as? String, "test remark")
        XCTAssertEqual(json?["internal_note"] as? String, "test internal note")
        XCTAssertEqual(json?["payment_info"] as? String, "2, 2 (111-1-11111-2)")
        XCTAssertEqual(json?["group_room_charge"] as? Bool, true)
        XCTAssertEqual(json?["group_additional_item"] as? Bool, false)
    }
    
    func testCreateFolioFormReservationRequest_EncodingWithNilValues() throws {
        // Given
        let request = FolioFormServiceRequest.CreateFolioFormReservation(
            hotelId: 105,
            hotelContactId: 8,
            customerContactId: 6,
            vatIncluded: true,
            remark: nil,
            internalNote: nil,
            paymentInfo: "payment info",
            groupRoomCharge: false,
            groupAdditionalItem: true
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["hotel_contact_id"] as? Int, 8)
        XCTAssertEqual(json?["customer_contact_id"] as? Int, 6)
        XCTAssertEqual(json?["vat_included"] as? Bool, true)
        XCTAssertEqual(json?["payment_info"] as? String, "payment info")
        XCTAssertEqual(json?["group_room_charge"] as? Bool, false)
        XCTAssertEqual(json?["group_additional_item"] as? Bool, true)
        // Nil values should not be present in JSON
        XCTAssertTrue(json?["remark"] == nil || json?["remark"] is NSNull)
        XCTAssertTrue(json?["internal_note"] == nil || json?["internal_note"] is NSNull)
    }
    
    func testUpdateFolioFormRequest_Encoding() throws {
        // Given
        let request = FolioFormServiceRequest.UpdateFolioForm(
            id: 1,
            hotelContactId: 9,
            customerContactId: 7,
            remark: "updated remark",
            internalNote: "updated internal note",
            paymentInfo: "updated payment info",
            groupRoomCharge: false,
            groupAdditionalItem: true
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_contact_id"] as? Int, 9)
        XCTAssertEqual(json?["customer_contact_id"] as? Int, 7)
        XCTAssertEqual(json?["remark"] as? String, "updated remark")
        XCTAssertEqual(json?["internal_note"] as? String, "updated internal note")
        XCTAssertEqual(json?["payment_info"] as? String, "updated payment info")
        XCTAssertEqual(json?["group_room_charge"] as? Bool, false)
        XCTAssertEqual(json?["group_additional_item"] as? Bool, true)
        // id should not be encoded as it's used in the URL path
        XCTAssertNil(json?["id"])
    }
    
    func testUpdateFolioFormRequest_EncodingWithNilValues() throws {
        // Given
        let request = FolioFormServiceRequest.UpdateFolioForm(
            id: 2,
            hotelContactId: 10,
            customerContactId: 1,
            remark: "partial update",
            internalNote: nil,
            paymentInfo: nil,
            groupRoomCharge: nil,
            groupAdditionalItem: false
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_contact_id"] as? Int, 10)
        XCTAssertEqual(json?["remark"] as? String, "partial update")
        XCTAssertEqual(json?["group_additional_item"] as? Bool, false)
        // Nil values should not be present in JSON or be encoded as null
        XCTAssertEqual(json?["customer_contact_id"] as? Int, 1)
        XCTAssertTrue(json?["internal_note"] == nil || json?["internal_note"] is NSNull)
        XCTAssertTrue(json?["payment_info"] == nil || json?["payment_info"] is NSNull)
        XCTAssertTrue(json?["group_room_charge"] == nil || json?["group_room_charge"] is NSNull)
        // id should not be encoded as it's used in the URL path
        XCTAssertNil(json?["id"])
    }
} 
