//
//  ChannelManagerTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest

final class ChannelManagerFeatureTests: XCTestCase {
    
    // MARK: - Decode Tests
    
    func testDecodeValidData() throws {
        // Arrange
        let json = """
        {
            "enabled": true,
            "otas": [
                {
                    "ota_name": "booking.com",
                    "beds24_id": null,
                    "enabled_sync_allotment": false,
                    "enabled_sync_rate": false
                },
                {
                    "ota_name": "agoda",
                    "beds24_id": "123",
                    "enabled_sync_allotment": true,
                    "enabled_sync_rate": true
                }
            ],
            "ota_rate_codes": {
                "bookingcomRateCode": [
                    {
                        "code": "20774025",
                        "name": "None Refund"
                    },
                    {
                        "code": "9705762",
                        "name": "Standard"
                    }
                ],
                "agodacomRateCode": [
                    {
                        "code": "A20774025",
                        "name": "Agoda"
                    }
                ]
            }
        }
        """
        
        let jsonData = json.data(using: .utf8)!
        
        // Act
        let feature = try JSONDecoder().decode(ChannelManagerFeature.self, from: jsonData)
        
        // Assert
        XCTAssertTrue(feature.enabled)
        XCTAssertEqual(feature.otas.count, 2)
        
        // Verify first OTA
        XCTAssertEqual(feature.otas[0].otaName, "booking.com")
        XCTAssertNil(feature.otas[0].beds24Id)
        XCTAssertFalse(feature.otas[0].enabledSyncAllotment)
        XCTAssertFalse(feature.otas[0].enabledSyncRate)
        
        // Verify second OTA
        XCTAssertEqual(feature.otas[1].otaName, "agoda")
        XCTAssertEqual(feature.otas[1].beds24Id, "123")
        XCTAssertTrue(feature.otas[1].enabledSyncAllotment)
        XCTAssertTrue(feature.otas[1].enabledSyncRate)
        
        // Verify rate codes
        XCTAssertEqual(feature.otaRateCodes.count, 2)
        XCTAssertEqual(feature.otaRateCodes["bookingcomRateCode"]?.rateCodes.count, 2)
        XCTAssertEqual(feature.otaRateCodes["agodacomRateCode"]?.rateCodes.count, 1)
    }
    
    func testDecodeMinimalData() throws {
        // Arrange
        let json = """
        {
            "enabled": false
        }
        """
        
        let jsonData = json.data(using: .utf8)!
        
        // Act
        let feature = try JSONDecoder().decode(ChannelManagerFeature.self, from: jsonData)
        
        // Assert
        XCTAssertFalse(feature.enabled)
        XCTAssertTrue(feature.otas.isEmpty)
        XCTAssertTrue(feature.otaRateCodes.isEmpty)
    }
    
    func testDecodeInvalidData() {
        // Arrange
        let json = """
        {
            "invalid": true
        }
        """
        
        let jsonData = json.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(ChannelManagerFeature.self, from: jsonData)) { error in
            XCTAssertTrue(error is DecodingError)
        }
    }
    
    // MARK: - Encode Tests
    
    func testEncode() throws {
        // Arrange
        let otas = [
            Ota(otaName: "test_ota", beds24Id: "123", enabledSyncAllotment: true, enabledSyncRate: false)
        ]
        
        let rateCodes = [
            RateCode(code: "TEST1", name: "Test Rate")
        ]
        
        let rateCodeList = RateCodeList(rateCodes: rateCodes)
        let otaRateCodes = ["testRateCode": rateCodeList]
        
        let feature = ChannelManagerFeature(enabled: true, otas: otas, otaRateCodes: otaRateCodes)
        
        // Act
        let encodedData = try JSONEncoder().encode(feature)
        let decodedFeature = try JSONDecoder().decode(ChannelManagerFeature.self, from: encodedData)
        
        // Assert
        XCTAssertEqual(decodedFeature.enabled, feature.enabled)
        XCTAssertEqual(decodedFeature.otas.count, feature.otas.count)
        XCTAssertEqual(decodedFeature.otaRateCodes.count, feature.otaRateCodes.count)
        
        // Verify OTA details
        XCTAssertEqual(decodedFeature.otas[0].otaName, "test_ota")
        XCTAssertEqual(decodedFeature.otas[0].beds24Id, "123")
        XCTAssertTrue(decodedFeature.otas[0].enabledSyncAllotment)
        XCTAssertFalse(decodedFeature.otas[0].enabledSyncRate)
        
        // Verify rate codes
        let decodedRateCodes = decodedFeature.otaRateCodes["testRateCode"]?.rateCodes
        XCTAssertEqual(decodedRateCodes?.count, 1)
        XCTAssertEqual(decodedRateCodes?[0].code, "TEST1")
        XCTAssertEqual(decodedRateCodes?[0].name, "Test Rate")
    }
}

