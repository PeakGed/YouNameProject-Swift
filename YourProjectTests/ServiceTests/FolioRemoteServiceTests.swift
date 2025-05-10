//
//  FolioRouterServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//


import XCTest
import Alamofire
import Mockable

final class FolioRouterServiceTests: XCTestCase {
    
    var baseURL: String!
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()
        baseURL = AppConfiguration.shared.baseURL
    }
    
    func testFetchFoliosRequest() throws {
        // Given
        let req = FolioServiceRequest.FetchFolios(hotelId: 101,
                                                  page: 1,
                                                  perPage: .twenty,
                                                  sortedBy: .id,
                                                  sortedOrder: .ascending)
        let router = FolioRouterService.fetchFolios(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/folios?hotel_id=101&page=1&per_page=20&sorted_by=ID&sorted_order=ASC")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
        
        // Test parameters
//        if let body = urlRequest.httpBody {
//            do {
//                if let json = try JSONSerialization.jsonObject(with: body,
//                                                               options: []) as? [String: Any] {
//                    print(json)
//                    print("ss")
////                    XCTAssertEqual(json["username"] as? String, "test@example.com")
////                    XCTAssertEqual(json["password"] as? String, "password123")
//                } else {
//                    XCTFail("JSON is not a dictionary")
//                }
//            } catch {
//                XCTFail("Failed to parse JSON: \(error)")
//            }
//        } else {
//            XCTFail("HTTP body is nil")
//        }
    }
    
}
