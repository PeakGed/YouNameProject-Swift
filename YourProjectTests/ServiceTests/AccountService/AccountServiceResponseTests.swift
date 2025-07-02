//
//  AccountServiceResponseTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import XCTest

class AccountServiceResponseTests: XCTestCase {
    
    // MARK: - Test BalanceInfo
    
    func test_balanceInfo_decodesCorrectly() throws {
        // Arrange
        let json = """
        {
            "balance": "1500.50",
            "limit_datetime": "2020-12-31T23:59:59.999+07:00"
        }
        """.data(using: .utf8)!
        
        // Act
        let balanceInfo = try JSONDecoder().decode(AccountServiceResponse.BalanceInfo.self, from: json)
        
        // Assert
        XCTAssertEqual(balanceInfo.balance, "1500.50")
        XCTAssertEqual(balanceInfo.limitDatetime, "2020-12-31T23:59:59.999+07:00")
    }
    
    func test_balanceInfo_decodesCorrectly_withNilLimitDatetime() throws {
        // Arrange
        let json = """
        {
            "balance": "1500.50"
        }
        """.data(using: .utf8)!
        
        // Act
        let balanceInfo = try JSONDecoder().decode(AccountServiceResponse.BalanceInfo.self, from: json)
        
        // Assert
        XCTAssertEqual(balanceInfo.balance, "1500.50")
        XCTAssertNil(balanceInfo.limitDatetime)
    }
    
    func test_balanceInfo_encodesCorrectly() throws {
        // Arrange
        let balanceInfo = AccountServiceResponse.BalanceInfo(
            balance: "2000.75",
            limitDatetime: "2021-01-01T00:00:00.000+07:00"
        )
        
        // Act
        let data = try JSONEncoder().encode(balanceInfo)
        let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        
        // Assert
        XCTAssertEqual(json["balance"] as? String, "2000.75")
        XCTAssertEqual(json["limit_datetime"] as? String, "2021-01-01T00:00:00.000+07:00")
    }
    
    func test_balanceInfo_encodesCorrectly_withNilLimitDatetime() throws {
        // Arrange
        let balanceInfo = AccountServiceResponse.BalanceInfo(
            balance: "2000.75",
            limitDatetime: nil
        )
        
        // Act
        let data = try JSONEncoder().encode(balanceInfo)
        let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        
        // Assert
        XCTAssertEqual(json["balance"] as? String, "2000.75")
        XCTAssertFalse(json.keys.contains("limit_datetime"))
    }
} 