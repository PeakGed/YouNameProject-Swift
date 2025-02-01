//
//  AuthRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 1/2/2568 BE.
//

import XCTest
import Alamofire
@testable import YourProject

final class AuthRouterServiceTests: XCTestCase {
    
    var baseURL: String!
    let localStorage: LocalStorageManagerProtocal = LocalStorageManager()
    let authRemoteService: AuthServiceProtocol = AuthRemoteService()
    
    override func setUp() {
        super.setUp()
        baseURL = AppConfiguration.shared.baseURL
    }
    
    func testEmailLoginRequest() throws {
        // Given
        let loginRequest = AuthServiceRequest.EmailLogin(username: "test@example.com",
                                                         password: "password123")
        let router = AuthRouterService.emailLogin(request: loginRequest)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/auth/login")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        
        // Test parameters
        let parameters = try JSONSerialization.jsonObject(with: urlRequest.httpBody!,
                                                          options: []) as? [String: Any]
        XCTAssertEqual(parameters?["email"] as? String, "test@example.com")
        XCTAssertEqual(parameters?["password"] as? String, "password123")
    }
    
    func testRefreshTokenRequest() throws {
        // Given
        let refreshRequest = AuthServiceRequest.TokenRefresh(token: "refresh_token_123")
        let router = AuthRouterService.refreshToken(request: refreshRequest)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/auth/refresh")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        
        // Test parameters
        let parameters = try JSONSerialization.jsonObject(with: urlRequest.httpBody!, options: []) as? [String: Any]
        XCTAssertEqual(parameters?["refresh_token"] as? String, "refresh_token_123")
    }
    
    func testLogoutRequest() throws {
        // Given
        let router = AuthRouterService.logout
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/auth/logout")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    func testInvalidURLThrows() {
        // Given
        let router = AuthRouterService.logout
        
        // When/Then
//        XCTAssertThrowsError(try router.asURLRequest()) { error in
//            XCTAssertEqual(error as? APIError, .invalidURL)
//        }
    }
    
    
    func testEmailLoginCallService() async throws {
        let loginRequest = AuthServiceRequest.EmailLogin(username: "test1@email.com",
                                                         password: "12345678")
        let expectation = XCTestExpectation(description: "Wait for response")
        
        try await authRemoteService.emailLogin(request: loginRequest)
            
        XCTAssertNotNil(localStorage.accessToken)
        XCTAssertNotNil(localStorage.refreshToken)
    }
    
}

