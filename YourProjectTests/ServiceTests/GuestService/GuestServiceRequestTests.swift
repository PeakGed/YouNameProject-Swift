//
//  GuestServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 7/6/2568 BE.
//

import XCTest

final class GuestServiceRequestTests: XCTestCase {
    
    func testFetchGuestsRequest_ToDictionary() {
        // Given
        let request = GuestServiceRequest.FetchGuests(
            page: 1,
            perPage: 20,
            sortedBy: "ID",
            sortedOrder: "ASC",
            hotelId: 105,
            includeHidden: true
        )
        
        // When
        guard let parameters = request.parameters else {
            XCTFail("Parameters should not be nil")
            return
        }
        
        // Then
        XCTAssertEqual(parameters["page"] as? Int, 1)
        XCTAssertEqual(parameters["per_page"] as? Int, 20)
        XCTAssertEqual(parameters["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters["include_hidden"] as? String, "true")
    }
    
    func testFetchGuestsRequest_ToDictionaryWithNilValues() {
        // Given
        let request = GuestServiceRequest.FetchGuests(
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            hotelId: nil,
            includeHidden: nil
        )
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertTrue(parameters?.isEmpty ?? true)
    }
    
    func testCreateGuestRequest_Encoding() throws {
        // Given
        let request = GuestServiceRequest.CreateGuest(
            firstName: "John",
            lastName: "Doe",
            nationality: "THA",
            country: "THA",
            reservationId: 123,
            companyId: 456,
            hotelId: 789,
            title: "Mr.",
            middleName: "Middle",
            dateOfBirth: "1990-01-01",
            idCardNo: "1234567890123",
            passportNo: "A1234567",
            gender: .male,
            email: "john.doe@example.com",
            occupation: "Engineer",
            phone: "0812345678",
            address: "123 Main St",
            district: "District",
            province: "Province",
            zipCode: "10100",
            note: "Test note",
            nickname: "JD",
            photos: ["photo1.jpg", "photo2.jpg"],
            documentPhotos: ["doc1.jpg", "doc2.jpg"]
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["first_name"] as? String, "John")
        XCTAssertEqual(json?["last_name"] as? String, "Doe")
        XCTAssertEqual(json?["nationality"] as? String, "THA")
        XCTAssertEqual(json?["country"] as? String, "THA")
        XCTAssertEqual(json?["reservation_id"] as? Int, 123)
        XCTAssertEqual(json?["company_id"] as? Int, 456)
        XCTAssertEqual(json?["hotel_id"] as? Int, 789)
        XCTAssertEqual(json?["title"] as? String, "Mr.")
        XCTAssertEqual(json?["middle_name"] as? String, "Middle")
        XCTAssertEqual(json?["date_of_birth"] as? String, "1990-01-01")
        XCTAssertEqual(json?["id_card_no"] as? String, "1234567890123")
        XCTAssertEqual(json?["passport_no"] as? String, "A1234567")
        XCTAssertEqual(json?["gender"] as? String, "male")
        XCTAssertEqual(json?["email"] as? String, "john.doe@example.com")
        XCTAssertEqual(json?["occupation"] as? String, "Engineer")
        XCTAssertEqual(json?["phone"] as? String, "0812345678")
        XCTAssertEqual(json?["address"] as? String, "123 Main St")
        XCTAssertEqual(json?["district"] as? String, "District")
        XCTAssertEqual(json?["province"] as? String, "Province")
        XCTAssertEqual(json?["zip_code"] as? String, "10100")
        XCTAssertEqual(json?["note"] as? String, "Test note")
        XCTAssertEqual(json?["nickname"] as? String, "JD")
        XCTAssertEqual(json?["photos"] as? [String], ["photo1.jpg", "photo2.jpg"])
        XCTAssertEqual(json?["document_photos"] as? [String], ["doc1.jpg", "doc2.jpg"])
    }
    
    func testUpdateGuestRequest_Encoding() throws {
        // Given
        let request = GuestServiceRequest.UpdateGuest(
            id: 1,
            companyId: 456,
            title: "Mr.",
            firstName: "John",
            middleName: "Middle",
            lastName: "Doe",
            nationality: "THA",
            country: "THA",
            dateOfBirth: "1990-01-01",
            idCardNo: "1234567890123",
            passportNo: "A1234567",
            gender: .male,
            email: "john.doe@example.com",
            occupation: "Engineer",
            phone: "0812345678",
            address: "123 Main St",
            district: "District",
            province: "Province",
            zipCode: "10100",
            note: "Test note",
            nickname: "JD",
            photos: ["photo1.jpg", "photo2.jpg"],
            documentPhotos: ["doc1.jpg", "doc2.jpg"]
        )
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        // Then
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["company_id"] as? Int, 456)
        XCTAssertEqual(json?["title"] as? String, "Mr.")
        XCTAssertEqual(json?["first_name"] as? String, "John")
        XCTAssertEqual(json?["middle_name"] as? String, "Middle")
        XCTAssertEqual(json?["last_name"] as? String, "Doe")
        XCTAssertEqual(json?["nationality"] as? String, "THA")
        XCTAssertEqual(json?["country"] as? String, "THA")
        XCTAssertEqual(json?["date_of_birth"] as? String, "1990-01-01")
        XCTAssertEqual(json?["id_card_no"] as? String, "1234567890123")
        XCTAssertEqual(json?["passport_no"] as? String, "A1234567")
        XCTAssertEqual(json?["gender"] as? String, "male")
        XCTAssertEqual(json?["email"] as? String, "john.doe@example.com")
        XCTAssertEqual(json?["occupation"] as? String, "Engineer")
        XCTAssertEqual(json?["phone"] as? String, "0812345678")
        XCTAssertEqual(json?["address"] as? String, "123 Main St")
        XCTAssertEqual(json?["district"] as? String, "District")
        XCTAssertEqual(json?["province"] as? String, "Province")
        XCTAssertEqual(json?["zip_code"] as? String, "10100")
        XCTAssertEqual(json?["note"] as? String, "Test note")
        XCTAssertEqual(json?["nickname"] as? String, "JD")
        XCTAssertEqual(json?["photos"] as? [String], ["photo1.jpg", "photo2.jpg"])
        XCTAssertEqual(json?["document_photos"] as? [String], ["doc1.jpg", "doc2.jpg"])
        // id should not be encoded as it's used in the URL path
        XCTAssertNil(json?["id"])
    }
} 
