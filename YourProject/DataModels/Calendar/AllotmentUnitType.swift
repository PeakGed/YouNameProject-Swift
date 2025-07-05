//
//  AllotmentUnitType.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//

import Foundation

struct AllotmentUnitType: Codable {
    let roomType: RoomType
    
    init(roomType: RoomType) {
        self.roomType = roomType
    }
    
    enum CodingKeys: String, CodingKey {
        case roomType = "room_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        roomType = try container.decode(RoomType.self, forKey: .roomType)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(roomType, forKey: .roomType)
    }
}

extension AllotmentUnitType {
    struct RoomType: Codable {
        let id: Int
        let name: String
        let units: [Unit]
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case units
        }

        init(id: Int, name: String, units: [Unit]) {
            self.id = id
            self.name = name
            self.units = units
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)
            units = try container.decode([Unit].self, forKey: .units)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(units, forKey: .units)
        }
    }
    
    struct Unit: Codable {
        let id: Int
        let name: String
        let status: String
        let reservableDateRanges: [String]
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case status
            case reservableDateRanges = "reservable_date_ranges"
        }
        
        init(id: Int, name: String, status: String, reservableDateRanges: [String]) {
            self.id = id
            self.name = name
            self.status = status
            self.reservableDateRanges = reservableDateRanges
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)
            status = try container.decode(String.self, forKey: .status)
            reservableDateRanges = try container.decode([String].self, forKey: .reservableDateRanges)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(status, forKey: .status)
            try container.encode(reservableDateRanges, forKey: .reservableDateRanges)
        }
    }
}


/*
 {
     "room_type": {
         "id": 179,
         "name": "Duluxe Room",
         "units": [
             {
                 "id": 644,
                 "name": "5",
                 "status": "AVAILABLE",
                 "reservable_date_ranges": [
                     "2020-01-01",
                     "2020-01-02",
                     "2020-01-03"
                 ]
             }
         ]
     }
 }
 */
