//
//  CMRate.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import Foundation

class CMRate: Codable {
    
    var id: Int?
    var cmRoomID: Int
    var cmRateID: String
    var offerID: String
    var name: String
    var description: String
    var minNight: Int
    var maxNight: Int
    var minAdvance: Int
    var maxAdvance: Int
    var strategy: Strategy
    var firstNight: Date
    var lastNight: Date
    
    var roomPrice: RateOption
    var roomPriceGuest: Double
    
    var onePersonPrice: RateOption
    var twoPersonPrice: RateOption
    var extraPersonPrice: RateOption
    var extraChildPrice: RateOption
    
    // weekend , weekday
    var availableDay: DayOption
    
    var hmsUnitType: UnitType
    var hmsUnitID: Int
    var hmsUnitDetail: UnitTypeDetail
    //var rawResponse: Any
    var isDefault: Bool
    var hotelID: Int
    
    var createdAt: Date
    var updatedAt: Date
    
    init(id: Int,
         cmRoomID: Int,
         cmRateID: String,
         offerID: String,
         name: String,
         description: String,
         minNight: Int,
         maxNight: Int,
         minAdvance: Int,
         maxAdvance: Int,
         strategy: Strategy,
         firstNight: Date,
         lastNight: Date,
         roomPrice: RateOption,
         roomPriceGuest: Double,
         onePersonPrice: RateOption,
         twoPersonPrice: RateOption,
         extraPersonPrice: RateOption,
         extraChildPrice: RateOption,
         availableDay: DayOption,
         hmsUnitType: UnitType,
         hmsUnitID: Int,
         hmsUnitDetail: UnitTypeDetail,
         isDefault: Bool,
         hotelID: Int,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.cmRoomID = cmRoomID
        self.cmRateID = cmRateID
        self.offerID = offerID
        self.name = name
        self.description = description
        self.minNight = minNight
        self.maxNight = maxNight
        self.minAdvance = minAdvance
        self.maxAdvance = maxAdvance
        self.strategy = strategy
        self.firstNight = firstNight
        self.lastNight = lastNight
        self.roomPrice = roomPrice
        self.roomPriceGuest = roomPriceGuest
        self.onePersonPrice = onePersonPrice
        self.twoPersonPrice = twoPersonPrice
        self.extraPersonPrice = extraPersonPrice
        self.extraChildPrice = extraChildPrice
        self.availableDay = availableDay
        self.hmsUnitType = hmsUnitType
        self.hmsUnitID = hmsUnitID
        self.hmsUnitDetail = hmsUnitDetail
        self.isDefault = isDefault
        self.hotelID = hotelID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    //decoder
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        cmRoomID = try container.decode(Int.self, forKey: .cmRoomID)
        cmRateID = try container.decode(String.self, forKey: .cmRateID)
        offerID = try container.decode(String.self, forKey: .offerID)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        minNight = try container.decode(Int.self, forKey: .minNight)
        maxNight = try container.decode(Int.self, forKey: .maxNight)
        minAdvance = try container.decode(Int.self, forKey: .minAdvance)
        maxAdvance = try container.decode(Int.self, forKey: .maxAdvance)
        strategy = try container.decode(Strategy.self, forKey: .strategy)
        firstNight = try container.decode(Date.self, forKey: .firstNight)
        lastNight = try container.decode(Date.self, forKey: .lastNight)
        roomPrice = try container.decode(RateOption.self, forKey: .roomPrice)
        roomPriceGuest = try container.decode(Double.self, forKey: .roomPriceGuest)
        onePersonPrice = try container.decode(RateOption.self, forKey: .onePersonPrice)
        twoPersonPrice = try container.decode(RateOption.self, forKey: .twoPersonPrice)
        extraPersonPrice = try container.decode(RateOption.self, forKey: .extraPersonPrice)
        extraChildPrice = try container.decode(RateOption.self, forKey: .extraChildPrice)
        availableDay = try container.decode(DayOption.self, forKey: .availableDay)
        hmsUnitType = try container.decode(UnitType.self, forKey: .hmsUnitType)
        hmsUnitID = try container.decode(Int.self, forKey: .hmsUnitID)
        hmsUnitDetail = try container.decode(UnitTypeDetail.self, forKey: .hmsUnitDetail)
        isDefault = try container.decode(Bool.self, forKey: .isDefault)
        hotelID = try container.decode(Int.self, forKey: .hotelID)
        createdAt = try container.decode(Date.self, forKey: .createdAt)
        updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }

    //encoder
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(cmRoomID, forKey: .cmRoomID)
        try container.encode(cmRateID, forKey: .cmRateID)
        try container.encode(offerID, forKey: .offerID)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(minNight, forKey: .minNight)
        try container.encode(maxNight, forKey: .maxNight)
        try container.encode(minAdvance, forKey: .minAdvance)
        try container.encode(maxAdvance, forKey: .maxAdvance)
        try container.encode(strategy, forKey: .strategy)
        try container.encode(firstNight, forKey: .firstNight)
        try container.encode(lastNight, forKey: .lastNight)
        try container.encode(roomPrice, forKey: .roomPrice)
        try container.encode(roomPriceGuest, forKey: .roomPriceGuest)
        try container.encode(onePersonPrice, forKey: .onePersonPrice)
        try container.encode(twoPersonPrice, forKey: .twoPersonPrice)
        try container.encode(extraPersonPrice, forKey: .extraPersonPrice)
        try container.encode(extraChildPrice, forKey: .extraChildPrice)
        try container.encode(availableDay, forKey: .availableDay)
        try container.encode(hmsUnitType, forKey: .hmsUnitType)
        try container.encode(hmsUnitID, forKey: .hmsUnitID)
        try container.encode(hmsUnitDetail, forKey: .hmsUnitDetail)
        try container.encode(isDefault, forKey: .isDefault)
        try container.encode(hotelID, forKey: .hotelID)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
    }
}

extension CMRate {

    enum CodingKeys: String, CodingKey {
        case id
        case cmRoomID = "cm_room_id"
        case cmRateID = "rate_id"
        case offerID = "offer_id"
        case name
        case description
        case minNight = "min_nights"
        case maxNight = "max_nights"
        case minAdvance = "min_advance"
        case maxAdvance = "max_advance"
        case strategy = "strategy"
        case firstNight = "first_night"
        case lastNight = "last_night"
        case roomPrice = "room_price"
        case roomPriceGuest = "room_price_guests"
        case onePersonPrice = "one_person_price"
        case twoPersonPrice = "two_people_price"
        case extraPersonPrice = "extra_person_price"
        case extraChildPrice = "extra_child_price"
        case availableDay = "can_in_mon"
        case hmsUnitType = "hms_unit_type"
        case hmsUnitID = "hms_unit_id"
        case hmsUnitDetail = "hms_unit_detail"
        case isDefault = "is_default"
        case hotelID = "hotel_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    enum Strategy: Int, Codable {
        case _default = 0
        case doNotAllowLowerPricesOrShorterStays = 1
        case doNotAllowAnyOtherRate = 2
        
        var value: Int { self.rawValue }
    }
    
    enum UnitType: String, Codable {
        case roomType = "ROOM_TYPE"
    }
    
    struct UnitTypeDetail: Codable {
        var id: Int
        var name: String
        var baseRate: Double
        var data: Any?

        init(id: Int, name: String, baseRate: Double, data: Any?) {
            self.id = id
            self.name = name
            self.baseRate = baseRate
            self.data = data
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)
            baseRate = try container.decode(Double.self, forKey: .baseRate)
            //data = try container.decode(Any.self, forKey: .data)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(baseRate, forKey: .baseRate)
         //   try container.encode(data, forKey: .data)
        }

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case baseRate
            case data
        }
    }
    
    struct DayOption: Codable {
        var mon: Bool
        var tue: Bool
        var wed: Bool
        var thu: Bool
        var fri: Bool
        var sat: Bool
        var sun: Bool

        init(mon: Bool, tue: Bool, wed: Bool, thu: Bool, fri: Bool, sat: Bool, sun: Bool) {
            self.mon = mon
            self.tue = tue
            self.wed = wed
            self.thu = thu
            self.fri = fri
            self.sat = sat
            self.sun = sun
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            mon = try container.decode(Bool.self, forKey: .mon)
            tue = try container.decode(Bool.self, forKey: .tue)
            wed = try container.decode(Bool.self, forKey: .wed)
            thu = try container.decode(Bool.self, forKey: .thu)
            fri = try container.decode(Bool.self, forKey: .fri)
            sat = try container.decode(Bool.self, forKey: .sat)
            sun = try container.decode(Bool.self, forKey: .sun)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(mon, forKey: .mon)
            try container.encode(tue, forKey: .tue)
            try container.encode(wed, forKey: .wed)
            try container.encode(thu, forKey: .thu)
            try container.encode(fri, forKey: .fri)
            try container.encode(sat, forKey: .sat)
            try container.encode(sun, forKey: .sun)
        }

        enum CodingKeys: String, CodingKey {
            case mon
            case tue
            case wed
            case thu
            case fri
            case sat
            case sun
        }
    }
    
    struct RateOption: Codable {
        var enable: Bool
        var rate: Double

        init(enable: Bool, rate: Double) {
            self.enable = enable
            self.rate = rate
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            enable = try container.decode(Bool.self, forKey: .enable)
            rate = try container.decode(Double.self, forKey: .rate)
        }
        
        //encoder
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(enable, forKey: .enable)
            try container.encode(rate, forKey: .rate)
        }

        enum CodingKeys: String, CodingKey {
            case enable
            case rate
        }
    }
}
