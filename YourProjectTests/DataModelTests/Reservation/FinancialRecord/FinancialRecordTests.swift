//
//  FinancialRecordTests.swift
//  YourProject
//
//  Created by IntrodexMini on 18/5/2568 BE.
//

import XCTest

final class FinancialRecordTests: XCTestCase {
    
    // MARK: - Helper Methods
    
    private func createSampleFinancialRecord() -> FinancialRecord {
        return FinancialRecord(
            id: 440,
            name: "PAYMENT",
            paymentMethod: "Bank Transfer",
            note: nil,
            timestamp: Date(timeIntervalSince1970: 1000),
            amount: 2111.11,
            recordableId: 1067,
            recordableType: "Reservation",
            createdAt: Date(timeIntervalSince1970: 1000),
            updatedAt: Date(timeIntervalSince1970: 2000),
            hotelId: 105,
            bankAccount: nil
        )
    }
    
    // MARK: - Initialization Tests
    
    func test_initWithAllProperties() {
        // Arrange & Act
        let record = createSampleFinancialRecord()
        
        // Assert
        XCTAssertEqual(record.id, 440)
        XCTAssertEqual(record.name, "PAYMENT")
        XCTAssertEqual(record.paymentMethod, "Bank Transfer")
        XCTAssertNil(record.note)
        XCTAssertEqual(record.amount, 2111.11)
        XCTAssertEqual(record.recordableId, 1067)
        XCTAssertEqual(record.recordableType, "Reservation")
        XCTAssertEqual(record.hotelId, 105)
        XCTAssertNil(record.bankAccount)
    }
    
    func test_initWithOptionalPropertiesPresent() {
        // Arrange & Act
        let record = FinancialRecord(
            id: 440,
            name: "PAYMENT",
            paymentMethod: "Bank Transfer", 
            note: "Test note",
            timestamp: Date(timeIntervalSince1970: 1000),
            amount: 2111.11,
            recordableId: 1067,
            recordableType: "Reservation",
            createdAt: Date(timeIntervalSince1970: 1000),
            updatedAt: Date(timeIntervalSince1970: 2000),
            hotelId: 105,
            bankAccount: "1234567890"
        )
        
        // Assert
        XCTAssertEqual(record.note, "Test note")
        XCTAssertEqual(record.bankAccount, "1234567890")
    }
    
    // MARK: - Codable Tests
    
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 440,
            "name": "PAYMENT",
            "payment_method": "Bank Transfer",
            "note": null,
            "timestamp": "2024-04-21T13:33:54.748+07:00",
            "amount": "2111.11",
            "recordable_id": 1067,
            "recordable_type": "Reservation",
            "created_at": "2024-04-21T13:33:54.756+07:00",
            "updated_at": "2024-04-21T13:33:54.756+07:00",
            "hotel_id": 105,
            "bank_account": null
        }
        """.data(using: .utf8)!
        
        // Act
        let record = try JSONDecoder().decode(FinancialRecord.self, from: json)
        
        // Assert
        XCTAssertEqual(record.id, 440)
        XCTAssertEqual(record.name, "PAYMENT")
        XCTAssertEqual(record.paymentMethod, "Bank Transfer")
        XCTAssertNil(record.note)
        XCTAssertEqual(record.amount, 2111.11)
        XCTAssertEqual(record.recordableId, 1067)
        XCTAssertEqual(record.recordableType, "Reservation")
        XCTAssertEqual(record.hotelId, 105)
        XCTAssertNil(record.bankAccount)
    }
    
    func test_encodingToJSON() throws {
        // Arrange
        let record = createSampleFinancialRecord()
        
        // Act
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(record)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        // Assert
        XCTAssertTrue(jsonString.contains("\"id\" : 440"))
        XCTAssertTrue(jsonString.contains("\"name\" : \"PAYMENT\""))
        XCTAssertTrue(jsonString.contains("\"payment_method\" : \"Bank Transfer\""))
        XCTAssertTrue(jsonString.contains("\"amount\" : \"2111.11\""))
        XCTAssertTrue(jsonString.contains("\"recordable_id\" : 1067"))
        XCTAssertTrue(jsonString.contains("\"recordable_type\" : \"Reservation\""))
        XCTAssertTrue(jsonString.contains("\"hotel_id\" : 105"))
    }
}
