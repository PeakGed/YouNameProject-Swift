//
//  BookingChannel.swift
//  YourProject
//
//  Created by IntrodexMini on 11/6/2568 BE.
//

import Foundation

struct BookingChannel: Codable {
    
    let id: Int
    let name: String
    let feeRate: Double
    let subChannels: [SubChannel]
    let createdAt: Date
    let updatedAt: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        feeRate = try {
            let feeRateString = try container.decode(String.self, forKey: .feeRate)
            return Double(feeRateString) ?? 0.0
        }()
        subChannels = try container.decode([SubChannel].self, forKey: .subChannels)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(String(feeRate), forKey: .feeRate)
        try container.encode(subChannels, forKey: .subChannels)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
}

extension BookingChannel {
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
            feeRate = try container.decode(Double.self, forKey: .feeRate)
            
            let dateFormat = FormConfig.DateFormat.datetimeISO
            createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
            updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(feeRate, forKey: .feeRate)
            
            let dateFormat = FormConfig.DateFormat.datetimeISO
            try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
            try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
        }
    }
}

extension BookingChannel {

     enum CodingKeys: String, CodingKey {
        case id
        case name
        case feeRate = "fee_rate"
        case subChannels = "sub_channels"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    enum FilterBy {
        case id(id: Int)
        case name(name: String)
    }
    
    enum SortBy {
        case id
        case name
        case createdAt
        case updatedAt
    }
}


/*
 json response
 {
         "id": 7,
         "name": "Online Travel Agent (OTA)",
         "fee_rate": "0.0",
         "created_at": "2017-01-18T11:33:19.931+07:00",
         "updated_at": "2017-01-18T11:33:19.931+07:00",
         "sub_channels": [
             {
                 "id": 35,
                 "name": "Beds24",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:33:10.466+07:00",
                 "updated_at": "2024-02-26T21:33:10.466+07:00"
             },
             {
                 "id": 33,
                 "name": "Tiket.com",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:32:59.268+07:00",
                 "updated_at": "2024-02-26T21:32:59.268+07:00"
             },
             {
                 "id": 32,
                 "name": "Hotels.com",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:32:53.816+07:00",
                 "updated_at": "2024-02-26T21:32:53.816+07:00"
             },
             {
                 "id": 30,
                 "name": "Instagram",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:32:30.216+07:00",
                 "updated_at": "2024-02-26T21:32:30.216+07:00"
             },
             {
                 "id": 29,
                 "name": "Google",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:32:24.509+07:00",
                 "updated_at": "2024-02-26T21:32:24.509+07:00"
             },
             {
                 "id": 28,
                 "name": "Trivago",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:32:18.578+07:00",
                 "updated_at": "2024-02-26T21:32:18.578+07:00"
             },
             {
                 "id": 27,
                 "name": "Hostelworld",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:32:13.063+07:00",
                 "updated_at": "2024-02-26T21:32:13.063+07:00"
             },
             {
                 "id": 26,
                 "name": "Tripadvisor",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:32:00.755+07:00",
                 "updated_at": "2024-02-26T21:32:00.755+07:00"
             },
             {
                 "id": 25,
                 "name": "Other",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:31:55.438+07:00",
                 "updated_at": "2024-02-26T21:31:55.438+07:00"
             },
             {
                 "id": 24,
                 "name": "Traveloka",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:31:48.827+07:00",
                 "updated_at": "2024-02-26T21:31:48.827+07:00"
             },
             {
                 "id": 22,
                 "name": "Make My Trip Group ",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:31:16.749+07:00",
                 "updated_at": "2024-02-26T21:31:16.749+07:00"
             },
             {
                 "id": 21,
                 "name": "Sawadee.com",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:31:11.524+07:00",
                 "updated_at": "2024-02-26T21:31:11.524+07:00"
             },
             {
                 "id": 20,
                 "name": "Hoteliers.Guru ",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:31:05.918+07:00",
                 "updated_at": "2024-02-26T21:31:05.918+07:00"
             },
             {
                 "id": 19,
                 "name": "Metglobal",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:31:00.332+07:00",
                 "updated_at": "2024-02-26T21:31:00.332+07:00"
             },
             {
                 "id": 18,
                 "name": "TripConnect Instant Booking ",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:30:54.369+07:00",
                 "updated_at": "2024-02-26T21:30:54.369+07:00"
             },
             {
                 "id": 17,
                 "name": "Hotelscombined.com / Revato ",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:30:49.170+07:00",
                 "updated_at": "2024-02-26T21:30:49.170+07:00"
             },
             {
                 "id": 16,
                 "name": "HRS ",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:30:43.572+07:00",
                 "updated_at": "2024-02-26T21:30:43.572+07:00"
             },
             {
                 "id": 15,
                 "name": "Asia Travel ",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:30:38.459+07:00",
                 "updated_at": "2024-02-26T21:30:38.459+07:00"
             },
             {
                 "id": 14,
                 "name": "GTA ",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:30:31.318+07:00",
                 "updated_at": "2024-02-26T21:30:31.318+07:00"
             },
             {
                 "id": 13,
                 "name": "Hotelbeds ",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:30:26.315+07:00",
                 "updated_at": "2024-02-26T21:30:26.315+07:00"
             },
             {
                 "id": 12,
                 "name": "Orbitz ",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:30:20.578+07:00",
                 "updated_at": "2024-02-26T21:30:20.578+07:00"
             },
             {
                 "id": 11,
                 "name": "Wide Discovery ",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:30:13.264+07:00",
                 "updated_at": "2024-02-26T21:30:13.264+07:00"
             },
             {
                 "id": 10,
                 "name": "Hotel Trabel ",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:30:00.304+07:00",
                 "updated_at": "2024-02-26T21:30:00.304+07:00"
             },
             {
                 "id": 9,
                 "name": "Ctrip",
                 "fee_rate": 0.0,
                 "created_at": "2024-02-26T21:29:49.132+07:00",
                 "updated_at": "2024-02-26T21:29:49.132+07:00"
             },
             {
                 "id": 8,
                 "name": "Expedia",
                 "fee_rate": 0.0,
                 "created_at": "2020-05-07T07:36:43.688+07:00",
                 "updated_at": "2024-02-26T21:29:35.375+07:00"
             },
             {
                 "id": 4,
                 "name": "Agoda.com",
                 "fee_rate": 0.0,
                 "created_at": "2017-01-18T11:37:37.197+07:00",
                 "updated_at": "2024-02-26T21:28:33.206+07:00"
             },
             {
                 "id": 3,
                 "name": "Booking.com",
                 "fee_rate": 0.0,
                 "created_at": "2017-01-18T11:37:19.997+07:00",
                 "updated_at": "2024-02-26T21:28:24.422+07:00"
             },
             {
                 "id": 1,
                 "name": "Airbnb",
                 "fee_rate": 0.0,
                 "created_at": "2017-01-18T11:36:47.893+07:00",
                 "updated_at": "2024-02-26T21:27:17.097+07:00"
             }
         ],
         "images": []
     }
 */
