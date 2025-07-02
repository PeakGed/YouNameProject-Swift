//
//  AccountServiceRouterTests.swift
//  YourProjectTests
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import XCTest

class AccountServiceRouterTests: XCTestCase {
    
    // MARK: - Test Paths
    
    func test_fetchAccounts_path() {
        // Arrange
        let request = AccountServiceRequest.FetchAccounts(
            hotelId: 105,
            kind: nil,
            currency: nil,
            isDefault: nil,
            page: 1,
            perPage: 20,
            sortedBy: "ID",
            sortedOrder: "ASC"
        )
        let router = AccountServiceRouter.fetchAccounts(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/accounts")
    }
    
    func test_fetchAccount_path() {
        // Arrange
        let request = AccountServiceRequest.FetchById(id: 123)
        let router = AccountServiceRouter.fetchAccount(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/accounts/123")
    }
    
    func test_fetchAccountBalance_path() {
        // Arrange
        let request = AccountServiceRequest.FetchAccountBalance(id: 123, limitDatetime: nil)
        let router = AccountServiceRouter.fetchAccountBalance(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/accounts/123/balance")
    }
    
    func test_createAccount_path() {
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
        let router = AccountServiceRouter.createAccount(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/accounts")
    }
    
    func test_updateAccount_path() {
        // Arrange
        let request = AccountServiceRequest.UpdateAccount(
            id: 123,
            name: "Updated Account",
            startBalance: nil,
            kind: nil,
            currency: nil,
            openDate: nil,
            isDefault: nil,
            colorRef: nil,
            iconRef: nil
        )
        let router = AccountServiceRouter.updateAccount(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/accounts/123")
    }
    
    func test_deleteAccount_path() {
        // Arrange
        let request = AccountServiceRequest.DeleteAccount(id: 123)
        let router = AccountServiceRouter.deleteAccount(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/accounts/123")
    }
    
    func test_setAccountAsDefault_path() {
        // Arrange
        let request = AccountServiceRequest.SetAsDefault(id: 123)
        let router = AccountServiceRouter.setAccountAsDefault(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.path, "/v4/accounts/123/default")
    }
    
    // MARK: - Test HTTP Methods
    
    func test_fetchAccounts_method() {
        // Arrange
        let request = AccountServiceRequest.FetchAccounts(
            hotelId: 105,
            kind: nil,
            currency: nil,
            isDefault: nil,
            page: 1,
            perPage: 20,
            sortedBy: "ID",
            sortedOrder: "ASC"
        )
        let router = AccountServiceRouter.fetchAccounts(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.method, .get)
    }
    
    func test_fetchAccount_method() {
        // Arrange
        let request = AccountServiceRequest.FetchById(id: 123)
        let router = AccountServiceRouter.fetchAccount(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.method, .get)
    }
    
    func test_fetchAccountBalance_method() {
        // Arrange
        let request = AccountServiceRequest.FetchAccountBalance(id: 123, limitDatetime: nil)
        let router = AccountServiceRouter.fetchAccountBalance(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.method, .get)
    }
    
    func test_createAccount_method() {
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
        let router = AccountServiceRouter.createAccount(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.method, .post)
    }
    
    func test_updateAccount_method() {
        // Arrange
        let request = AccountServiceRequest.UpdateAccount(
            id: 123,
            name: "Updated Account",
            startBalance: nil,
            kind: nil,
            currency: nil,
            openDate: nil,
            isDefault: nil,
            colorRef: nil,
            iconRef: nil
        )
        let router = AccountServiceRouter.updateAccount(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.method, .put)
    }
    
    func test_deleteAccount_method() {
        // Arrange
        let request = AccountServiceRequest.DeleteAccount(id: 123)
        let router = AccountServiceRouter.deleteAccount(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.method, .delete)
    }
    
    func test_setAccountAsDefault_method() {
        // Arrange
        let request = AccountServiceRequest.SetAsDefault(id: 123)
        let router = AccountServiceRouter.setAccountAsDefault(request: request)
        
        // Act & Assert
        XCTAssertEqual(router.method, .put)
    }
    
    // MARK: - Test Parameters
    
    func test_fetchAccounts_parameters() {
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
        let router = AccountServiceRouter.fetchAccounts(request: request)
        
        // Act
        let parameters = router.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["kind"] as? String, "SAVINGS")
        XCTAssertEqual(parameters?["currency"] as? String, "THB")
        XCTAssertEqual(parameters?["is_default"] as? Bool, true)
    }
    
    func test_fetchAccountBalance_parameters() {
        // Arrange
        let request = AccountServiceRequest.FetchAccountBalance(
            id: 123,
            limitDatetime: "2020-12-31T23:59:59.999+07:00"
        )
        let router = AccountServiceRouter.fetchAccountBalance(request: request)
        
        // Act
        let parameters = router.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["limit_datetime"] as? String, "2020-12-31T23:59:59.999+07:00")
    }
} 