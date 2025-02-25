//
//  AuthRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 1/2/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class AuthRouterServiceTests: XCTestCase {
    
    var baseURL: String!
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
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
        if let parameters = parseURLEncodedBody(from: urlRequest.httpBody) {
            XCTAssertEqual(parameters["username"], "test@example.com")
            XCTAssertEqual(parameters["password"], "password123")
        } else {
            XCTFail("Failed to parse HTTP body")
        }
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
        if let parameters = parseURLEncodedBody(from: urlRequest.httpBody) {
            XCTAssertEqual(parameters["refresh_token"], "refresh_token_123")
        } else {
            XCTFail("Failed to parse HTTP body")
        }
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
    
    func testEmailLogin_WillGetValidResponse() async throws {
        let response = AuthTokenResponse(accessToken: "access_token",
                                          refreshToken: "refresh_token")
        given(apiManager).request(router: .any,
                                  requiredAuthorization: .any).willReturn(response)
        given(localStorage).setToken(.any).willReturn()
        
        let authRemoteService = AuthRemoteService(localStorage: localStorage,
                                                  apiManager: apiManager)
        
        let loginRequest = AuthServiceRequest.EmailLogin(username: "test1@email.com",
                                                         password: "12345678")
        
        try await authRemoteService.emailLogin(request: loginRequest)
            
        
        verify(localStorage).setToken(.any).called(.atLeastOnce)
    }
        
    func testEmailLogin_WhenAPIFails_ThrowsError() async {
        // Given
        let expectedError = MockError()
        given(apiManager)
            .request(router: .any,
                     requiredAuthorization: .any)
            .willProduce { a, b -> AuthTokenResponse in
                throw expectedError
            }
        
        let authRemoteService = AuthRemoteService(localStorage: localStorage,
                                                apiManager: apiManager)

        let loginRequest = AuthServiceRequest.EmailLogin(username: "test@email.com",
                                                       password: "password")

        // When/Then
        do {
            try await authRemoteService.emailLogin(request: loginRequest)
            XCTFail("Should throw an error")
        } catch {
            if error is MockError {
                XCTAssertTrue(true)
            }
            else {
                XCTFail()
            }
        }

        verify(localStorage).setToken(.any).called(.never)
    }
    
    func testFetchTokenRefresh_WillGetValidResponse() async {
        // Given
        given(localStorage).accessToken.willReturn(nil)
        given(localStorage).refreshToken.willReturn(nil)
        
        let response = AuthTokenResponse(accessToken: "access_token",
                                          refreshToken: "refresh_token")
        given(apiManager).request(router: .any,
                                  requiredAuthorization: .any).willReturn(response)
        given(localStorage).setToken(.any).willReturn()
        
        let authRemoteService = AuthRemoteService(
            localStorage: localStorage,
            apiManager: apiManager
        )
                
        // When/Then
        do {
            let request = AuthServiceRequest.TokenRefresh(token: "refresh_token")
            try await authRemoteService.tokenRefresh(request: request)
       } catch {
           XCTFail()
        }
    }
        
    func testTokenRefresh_WhenAPIFails_ThrowsError() async {
        // Given
        let expectedError = MockError()
        given(apiManager).request(router: .any,
                                  requiredAuthorization: .any).willProduce { a, b -> AuthTokenResponse in
            throw expectedError
        }
        
        let authRemoteService = AuthRemoteService(localStorage: localStorage,
                                                  apiManager: apiManager)
        
        let request = AuthServiceRequest.TokenRefresh(token: "refresh_token")
        
        // When/Then
        do {
            try await authRemoteService.tokenRefresh(request: request)
            XCTFail("Should throw an error")
        } catch {
             if error is MockError {
                XCTAssertTrue(true)
            }
            else {
                XCTFail()
            }
        }
        
        verify(localStorage).setToken(.any).called(.never)
    }
    
    func testLogout_Success() async throws {
        // Given
        given(apiManager).requestACK(router: .any,
                                   requiredAuthorization: .any).willReturn()
        given(localStorage).clearToken().willReturn()
        
        let authRemoteService = AuthRemoteService(localStorage: localStorage,
                                                apiManager: apiManager)
        
        // When
        await authRemoteService.logout()
        
        // Then
        verify(localStorage).clearToken().called(.once)
        verify(apiManager).requestACK(router: .any,
                                      requiredAuthorization: .any).called(
                                        .atLeastOnce
                                      )
    }
   
   func testLogout_WhenAPIFails_ThrowsError() async {
       // Given
       let expectedError = MockError()
       given(apiManager).requestACK(router: .any,
                                    requiredAuthorization: .any).willProduce { a, b -> Void in
           throw expectedError
       }
       given(localStorage).clearToken().willReturn()
       
       let authRemoteService = AuthRemoteService(localStorage: localStorage,
                                               apiManager: apiManager)
       
       // When/Then
       await authRemoteService.logout()
       
       verify(localStorage).clearToken().called(.once)
   }
    
}

// MARK: - Helper Methods
private extension AuthRouterServiceTests {
    func parseURLEncodedBody(from data: Data?) -> [String: String]? {
        guard let data = data, !data.isEmpty,
              let bodyString = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        // For debugging
        print("HTTP Body: \(bodyString)")
        
        let components = bodyString.components(separatedBy: "&")
        var parameters: [String: String] = [:]
        
        for component in components {
            let keyValuePair = component.components(separatedBy: "=")
            if keyValuePair.count == 2 {
                let key = keyValuePair[0]
                let value = keyValuePair[1].removingPercentEncoding ?? keyValuePair[1]
                parameters[key] = value
            }
        }
        
        return parameters
    }
}

extension AuthRouterServiceTests {
    struct MockError: Error {}
}

