//
//  StaffServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest

final class StaffServiceRequestTests: XCTestCase {
    
    func testFetchStaffsRequest() throws {
        // Given
        let request = StaffServiceRequest.FetchStaffs(hotelId: 105)
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
    }
    
    func testFetchStaffRequest() throws {
        // Given
        let request = StaffServiceRequest.FetchStaff(id: 1)
        
        // Then
        XCTAssertEqual(request.id, 1)
    }
    
    func testCreateStaffRequest() throws {
        // Given
        let request = StaffServiceRequest.CreateStaff(
            hotelId: 105,
            password: "password123",
            email: "staff@example.com",
            role: .frontDesk
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["password"] as? String, "password123")
        XCTAssertEqual(json?["email"] as? String, "staff@example.com")
        XCTAssertEqual(json?["role"] as? String, "front_desk")
    }
    
    func testCreateStaffCodingKeys() throws {
        // Given
        let request = StaffServiceRequest.CreateStaff(
            hotelId: 105,
            password: "password123",
            email: "staff@example.com",
            role: .manager
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json?["hotel_id"])
        XCTAssertNotNil(json?["password"])
        XCTAssertNotNil(json?["email"])
        XCTAssertNotNil(json?["role"])
        XCTAssertNil(json?["hotelId"]) // Should use snake_case
        XCTAssertEqual(json?["role"] as? String, "manager")
    }
    
    func testUpdateStaffRequest() throws {
        // Given
        let request = StaffServiceRequest.UpdateStaff(
            id: 1,
            firstName: "John",
            lastName: "Doe",
            phoneNumber: "123-456-7890",
            pinCode: "1234",
            idCard: "1234567890123"
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["first_name"] as? String, "John")
        XCTAssertEqual(json?["last_name"] as? String, "Doe")
        XCTAssertEqual(json?["phone_number"] as? String, "123-456-7890")
        XCTAssertEqual(json?["pin_code"] as? String, "1234")
        XCTAssertEqual(json?["id_card"] as? String, "1234567890123")
        XCTAssertNil(json?["id"]) // ID should not be encoded
    }
    
    func testUpdateStaffCodingKeys() throws {
        // Given
        let request = StaffServiceRequest.UpdateStaff(
            id: 1,
            firstName: "John",
            lastName: "Doe",
            phoneNumber: "123-456-7890",
            pinCode: nil,
            idCard: nil
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json?["first_name"])
        XCTAssertNotNil(json?["last_name"])
        XCTAssertNotNil(json?["phone_number"])
        XCTAssertNil(json?["firstName"]) // Should use snake_case
        XCTAssertNil(json?["lastName"])
        XCTAssertNil(json?["phoneNumber"])
        XCTAssertNil(json?["id"])
    }
    
    func testDeleteStaffRequest() throws {
        // Given
        let request = StaffServiceRequest.DeleteStaff(id: 3)
        
        // Then
        XCTAssertEqual(request.id, 3)
    }
    
    func testChangeHotelRequest() throws {
        // Given
        let request = StaffServiceRequest.ChangeHotel(
            id: 1,
            hotelId: 201
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["hotel_id"] as? Int, 201)
        XCTAssertNil(json?["id"]) // ID should not be encoded
    }
    
    func testChangeHotelCodingKeys() throws {
        // Given
        let request = StaffServiceRequest.ChangeHotel(
            id: 1,
            hotelId: 201
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json?["hotel_id"])
        XCTAssertNil(json?["hotelId"]) // Should use snake_case
        XCTAssertNil(json?["id"])
    }
    
    func testChangePasswordRequest() throws {
        // Given
        let request = StaffServiceRequest.ChangePassword(
            id: 1,
            password: "newpassword123"
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["password"] as? String, "newpassword123")
        XCTAssertNil(json?["id"]) // ID should not be encoded
    }
    
    func testUpdateStatusRequest() throws {
        // Given
        let request = StaffServiceRequest.UpdateStatus(
            id: 1,
            status: .inactive
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["status"] as? String, "deactive")
        XCTAssertNil(json?["id"]) // ID should not be encoded
    }
    
    func testUpdateStatusCodingKeys() throws {
        // Given
        let request = StaffServiceRequest.UpdateStatus(
            id: 1,
            status: .active
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json?["status"])
        XCTAssertEqual(json?["status"] as? String, "active")
        XCTAssertNil(json?["id"])
    }
    
    func testVerifyPinRequest() throws {
        // Given
        let request = StaffServiceRequest.VerifyPin(
            id: 1,
            pinCode: "1234"
        )
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        // Then
        XCTAssertEqual(json?["pin_code"] as? String, "1234")
        XCTAssertNil(json?["id"]) // ID should not be encoded
    }
    
    func testVerifyPinCodingKeys() throws {
        // Given
        let request = StaffServiceRequest.VerifyPin(
            id: 1,
            pinCode: "5678"
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json?["pin_code"])
        XCTAssertNil(json?["pinCode"]) // Should use snake_case
        XCTAssertNil(json?["id"])
    }
} 