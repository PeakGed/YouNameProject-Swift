//
//  APIManagerTests.swift
//  YourProject
//
//  Created by IntrodexMini on 14/2/2568 BE.
//

import XCTest
import Alamofire
import Mockable

//class MockLocalStorageManager: LocalStorageManagerProtocal {
//    var accessToken: String?
//    
//    init(accessToken: String? = nil) {
//        self.accessToken = accessToken
//    }
//}
//

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
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func testRequestWithValidURLShouldSucceed() async throws {
        // Given
        let expectation = XCTestExpectation(description: "API request succeeds")
        let parameters: Parameters = ["key": "value"]
        
        // When
        do {
            let _: String = try await sut.request(
                "/test",
                method: .get,
                parameters: parameters,
                encoding: URLEncoding.default,
                requiredAuthorization: false
            )
            expectation.fulfill()
        } catch {
            XCTFail("Request should not fail: \(error)")
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func testRequestWithRouterShouldSucceed() async throws {
        // Given
        let expectation = XCTestExpectation(description: "Router API request succeeds")
        let mockRouter = MockRouter()
        
        // When
        do {
            let _: String = try await sut.request(
                router: mockRouter,
                requiredAuthorization: false
            )
            expectation.fulfill()
        } catch {
            XCTFail("Router request should not fail: \(error)")
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func testRequestACKShouldSucceed() async throws {
        // Given
        let expectation = XCTestExpectation(description: "ACK request succeeds")
        let mockRouter = MockRouter()
        
        // When
        do {
            try await sut.requestACK(
                router: mockRouter,
                requiredAuthorization: false
            )
            expectation.fulfill()
        } catch {
            XCTFail("ACK request should not fail: \(error)")
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func testRequestDataShouldSucceed() async throws {
        // Given
        let expectation = XCTestExpectation(description: "Data request succeeds")
        let mockRouter = MockRouter()
        
        // When
        do {
            let data = try await sut.requestData(
                router: mockRouter,
                requiredAuthorization: false
            )
            XCTAssertNotNil(data)
            expectation.fulfill()
        } catch {
            XCTFail("Data request should not fail: \(error)")
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
//    func testAuthorizationRequirement() {
//        // Given
//        let mockRouter = MockRouter()
//        
//        // When - No access token
//        given(localStorageManager).accessToken.willReturn(nil)
//        //localStorageManager.accessToken = nil
//        
//        // Then
//        XCTAssertThrowsError(try mockRouter.asURLRequest()) { error in
//            XCTAssertNotNil(error)
//        }
//        
//        // When - With access token
//        localStorageManager.accessToken = "valid_token"
//        
//        // Then
//        XCTAssertNoThrow(try mockRouter.asURLRequest())
//    }
}

extension APIManagerTests {
    // Mock Router for testing
    struct MockRouter: AlamofireBaseRouterProtocol {
        func asURLRequest() throws -> URLRequest {
            let url = URL(string: "https://api.example.com/test")!
            return URLRequest(url: url)
        }
    }

}

