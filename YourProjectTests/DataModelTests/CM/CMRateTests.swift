//
//  CMRateTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest

final class CMRateTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithRequiredProperties() throws {
        // Arrange & Act
        let rate = createSampleCMRate()
        
        // Assert
        XCTAssertEqual(rate.id, 1)
        XCTAssertEqual(rate.cmRoomID, 232711)
        XCTAssertEqual(rate.cmRateID, "rate123")
        XCTAssertEqual(rate.offerID, "offer456")
        XCTAssertEqual(rate.name, "Standard Rate")
        XCTAssertEqual(rate.description, "Standard room rate")
        XCTAssertEqual(rate.minNight, 1)
        XCTAssertEqual(rate.maxNight, 30)
        XCTAssertEqual(rate.minAdvance, 0)
        XCTAssertEqual(rate.maxAdvance, 365)
        XCTAssertEqual(rate.strategy, ._default)
        XCTAssertEqual(rate.roomPriceGuest, 2.0)
        XCTAssertEqual(rate.hmsUnitType, .roomType)
        XCTAssertEqual(rate.hmsUnitID, 116)
        XCTAssertEqual(rate.isDefault, true)
        XCTAssertEqual(rate.hotelID, 105)
    }
    
    func test_initWithDates() throws {
        // Arrange & Act
        let rate = createSampleCMRate()
        
        // Assert
        XCTAssertNotNil(rate.firstNight)
        XCTAssertNotNil(rate.lastNight)
        XCTAssertNotNil(rate.createdAt)
        XCTAssertNotNil(rate.updatedAt)
    }
    
    func test_initWithNestedStructs() throws {
        // Arrange & Act
        let rate = createSampleCMRate()
        
        // Assert
        XCTAssertEqual(rate.roomPrice.enable, true)
        XCTAssertEqual(rate.roomPrice.rate, 100.0)
        XCTAssertEqual(rate.onePersonPrice.enable, true)
        XCTAssertEqual(rate.onePersonPrice.rate, 80.0)
        XCTAssertEqual(rate.twoPersonPrice.enable, true)
        XCTAssertEqual(rate.twoPersonPrice.rate, 100.0)
        XCTAssertEqual(rate.extraPersonPrice.enable, true)
        XCTAssertEqual(rate.extraPersonPrice.rate, 20.0)
        XCTAssertEqual(rate.extraChildPrice.enable, false)
        XCTAssertEqual(rate.extraChildPrice.rate, 0.0)
    }
    
    func test_initWithDayOptions() throws {
        // Arrange & Act
        let rate = createSampleCMRate()
        
        // Assert
        XCTAssertEqual(rate.availableDay.mon, true)
        XCTAssertEqual(rate.availableDay.tue, true)
        XCTAssertEqual(rate.availableDay.wed, true)
        XCTAssertEqual(rate.availableDay.thu, true)
        XCTAssertEqual(rate.availableDay.fri, true)
        XCTAssertEqual(rate.availableDay.sat, true)
        XCTAssertEqual(rate.availableDay.sun, true)
    }
    
    func test_initWithUnitTypeDetail() throws {
        // Arrange & Act
        let rate = createSampleCMRate()
        
        // Assert
        XCTAssertEqual(rate.hmsUnitDetail.id, 116)
        XCTAssertEqual(rate.hmsUnitDetail.name, "6 bed")
        XCTAssertEqual(rate.hmsUnitDetail.baseRate, 100.0)
    }
    
    // MARK: - Strategy Tests
    
    func test_strategyRawValues() throws {
        XCTAssertEqual(CMRate.Strategy._default.rawValue, 0)
        XCTAssertEqual(CMRate.Strategy.doNotAllowLowerPricesOrShorterStays.rawValue, 1)
        XCTAssertEqual(CMRate.Strategy.doNotAllowAnyOtherRate.rawValue, 2)
    }
    
    func test_strategyValue() throws {
        XCTAssertEqual(CMRate.Strategy._default.value, 0)
        XCTAssertEqual(CMRate.Strategy.doNotAllowLowerPricesOrShorterStays.value, 1)
        XCTAssertEqual(CMRate.Strategy.doNotAllowAnyOtherRate.value, 2)
    }
    
    // MARK: - UnitType Tests
    
    func test_unitTypeRawValues() throws {
        XCTAssertEqual(CMRate.UnitType.roomType.rawValue, "ROOM_TYPE")
    }
    
    // MARK: - UnitTypeDetail Tests
    
    func test_unitTypeDetailInitialization() throws {
        // Arrange & Act
        let unitTypeDetail = CMRate.UnitTypeDetail(
            id: 116,
            name: "6 bed",
            baseRate: 100.0,
            data: nil
        )
        
        // Assert
        XCTAssertEqual(unitTypeDetail.id, 116)
        XCTAssertEqual(unitTypeDetail.name, "6 bed")
        XCTAssertEqual(unitTypeDetail.baseRate, 100.0)
        XCTAssertNil(unitTypeDetail.data)
    }
    
    // MARK: - DayOption Tests
    
    func test_dayOptionInitialization() throws {
        // Arrange & Act
        let dayOption = CMRate.DayOption(
            mon: true,
            tue: true,
            wed: false,
            thu: true,
            fri: false,
            sat: true,
            sun: false
        )
        
        // Assert
        XCTAssertEqual(dayOption.mon, true)
        XCTAssertEqual(dayOption.tue, true)
        XCTAssertEqual(dayOption.wed, false)
        XCTAssertEqual(dayOption.thu, true)
        XCTAssertEqual(dayOption.fri, false)
        XCTAssertEqual(dayOption.sat, true)
        XCTAssertEqual(dayOption.sun, false)
    }
    
    func test_dayOptionAllTrue() throws {
        // Arrange & Act
        let dayOption = CMRate.DayOption(
            mon: true,
            tue: true,
            wed: true,
            thu: true,
            fri: true,
            sat: true,
            sun: true
        )
        
        // Assert
        XCTAssertTrue(dayOption.mon)
        XCTAssertTrue(dayOption.tue)
        XCTAssertTrue(dayOption.wed)
        XCTAssertTrue(dayOption.thu)
        XCTAssertTrue(dayOption.fri)
        XCTAssertTrue(dayOption.sat)
        XCTAssertTrue(dayOption.sun)
    }
    
    // MARK: - RateOption Tests
    
    func test_rateOptionInitialization() throws {
        // Arrange & Act
        let rateOption = CMRate.RateOption(enable: true, rate: 150.0)
        
        // Assert
        XCTAssertEqual(rateOption.enable, true)
        XCTAssertEqual(rateOption.rate, 150.0)
    }
    
    func test_rateOptionDisabled() throws {
        // Arrange & Act
        let rateOption = CMRate.RateOption(enable: false, rate: 0.0)
        
        // Assert
        XCTAssertEqual(rateOption.enable, false)
        XCTAssertEqual(rateOption.rate, 0.0)
    }
    
    // MARK: - Codable Tests
    
    func test_strategyDecodingFromJSON() throws {
        // Arrange
        let json = """
        0
        """.data(using: .utf8)!
        
        // Act
        let strategy = try JSONDecoder().decode(CMRate.Strategy.self, from: json)
        
        // Assert
        XCTAssertEqual(strategy, ._default)
    }
    
    func test_strategyEncodingToJSON() throws {
        // Arrange
        let strategy = CMRate.Strategy.doNotAllowLowerPricesOrShorterStays
        
        // Act
        let encodedData = try JSONEncoder().encode(strategy)
        let decodedStrategy = try JSONDecoder().decode(CMRate.Strategy.self, from: encodedData)
        
        // Assert
        XCTAssertEqual(decodedStrategy, strategy)
    }
    
    func test_unitTypeDecodingFromJSON() throws {
        // Arrange
        let json = """
        "ROOM_TYPE"
        """.data(using: .utf8)!
        
        // Act
        let unitType = try JSONDecoder().decode(CMRate.UnitType.self, from: json)
        
        // Assert
        XCTAssertEqual(unitType, .roomType)
    }
    
    func test_unitTypeEncodingToJSON() throws {
        // Arrange
        let unitType = CMRate.UnitType.roomType
        
        // Act
        let encodedData = try JSONEncoder().encode(unitType)
        let decodedUnitType = try JSONDecoder().decode(CMRate.UnitType.self, from: encodedData)
        
        // Assert
        XCTAssertEqual(decodedUnitType, unitType)
    }
    
    func test_unitTypeDetailDecodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 116,
            "name": "6 bed",
            "baseRate": 100.0
        }
        """.data(using: .utf8)!
        
        // Act
        let unitTypeDetail = try JSONDecoder().decode(CMRate.UnitTypeDetail.self, from: json)
        
        // Assert
        XCTAssertEqual(unitTypeDetail.id, 116)
        XCTAssertEqual(unitTypeDetail.name, "6 bed")
        XCTAssertEqual(unitTypeDetail.baseRate, 100.0)
    }
    
    func test_dayOptionDecodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "mon": true,
            "tue": true,
            "wed": false,
            "thu": true,
            "fri": false,
            "sat": true,
            "sun": false
        }
        """.data(using: .utf8)!
        
        // Act
        let dayOption = try JSONDecoder().decode(CMRate.DayOption.self, from: json)
        
        // Assert
        XCTAssertEqual(dayOption.mon, true)
        XCTAssertEqual(dayOption.tue, true)
        XCTAssertEqual(dayOption.wed, false)
        XCTAssertEqual(dayOption.thu, true)
        XCTAssertEqual(dayOption.fri, false)
        XCTAssertEqual(dayOption.sat, true)
        XCTAssertEqual(dayOption.sun, false)
    }
    
    func test_rateOptionDecodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "enable": true,
            "rate": 150.0
        }
        """.data(using: .utf8)!
        
        // Act
        let rateOption = try JSONDecoder().decode(CMRate.RateOption.self, from: json)
        
        // Assert
        XCTAssertEqual(rateOption.enable, true)
        XCTAssertEqual(rateOption.rate, 150.0)
    }
    
    func test_rateOptionEncodingToJSON() throws {
        // Arrange
        let rateOption = CMRate.RateOption(enable: true, rate: 150.0)
        
        // Act
        let encodedData = try JSONEncoder().encode(rateOption)
        let decodedRateOption = try JSONDecoder().decode(CMRate.RateOption.self, from: encodedData)
        
        // Assert
        XCTAssertEqual(decodedRateOption.enable, rateOption.enable)
        XCTAssertEqual(decodedRateOption.rate, rateOption.rate)
    }
    
    // MARK: - Helper Methods
    
    private func createSampleCMRate() -> CMRate {
        let roomPrice = CMRate.RateOption(enable: true, rate: 100.0)
        let onePersonPrice = CMRate.RateOption(enable: true, rate: 80.0)
        let twoPersonPrice = CMRate.RateOption(enable: true, rate: 100.0)
        let extraPersonPrice = CMRate.RateOption(enable: true, rate: 20.0)
        let extraChildPrice = CMRate.RateOption(enable: false, rate: 0.0)
        
        let availableDay = CMRate.DayOption(
            mon: true,
            tue: true,
            wed: true,
            thu: true,
            fri: true,
            sat: true,
            sun: true
        )
        
        let unitTypeDetail = CMRate.UnitTypeDetail(
            id: 116,
            name: "6 bed",
            baseRate: 100.0,
            data: nil
        )
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return CMRate(
            id: 1,
            cmRoomID: 232711,
            cmRateID: "rate123",
            offerID: "offer456",
            name: "Standard Rate",
            description: "Standard room rate",
            minNight: 1,
            maxNight: 30,
            minAdvance: 0,
            maxAdvance: 365,
            strategy: ._default,
            firstNight: dateFormatter.date(from: "2020-01-01") ?? .now,
            lastNight: dateFormatter.date(from: "2020-12-31") ?? .now,
            roomPrice: roomPrice,
            roomPriceGuest: 2.0,
            onePersonPrice: onePersonPrice,
            twoPersonPrice: twoPersonPrice,
            extraPersonPrice: extraPersonPrice,
            extraChildPrice: extraChildPrice,
            availableDay: availableDay,
            hmsUnitType: .roomType,
            hmsUnitID: 116,
            hmsUnitDetail: unitTypeDetail,
            isDefault: true,
            hotelID: 105,
            createdAt: .now,
            updatedAt: .now
        )
    }
} 