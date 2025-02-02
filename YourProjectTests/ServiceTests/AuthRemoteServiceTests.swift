//
//  AuthRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 1/2/2568 BE.
//

import XCTest
import Alamofire
import Mockable

@testable import YourProject

final class AuthRouterServiceTests: XCTestCase {
    
    var baseURL: String!
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var authRemoteService = MockAuthServiceProtocol()
    
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
        
        given(authRemoteService).emailLogin(request: .any).willReturn()
            
        
        let loginRequest = AuthServiceRequest.EmailLogin(username: "test1@email.com",
                                                         password: "12345678")
        
        try await authRemoteService.emailLogin(request: loginRequest)
            
        XCTAssertNotNil(localStorage.accessToken)
        XCTAssertNotNil(localStorage.refreshToken)
    }
    
    func testTokenRefreshWithNilTokens() async {
        // Given
        localStorage.clearToken()
        
        // When/Then
        do {
            let request = AuthServiceRequest.TokenRefresh(token: "refresh_token")
            try await authRemoteService.tokenRefresh(request: request)
            XCTFail("Should throw error")
        } catch let error as APIAuthErrorResponse {
            XCTAssertEqual(error.errorCode, .missingAccessToken)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testTokenRefreshWithValidTokens() async throws {
        // Given
        localStorage.setToken(.init(accessToken: "valid_access_token",
                                    refreshToken: "valid_refresh_token"))
        
        let request = AuthServiceRequest.TokenRefresh(token: "valid_refresh_token")
        
        // When
        try await authRemoteService.tokenRefresh(request: request)
        
        // Then
        XCTAssertNotNil(localStorage.accessToken)
        XCTAssertNotNil(localStorage.refreshToken)
    }
    
//    func testTokenRefreshWithNilAccessTokenButValidRefreshToken() async throws {
//        // Given
//        localStorage.accessToken = nil
//        localStorage.refreshToken = "valid_refresh_token"
//        
//        let request = AuthServiceRequest.TokenRefresh(token: "valid_refresh_token")
//        
//        // When
//        try await authRemoteService.tokenRefresh(request: request)
//        
//        // Then
//        XCTAssertNotNil(localStorage.accessToken)
//        XCTAssertNotNil(localStorage.refreshToken)
//    }
//    
//    func testTokenRefreshWithValidAccessTokenButNilRefreshToken() async {
//        // Given
//        localStorage.accessToken = "valid_access_token"
//        localStorage.refreshToken = nil
//        
//        // When/Then
//        do {
//            let request = AuthServiceRequest.TokenRefresh(token: "refresh_token")
//            try await authRemoteService.tokenRefresh(request: request)
//            XCTFail("Should throw error")
//        } catch let error as APIAuthErrorResponse {
//            XCTAssertEqual(error.errorCode, .invalidRefreshToken)
//        } catch {
//            XCTFail("Unexpected error: \(error)")
//        }
//    }
    
}

