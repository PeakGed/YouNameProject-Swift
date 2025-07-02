//
//  AccountServiceRequestTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import XCTest

class AccountServiceRequestTests: XCTestCase {
    
    // MARK: - Test FetchAccounts
    
    func test_fetchAccounts_encodesCorrectly() throws {
        // Arrange
        let request = AccountServiceRequest.FetchAccounts(
            hotelId: 105,
            kind: "SAVINGS",
            currency: "THB",
            isDefault: true,
            page: 1,
            perPage: 20,
            sortedBy: "ID",
            sortedOrder: "ASC"
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["kind"] as? String, "SAVINGS")
        XCTAssertEqual(parameters?["currency"] as? String, "THB")
        XCTAssertEqual(parameters?["is_default"] as? Bool, true)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? Int, 20)
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    func test_fetchAccounts_optionalFields_nil() throws {
        // Arrange
        let request = AccountServiceRequest.FetchAccounts(
            hotelId: 105,
            kind: nil,
            currency: nil,
            isDefault: nil,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["kind"])
        XCTAssertNil(parameters?["currency"])
        XCTAssertNil(parameters?["is_default"])
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
    }
    
    // MARK: - Test FetchAccountBalance
    
    func test_fetchAccountBalance_encodesCorrectly() throws {
        // Arrange
        let request = AccountServiceRequest.FetchAccountBalance(
            id: 123,
            limitDatetime: "2020-12-31T23:59:59.999+07:00"
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["limit_datetime"] as? String, "2020-12-31T23:59:59.999+07:00")
    }
    
    func test_fetchAccountBalance_optionalFields_nil() throws {
        // Arrange
        let request = AccountServiceRequest.FetchAccountBalance(
            id: 123,
            limitDatetime: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertNil(parameters?["limit_datetime"])
    }
    
    // MARK: - Test CreateAccount
    
    func test_createAccount_encodesToBody() throws {
        // Arrange
        let request = AccountServiceRequest.CreateAccount(
            name: "Test Account",
            startBalance: "1000.00",
            kind: "SAVINGS",
            currency: "THB",
            openDate: "2020-05-09",
            isDefault: false,
            colorRef: 0,
            iconRef: 0,
            hotelId: 105
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!) as! [String: Any]
        XCTAssertEqual(json["name"] as? String, "Test Account")
        XCTAssertEqual(json["start_balance"] as? String, "1000.00")
        XCTAssertEqual(json["kind"] as? String, "SAVINGS")
        XCTAssertEqual(json["currency"] as? String, "THB")
        XCTAssertEqual(json["open_date"] as? String, "2020-05-09")
        XCTAssertEqual(json["is_default"] as? Bool, false)
        XCTAssertEqual(json["color_ref"] as? Int, 0)
        XCTAssertEqual(json["icon_ref"] as? Int, 0)
        XCTAssertEqual(json["hotel_id"] as? Int, 105)
    }
    
    // MARK: - Test UpdateAccount
    
    func test_updateAccount_encodesToBody() throws {
        // Arrange
        let request = AccountServiceRequest.UpdateAccount(
            id: 123,
            name: "Updated Account",
            startBalance: "2000.00",
            kind: "CHECKING",
            currency: "USD",
            openDate: "2020-06-01",
            isDefault: true,
            colorRef: 1,
            iconRef: 1
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!) as! [String: Any]
        XCTAssertEqual(json["name"] as? String, "Updated Account")
        XCTAssertEqual(json["start_balance"] as? String, "2000.00")
        XCTAssertEqual(json["kind"] as? String, "CHECKING")
        XCTAssertEqual(json["currency"] as? String, "USD")
        XCTAssertEqual(json["open_date"] as? String, "2020-06-01")
        XCTAssertEqual(json["is_default"] as? Bool, true)
        XCTAssertEqual(json["color_ref"] as? Int, 1)
        XCTAssertEqual(json["icon_ref"] as? Int, 1)
        
        // Verify id is not encoded in body (it's used in URL path)
        XCTAssertNil(json["id"])
    }
    
    func test_updateAccount_optionalFields_nil() throws {
        // Arrange
        let request = AccountServiceRequest.UpdateAccount(
            id: 123,
            name: nil,
            startBalance: nil,
            kind: nil,
            currency: nil,
            openDate: nil,
            isDefault: nil,
            colorRef: nil,
            iconRef: nil
        )
        
        // Act
        let body = request.body
        
        // Assert
        XCTAssertNotNil(body)
        
        let json = try JSONSerialization.jsonObject(with: body!) as! [String: Any]
        XCTAssertNil(json["name"])
        XCTAssertNil(json["start_balance"])
        XCTAssertNil(json["kind"])
        XCTAssertNil(json["currency"])
        XCTAssertNil(json["open_date"])
        XCTAssertNil(json["is_default"])
        XCTAssertNil(json["color_ref"])
        XCTAssertNil(json["icon_ref"])
        XCTAssertNil(json["id"])
    }
} 