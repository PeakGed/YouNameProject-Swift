//
//  AdditionalItemTests.swift
//  YourProject
//
//  Created by IntrodexMini on 17/5/2568 BE.
//

import XCTest

final class AdditionalItemTests: XCTestCase {
    
    func test_decodingFromJSON() throws {
        let json = """
        {
            "id": 431,
            "price": "15.0",
            "quantity": 2,
            "total_amount": "30.0",
            "itemable_id": 134,
            "itemable_type": "Folio",
            "created_at": "2024-03-19T05:54:36.214+07:00",
            "updated_at": "2024-03-19T05:54:36.214+07:00",
            "additional_id": 261
        }
        """
        
        let jsonData = json.data(using: .utf8)!
        let item = try JSONDecoder().decode(AdditionalItem.self, from: jsonData)
        
        XCTAssertEqual(item.id, 431)
        XCTAssertEqual(item.price, 15.0)
        XCTAssertEqual(item.quantity, 2)
        XCTAssertEqual(item.totalAmount, 30.0)
        XCTAssertEqual(item.itemableId, 134)
        XCTAssertEqual(item.itemableType, .foilo)
        XCTAssertEqual(item.additionalId, 261)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormConfig.DateFormat.datetimeISO
        dateFormatter.timeZone = TimeZone(identifier: "UTC+7")
        
        let expectedCreatedAt = dateFormatter.date(from: "2024-03-19T05:54:36.214+07:00")
        let expectedUpdatedAt = dateFormatter.date(from: "2024-03-19T05:54:36.214+07:00")
        
        XCTAssertEqual(item.createdAt, expectedCreatedAt)
        XCTAssertEqual(item.updatedAt, expectedUpdatedAt)
    }
    
    func test_encodingToJSON() throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormConfig.DateFormat.datetimeISO
        dateFormatter.timeZone = TimeZone(identifier: "UTC+7")
        
        let createdAt = dateFormatter.date(from: "2024-03-19T05:54:36.214+07:00")!
        let updatedAt = dateFormatter.date(from: "2024-03-19T05:54:36.214+07:00")!
        
        let item = AdditionalItem(
            id: 431,
            price: 15.0,
            quantity: 2,
            totalAmount: 30.0,
            itemableId: 134,
            itemableType: .foilo,
            createdAt: createdAt,
            updatedAt: updatedAt,
            additionalId: 261
        )
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try encoder.encode(item)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        XCTAssertTrue(jsonString.contains("\"id\" : 431"))
        XCTAssertTrue(jsonString.contains("\"price\" : \"15.0\""))
        XCTAssertTrue(jsonString.contains("\"quantity\" : 2"))
        XCTAssertTrue(jsonString.contains("\"total_amount\" : \"30.0\""))
        XCTAssertTrue(jsonString.contains("\"itemable_id\" : 134"))
        XCTAssertTrue(jsonString.contains("\"itemable_type\" : \"Folio\""))
        XCTAssertTrue(jsonString.contains("\"additional_id\" : 261"))
        XCTAssertTrue(jsonString.contains("\"created_at\" : \"2024-03-19T05:54:36.214+07:00\""))
        XCTAssertTrue(jsonString.contains("\"updated_at\" : \"2024-03-19T05:54:36.214+07:00\""))
    }
}
