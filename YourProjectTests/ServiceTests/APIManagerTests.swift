//
//  APIManagerTests.swift
//  YourProject
//
//  Created by IntrodexMini on 14/2/2568 BE.
//

import XCTest
import Alamofire
import Mockable
import Mocker

class APIManagerTests: XCTestCase {
    
    var localStorageManager = MockLocalStorageManagerProtocal()
    var authRemoveService = MockAuthServiceProtocol()
    var router = MockRouter()
    var sut: APIManager!
    
    override func setUp() {
        super.setUp()
        
        sut = APIManager(
            localStorageManager: localStorageManager,
            authRemoteService: authRemoveService
        )
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        sut.setupURLSession(with: configuration)
        
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func testRequestWithValidURLShouldSucceed() async throws {

        // Given
        let parameters: Parameters = ["key": "value"]
        
        // Response
        let originalURL = URL(
            string: "\(AppConfiguration.shared.baseURL)/test"
        )!
        let jsonResponse = """
        "OK"
        """.data(using: .utf8)
            
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 200,
            data: [
                .get : jsonResponse!
            ]
        )
        mock.register()
        
        // When
        let response: String = try await sut.request(
            "/test",
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default,
            requiredAuthorization: false
        )
        
        XCTAssertEqual(response, "OK")
    }
    
    func testRequestWithRouterShouldSucceed() async throws {
        
        // Given
        
        let mockRouter = MockRouter()

        // Response
        let originalURL = URL(
            string: "\(AppConfiguration.shared.baseURL)/test"
        )!
        let jsonResponse = """
        "OK"
        """.data(using: .utf8)
            
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 200,
            data: [
                .get : jsonResponse!
            ]
        )
        mock.register()
        
        // When
        let response: String = try await sut.request(
            router: mockRouter,
            requiredAuthorization: false
        )
        
        XCTAssertEqual(response, "OK")
    }
    
    func testRequestACKShouldSucceed() async throws {
        // Given
        let mockRouter = MockRouter()

        // Response
        let originalURL = URL(
            string: "\(AppConfiguration.shared.baseURL)/test"
        )!
        let jsonResponse = """
        "OK"
        """.data(using: .utf8)
            
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 200,
            data: [
                .get : jsonResponse!
            ]
        )
        mock.register()
        
        // When
        // This should not throw an error
        try await sut.requestACK(
            router: mockRouter,
            requiredAuthorization: false
        )
    }
    
    func testRequestDataShouldSucceed() async throws {
        // Given
        let mockRouter = MockRouter()

        // Response
        let originalURL = URL(
            string: "\(AppConfiguration.shared.baseURL)/test"
        )!
        let expectedData = "Test Data".data(using: .utf8)!
        
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .imagePNG,
            statusCode: 200,
            data: [
                .get : expectedData
            ]
        )
        mock.register()
        
        // When
        let responseData = try await sut.requestData(
            router: mockRouter,
            requiredAuthorization: false
        )
        
        // Then
        XCTAssertNotNil(responseData)
        XCTAssertEqual(responseData, expectedData)
    }
    
    func testRequestWithAuthorizationShouldSucceed() async throws {
        // Given
        let mockRouter = MockRouter()
        
        let mockToken = "mock_access_token"
        given(localStorageManager).accessToken.willReturn(mockToken)
        
        // Response
        let originalURL = URL(string: "\(AppConfiguration.shared.baseURL)/test")!
        let jsonResponse = """
        "OK"
        """.data(using: .utf8)
        
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 200,
            data: [.get: jsonResponse!]
        )
        mock.register()
        
        // When
        let response: String = try await sut.request(
            router: mockRouter,
            requiredAuthorization: true
        )
        
        // Then
        XCTAssertEqual(response, "OK")
    }
    
    func testRequestWithMissingTokenShouldFail() async throws {
        // Given
        let mockRouter = MockRouter()
        
        given(localStorageManager).accessToken.willReturn(nil)
        given(localStorageManager).refreshToken.willReturn(nil)
              
        // Response
        let originalURL = URL(string: "\(AppConfiguration.shared.baseURL)/test")!
        let jsonResponse = """
        "OK"
        """.data(using: .utf8)
        
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 200,
            data: [.get: jsonResponse!]
        )
        mock.register()
        
        // When/Then
        do {
            let _: String = try await sut.request(
                router: mockRouter,
                requiredAuthorization: true
            )
            XCTFail("Request should fail when access token is missing")
        } catch {
            
        guard
                let error = error as? APIError
            else {
                print(error.localizedDescription)
                XCTFail()
                return
            }
            
            switch error {
            case .unauthorized(let err):
                typealias AuthErrorKey = APIErrorResponse.AuthErrorKey
                
                XCTAssertEqual(err.errorCode, 401)
                XCTAssertEqual(err.errorKey, AuthErrorKey.missingAccessToken.rawValue)
                XCTAssertEqual(
                    err.errorMessage,
                    AuthErrorKey.missingAccessToken.errorMessage
                )
                
            default:
                print(error.localizedDescription)
                XCTFail()
            }
        }
    }
    
    func testRequestWithExpiredTokenShouldAttemptRefresh() async throws {
        // Given
        let mockRouter = MockRouter()
        
        given(localStorageManager).accessToken.willReturn("expired_token")
        given(localStorageManager).refreshToken.willReturn("valid_refresh_token")
            
        // First request fails with expired token
        let originalURL = URL(string: "\(AppConfiguration.shared.baseURL)/test")!
        let errorResponse = """
        {
            "error_code": 401,
            "error_key": "access_token_expired",
            "error_message": "Access token has expired. Please use the refresh token to obtain a new access token."
        }        
        """.data(using: .utf8)
        
        let mock = Mock(
            url: originalURL,
            ignoreQuery: true,
            contentType: .json,
            statusCode: 401,
            data: [.get: errorResponse!]
        )
        mock.register()
//        
//        // stub refresh api
//        let refreshResponse = """
//        {
//            "access_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjozOCwiY2xpZW50X2lkIjpudWxsLCJzdGFmZl9yb2xlIjpudWxsLCJhY2Nlc3NpYmxlX2hvdGVsc19pZHMiOlsxMDcsMTA1XSwicGFja2FnZV9leHBpcmVzX2F0IjpudWxsLCJqdGkiOiIzZTFhZmMyOTM1YzU4MGE2ZWU4ZDA4OTAwODVhMDY3NyIsImlhdCI6MTczODM2ODU3NSwiZXhwIjoxNzM4MzY5NDc1LCJzdWIiOiJobXMtcG1zLWFwaSIsImF1dGhfbWV0aG9kIjoiaG1zIn0.rXvKtBAMq4betJrtlgh31KrZjQEE_zzp6ldqpX8x99U",
//            "refresh_token": "0292d8674a33d836b925ddecac65c4cf"
//        }
//        """.data(using: .utf8)
        
        //given(authRemoveService).tokenRefresh(request: .any)
        
//        let refreshURL = URL(string: "\(AppConfiguration.shared.baseURL)/v4/auth/refresh")!
//        let refreshMock = Mock(
//            url: originalURL,
//            ignoreQuery: true,
//            contentType: .json,
//            statusCode: 200,
//            data: [.get: refreshResponse!]
//        )
//        refreshMock.register()
        
        
        // When/Then
        do {
            let _: String = try await sut.request(
                router: mockRouter,
                requiredAuthorization: true
            )
            
            verify(authRemoveService).tokenRefresh(request: .any).called(1)
            
            //XCTFail("Request should fail with expired token")
        } catch {
            guard
                let error = error as? APIError
            else {
                print(error.localizedDescription)
                XCTFail()
                return
            }
            
            print(error.localizedDescription)
        }
    }
}

extension APIManagerTests {
    // Mock Router for testing
    struct MockRouter: AlamofireBaseRouterProtocol {
        
        let url: URL
        
        init(url: URL = URL(string: "\(AppConfiguration.shared.baseURL)/test")! ) {
            self.url = url
        }
        
        func asURLRequest() throws -> URLRequest {
            return URLRequest(url: url)
        }
    }

}

