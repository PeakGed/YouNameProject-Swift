//
//  PDPAServiceRequestTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest

final class PDPAServiceRequestTests: XCTestCase {
    
    func testFetchPdpasRequestWithVersion() {
        // Given
        let version = Version(string: "1.0")!
        let request = PDPAServiceRequest.FetchPdpas(version: version)
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["version"] as? String, "1.0.0")
        XCTAssertEqual(parameters?.count, 1)
    }
    
    func testFetchPdpasRequestWithoutVersion() {
        // Given
        let request = PDPAServiceRequest.FetchPdpas(version: nil)
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertEqual(parameters?.count, 0)
        XCTAssertTrue(parameters?.isEmpty ?? true)
    }
    
    func testFetchPdpasRequestWithComplexVersion() {
        // Given
        let version = Version(string: "2.1.3")!
        let request = PDPAServiceRequest.FetchPdpas(version: version)
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["version"] as? String, "2.1.3")
        XCTAssertEqual(parameters?.count, 1)
    }
    
    func testFetchPdpasRequestWithZeroVersion() {
        // Given
        let version = Version(string: "0.0")!
        let request = PDPAServiceRequest.FetchPdpas(version: version)
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["version"] as? String, "1.0.0")
        XCTAssertEqual(parameters?.count, 1)
    }
    
    func testFetchPdpasRequestWithSingleDigitVersion() {
        // Given
        let version = Version(string: "5")!
        let request = PDPAServiceRequest.FetchPdpas(version: version)
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["version"] as? String, "5.0.0")
        XCTAssertEqual(parameters?.count, 1)
    }
    
    func testFetchPdpasRequestEncoding() throws {
        // Given
        let version = Version(string: "1.5")!
        let request = PDPAServiceRequest.FetchPdpas(version: version)
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        
        // Then
        if let dictionary = json as? [String: Any] {
            XCTAssertEqual(dictionary["version"] as? String, "1.5.0")
            XCTAssertEqual(dictionary.count, 1)
        } else {
            XCTFail("Encoded data should be a dictionary")
        }
    }
    
    func testFetchPdpasRequestEncodingWithNilVersion() throws {
        // Given
        let request = PDPAServiceRequest.FetchPdpas(version: nil)
        
        // When
        let data = try JSONEncoder().encode(request)
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        
        // Then
        if let dictionary = json as? [String: Any] {
            XCTAssertNil(dictionary["version"])
            // Dictionary might be empty or contain null values
            XCTAssertTrue(dictionary.isEmpty || dictionary["version"] is NSNull)
        } else {
            XCTFail("Encoded data should be a dictionary")
        }
    }
    
    func testFetchPdpaByIDRequest() {
        // Given
        let request = PDPAServiceRequest.FetchPdpa(id: 42)
        
        // Then
        XCTAssertEqual(request.id, 42)
    }
    
    func testFetchPdpaByIDRequestWithZero() {
        // Given
        let request = PDPAServiceRequest.FetchPdpa(id: 0)
        
        // Then
        XCTAssertEqual(request.id, 0)
    }
    
    func testFetchPdpaByIDRequestWithLargeNumber() {
        // Given
        let request = PDPAServiceRequest.FetchPdpa(id: 999999)
        
        // Then
        XCTAssertEqual(request.id, 999999)
    }
    
    func testFetchPdpaByIDRequestWithNegativeNumber() {
        // Given
        let request = PDPAServiceRequest.FetchPdpa(id: -1)
        
        // Then
        XCTAssertEqual(request.id, -1)
    }
    
    func testVersionComparisonInRequests() {
        // Given
        let version1 = Version(string: "1.0")!
        let version2 = Version(string: "2.0")!
        let request1 = PDPAServiceRequest.FetchPdpas(version: version1)
        let request2 = PDPAServiceRequest.FetchPdpas(version: version2)
        
        // When
        let parameters1 = request1.parameters
        let parameters2 = request2.parameters
        
        // Then
        XCTAssertEqual(parameters1?["version"] as? String, "1.0.0")
        XCTAssertEqual(parameters2?["version"] as? String, "2.0.0")
        XCTAssertNotEqual(parameters1?["version"] as? String, parameters2?["version"] as? String)
    }
    
    func testFetchPdpasRequestCodingKeys() {
        // Given
        let version = Version(string: "1.0")!
        let request = PDPAServiceRequest.FetchPdpas(version: version)
        
        // Then
        // Test the coding key is correct
        XCTAssertEqual(PDPAServiceRequest.FetchPdpas.CodingKeys.version.rawValue, "version")
    }
    
    func testVersionParameterReflectsVersionRaw() {
        // Given
        let originalVersionString = "3.14.159"
        let version = Version(string: originalVersionString)!
        let request = PDPAServiceRequest.FetchPdpas(version: version)
        
        // When
        let parameters = request.parameters
        
        // Then
        XCTAssertEqual(parameters?["version"] as? String, originalVersionString)
        XCTAssertEqual(version.raw, originalVersionString)
    }
} 
