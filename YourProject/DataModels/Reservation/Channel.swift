//
//  Channal.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import Foundation

struct Channel: Codable {
    let id: Int
    let name: String
    let feeRate: Double
    let subChannels: [SubChannel]
    let images: [String]
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case feeRate = "fee_rate"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case subChannels = "sub_channels"
        case images
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        feeRate = try container.decode(String.self, forKey: .feeRate).trytoDouble()
        subChannels = try container.decode([SubChannel].self, forKey: .subChannels)
        images = try container.decode([String].self, forKey: .images)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    init(id: Int,
         name: String,
         feeRate: Double,
         subChannels: [SubChannel] = [],
         images: [String] = [],
         createdAt: Date = Date(),
         updatedAt: Date = Date()) {
        self.id = id
        self.name = name
        self.feeRate = feeRate
        self.subChannels = subChannels
        self.images = images
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(feeRate.toString(), forKey: .feeRate)
        try container.encode(subChannels, forKey: .subChannels)
        try container.encode(images, forKey: .images)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
}

struct SubChannel: Codable {
    let id: Int
    let name: String
    let feeRate: Double
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case feeRate = "fee_rate"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        feeRate = try container.decode(String.self, forKey: .feeRate).trytoDouble()
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    init(id: Int,
         name: String,
         feeRate: Double,
         createdAt: Date = Date(),
         updatedAt: Date = Date()) {
        self.id = id
        self.name = name
        self.feeRate = feeRate
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(feeRate.toString(), forKey: .feeRate)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
}

/*
 json response
 {
 "id": 4,
 "name": "Social Media",
 "fee_rate": 0.0,
 "created_at": "2017-01-18T11:30:40.415+07:00",
 "updated_at": "2017-03-09T23:51:29.629+07:00",
 "sub_channels": [
 {
 "id": 31,
 "name": "Travel together (เที่ยวด้วยกัน)",
 "fee_rate": 0.0,
 "created_at": "2024-02-26T21:32:48.594+07:00",
 "updated_at": "2024-02-26T21:32:48.594+07:00"
 },
 {
 "id": 23,
 "name": "fake",
 "fee_rate": 0.0,
 "created_at": "2024-02-26T21:31:37.495+07:00",
 "updated_at": "2024-02-26T21:31:37.495+07:00"
 },
 {
 "id": 7,
 "name": "Beds24",
 "fee_rate": 0.0,
 "created_at": "2020-01-16T09:24:45.520+07:00",
 "updated_at": "2024-02-26T21:29:25.527+07:00"
 }
 ],
 "images": []
 }
 */
