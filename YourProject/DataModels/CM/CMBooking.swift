//
//  CMBooking.swift
//  YourProject
//
//  Created by IntrodexMini on 8/7/2568 BE.
//

import Foundation

struct CMBooking: Codable {
    
    let id: Int
    
    let hotelID: Int
    let kind: Kind
    let unitTypeDetail: UnitTypeDetail
    let firstNight: Date
    let lastNight: Date

    var period: PeriodDate {
        .init(start: firstNight,
              end: lastNight.getTomorrowDate() ?? lastNight)
    }
    
    let cmBookID: String
    let cmRoomID: String
    let cmStatus: CMBookingRaw.Status
    let raw: CMBookingRaw
    
    let createdAt: Date
    let updatedAt: Date
    
    let hmsReservationID: Int?
    
    var unitCount: Int {
        raw.roomCount
    }
    
    init(id: Int,
         hotelID: Int,
         kind: Kind,
         unitTypeDetail: UnitTypeDetail,
         firstNight: Date,
         lastNight: Date,
         cmBookID: String,
         cmRoomID: String,
         cmStatus: CMBookingRaw.Status,
         raw: CMBookingRaw,
         hmsReservationID: Int?,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.hotelID = hotelID
        self.kind = kind
        self.unitTypeDetail = unitTypeDetail
        self.firstNight = firstNight
        self.lastNight = lastNight
        self.cmBookID = cmBookID
        self.cmRoomID = cmRoomID
        self.cmStatus = cmStatus
        self.raw = raw
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.hmsReservationID = hmsReservationID
    }
    
    //decode
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        hotelID = try values.decode(Int.self, forKey: .hotelID)
        kind = try values.decode(Kind.self, forKey: .kind)
        unitTypeDetail = try values.decode(UnitTypeDetail.self, forKey: .unitTypeDetail)
        
        cmBookID = try values.decode(String.self, forKey: .cmBookID)
        cmRoomID = try values.decode(String.self, forKey: .cmRoomID)
        cmStatus = try values.decode(CMBookingRaw.Status.self, forKey: .cmStatus)
        raw = try values.decode(CMBookingRaw.self, forKey: .raw)
        
        let dateFormat = FormConfig.DateFormat.yyyyMMdd
        firstNight = try values.decode(String.self, forKey: .firstNight).tryToDate(dateFormat) 
        lastNight = try values.decode(String.self, forKey: .lastNight).tryToDate(dateFormat) 
        
        createdAt = try values.decode(String.self, forKey: .createdAt).tryToDate(FormConfig.DateFormat.datetimeISO)
        updatedAt = try values.decode(String.self, forKey: .updatedAt).tryToDate(FormConfig.DateFormat.datetimeISO)
        
        hmsReservationID = try values.decodeIfPresent(Int.self, forKey: .hmsReservationID)
    }
    
    //encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(hotelID, forKey: .hotelID)
        try container.encode(kind.rawValue, forKey: .kind)
        try container.encode(unitTypeDetail, forKey: .unitTypeDetail)
        try container.encode(firstNight.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .firstNight)
        try container.encode(lastNight.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .lastNight)
        try container.encode(cmBookID, forKey: .cmBookID)
        try container.encode(cmRoomID, forKey: .cmRoomID)
        try container.encode(cmStatus.rawValue, forKey: .cmStatus)
        try container.encode(raw, forKey: .raw)
        try container.encode(createdAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .updatedAt)
        try container.encodeIfPresent(hmsReservationID, forKey: .hmsReservationID)
    }
    
    // enum
    enum CodingKeys: String, CodingKey {
        case id
        case hotelID = "hotel_id"
        case kind = "hms_unit_type"
        case unitTypeDetail = "hms_unit_detail"
        case firstNight = "first_night"
        case lastNight = "last_night"
        case cmBookID = "book_id"
        case cmRoomID = "room_id"
        case cmStatus = "status"
        case raw = "raw_response"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hmsReservationID = "hms_reservation_id"
    }
}

extension CMBooking {
    
    enum Kind: String, Codable {
        case roomType = "ROOM_TYPE"        
    }
    
    struct UnitTypeDetail: Codable {
        var id: Int
        var name: String
        var baseRate: Double
        
        init(id: Int,
             name: String,
             baseRate: Double) {
            self.id = id
            self.name = name
            self.baseRate = baseRate
        }

        // decode
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            
            id = try values.decode(Int.self, forKey: .id)
            name = try values.decode(String.self, forKey: .name)
            baseRate = try values.decode(Double.self, forKey: .baseRate)
        }
        
        //encode
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(baseRate, forKey: .baseRate)
        }
        
        //enum
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case baseRate = "base_rate"
        }
    }
}
