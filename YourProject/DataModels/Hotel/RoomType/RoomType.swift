//
//  RoomType.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//
import Foundation

enum ReservableType: String, Codable {
    case roomType = "RoomType"
}

struct RoomType: Codable {
    let id: Int
    let hotelId: Int
    let order: Int    
    let name: String
    let description: String  

    let baseRate: Double
    let baseGuestNumber: Int
    let extraBedRate: Double
    let extraGuestRate: Double
    let maxExtraBedNumber: Int
    let maxExtraGuestNumber: Int
    let limitedNumberOfCMUnits: Int?
          
    let priceCards: LocalPriceCards    
    let rooms: Rooms
    let createdAt: Date
    let updatedAt: Date

    //init
    init(id: Int,
         hotelId: Int,
         order: Int,
         name: String,
         description: String,
         baseRate: Double,
         baseGuestNumber: Int,
         extraBedRate: Double,
         extraGuestRate: Double,
         maxExtraBedNumber: Int,
         maxExtraGuestNumber: Int,
         limitedNumberOfCMUnits: Int?,
         priceCards: LocalPriceCards = .init(),
         rooms: Rooms = .init(),
         createdAt: Date,   
         updatedAt: Date) {
        self.id = id
        self.hotelId = hotelId
        self.order = order
        self.name = name
        self.description = description
        self.baseRate = baseRate
        self.baseGuestNumber = baseGuestNumber
        self.extraBedRate = extraBedRate
        self.extraGuestRate = extraGuestRate
        self.maxExtraBedNumber = maxExtraBedNumber
        self.maxExtraGuestNumber = maxExtraGuestNumber
        self.limitedNumberOfCMUnits = limitedNumberOfCMUnits
        self.priceCards = priceCards
        self.rooms = rooms
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    //decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.hotelId = try container.decode(Int.self, forKey: .hotelId)
        self.order = try container.decode(Int.self, forKey: .order)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.baseRate = try container.decode(Double.self, forKey: .baseRate)
        self.baseGuestNumber = try container.decode(Int.self, forKey: .baseGuestNumber)
        self.extraBedRate = try container.decode(Double.self, forKey: .extraBedRate)
        self.extraGuestRate = try container.decode(Double.self, forKey: .extraGuestRate)
        self.maxExtraBedNumber = try container.decode(Int.self, forKey: .maxExtraBedNumber)
        self.maxExtraGuestNumber = try container.decode(Int.self, forKey: .maxExtraGuestNumber)
        self.limitedNumberOfCMUnits = try container.decode(Int?.self, forKey: .limitedNumberOfCMUnits)
        self.priceCards = try container.decode(LocalPriceCards.self, forKey: .priceCards)
        self.rooms = try container.decode(Rooms.self, forKey: .rooms)        
        self.createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
    }
    
    //encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(order, forKey: .order)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(baseRate, forKey: .baseRate)
        try container.encode(baseGuestNumber, forKey: .baseGuestNumber)
        try container.encode(extraBedRate, forKey: .extraBedRate)
        try container.encode(extraGuestRate, forKey: .extraGuestRate)
        try container.encode(maxExtraBedNumber, forKey: .maxExtraBedNumber)
        try container.encode(maxExtraGuestNumber, forKey: .maxExtraGuestNumber)
        try container.encode(limitedNumberOfCMUnits, forKey: .limitedNumberOfCMUnits)
        try container.encode(priceCards, forKey: .priceCards)
        try container.encode(rooms, forKey: .rooms)
        try container.encode(createdAt.toDateString(FormConfig.DateFormat.datetimeISO),
                             forKey: .createdAt)
        try container.encode(updatedAt.toDateString(FormConfig.DateFormat.datetimeISO),
                             forKey: .updatedAt)
    }

    //keys
    enum CodingKeys: String, CodingKey {
        case id
        case hotelId = "hotel_id"
        case order
        case name
        case description
        case baseRate = "base_rate"
        case baseGuestNumber = "base_guest_number"
        case extraBedRate = "extra_bed_rate"
        case extraGuestRate = "extra_guest_rate"
        case maxExtraBedNumber = "max_extra_bed_number"
        case maxExtraGuestNumber = "max_extra_guest_number"
        case limitedNumberOfCMUnits = "limited_number_of_cm_units"
        case priceCards = "price_cards"
        case rooms = "rooms"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    
}



/*
 {
     "room_types": [
         {
             "id": 179,
             "name": "Duluxe Room",
             "base_rate": 520.0,
             "base_guest_number": 30,
             "extra_bed_rate": 500.0,
             "extra_guest_rate": 200.0,
             "max_extra_bed_number": 1,
             "max_extra_guest_number": 1,
             "limited_number_of_cm_units": null,
             "description": "test description",
             "tags": [],
             "data": null,
             "order": 0,
             "created_at": "2019-11-28T11:08:41.259+07:00",
             "updated_at": "2024-05-23T14:12:58.166+07:00",
             "price_cards": [
       
             ]
         },
         {
             "id": 180,
             "name": "City View",
             "base_rate": 500.0,
             "base_guest_number": 1,
             "extra_bed_rate": 999.0,
             "extra_guest_rate": 888.0,
             "max_extra_bed_number": 2,
             "max_extra_guest_number": 2,
             "limited_number_of_cm_units": null,
             "description": "",
             "tags": [],
             "data": null,
             "order": 1,
             "created_at": "2020-01-15T20:27:46.577+07:00",
             "updated_at": "2024-06-13T18:26:32.372+07:00",
             "price_cards": [
                 {
                     "id": 259,
                     "title": "rate bb",
                     "description": "tf",
                     "price": 0.0,
                     "total_price": "0.0",
                     "period_types": [
                         "Mon",
                         "Fri",
                         "Sun",
                         "Thu",
                         "Wed",
                         "Sat",
                         "Tue"
                     ],
                     "exception_dates": [],
                     "reservable_type_id": 180,
                     "reservable_type_type": "RoomType",
                     "code": null,
                     "color": null,
                     "bf": {
                         "included": false,
                         "adult": {
                             "price": "0.0",
                             "limit": 0,
                             "extra_rate": "0.0",
                             "extra_limit": 0
                         },
                         "child": {
                             "price": "0.0",
                             "limit": 0,
                             "extra_rate": "0.0",
                             "extra_limit": 0
                         }
                     },
                     "channels": [
                         {
                             "channel_id": 7,
                             "sub_channel_id": 20
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 18
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 19
                         },
                         {
                             "channel_id": 4,
                             "sub_channel_id": 23
                         },
                         {
                             "channel_id": 6,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 28
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 25
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 14
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 11
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 29
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 24
                         },
                         {
                             "channel_id": 5,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 17
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 16
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 21
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 26
                         },
                         {
                             "channel_id": 11,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 12
                         },
                         {
                             "channel_id": 10,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 4,
                             "sub_channel_id": 7
                         },
                         {
                             "channel_id": 4,
                             "sub_channel_id": 31
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 15
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 27
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 30
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 33
                         },
                         {
                             "channel_id": 8,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 9,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 35
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 13
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 8
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 1
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 4
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 3
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 10
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 32
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 22
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 9
                         }
                     ],
                     "pinned": false,
                     "start_at": null,
                     "end_at": null,
                     "created_at": "2024-04-13T17:05:46.262+07:00",
                     "updated_at": "2024-04-15T21:12:42.638+07:00",
                     "hotel_id": 105
                 },
                 {
                     "id": 258,
                     "title": "rate A",
                     "description": "desp a",
                     "price": 9.0,
                     "total_price": "109.0",
                     "period_types": [
                         "Fri",
                         "Sat",
                         "Sun"
                     ],
                     "exception_dates": [],
                     "reservable_type_id": 180,
                     "reservable_type_type": "RoomType",
                     "code": null,
                     "color": "#bfbfbf",
                     "bf": {
                         "included": false,
                         "adult": {
                             "price": "50.0",
                             "limit": 1,
                             "extra_rate": "50.0",
                             "extra_limit": 1
                         },
                         "child": {
                             "price": "50.0",
                             "limit": 1,
                             "extra_rate": "50.0",
                             "extra_limit": 1
                         }
                     },
                     "channels": [
                         {
                             "channel_id": 7,
                             "sub_channel_id": 4
                         },
                         {
                             "channel_id": 5,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 30
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 20
                         },
                         {
                             "channel_id": 6,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 33
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 32
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 3
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 35
                         },
                         {
                             "channel_id": 4,
                             "sub_channel_id": 31
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 10
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 14
                         },
                         {
                             "channel_id": 4,
                             "sub_channel_id": 23
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 13
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 12
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 18
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 15
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 16
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 17
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 8
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 25
                         },
                         {
                             "channel_id": 4,
                             "sub_channel_id": 7
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 19
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 26
                         },
                         {
                             "channel_id": 8,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 9,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 29
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 11
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 24
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 1
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 21
                         },
                         {
                             "channel_id": 10,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 9
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 27
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 28
                         },
                         {
                             "channel_id": 11,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 22
                         }
                     ],
                     "pinned": false,
                     "start_at": null,
                     "end_at": null,
                     "created_at": "2024-04-13T13:33:24.916+07:00",
                     "updated_at": "2024-04-15T19:45:14.474+07:00",
                     "hotel_id": 105
                 },
                 {
                     "id": 257,
                     "title": "13 Apr",
                     "description": "",
                     "price": 888.0,
                     "total_price": "888.0",
                     "period_types": [
                         "Mon",
                         "Tue",
                         "Fri",
                         "Thu",
                         "Sun",
                         "Wed",
                         "Sat"
                     ],
                     "exception_dates": [],
                     "reservable_type_id": 180,
                     "reservable_type_type": "RoomType",
                     "code": null,
                     "color": "#ffff98",
                     "bf": {
                         "included": false,
                         "adult": {
                             "price": "50.0",
                             "limit": 1,
                             "extra_rate": "150.0",
                             "extra_limit": 3
                         },
                         "child": {
                             "price": "100.0",
                             "limit": 2,
                             "extra_rate": "300.0",
                             "extra_limit": 6
                         }
                     },
                     "channels": [
                         {
                             "channel_id": 7,
                             "sub_channel_id": 27
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 15
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 11
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 8
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 25
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 29
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 20
                         },
                         {
                             "channel_id": 11,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 10
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 16
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 26
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 3
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 32
                         },
                         {
                             "channel_id": 4,
                             "sub_channel_id": 23
                         },
                         {
                             "channel_id": 6,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 8,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 14
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 13
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 19
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 4
                         },
                         {
                             "channel_id": 10,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 28
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 30
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 33
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 17
                         },
                         {
                             "channel_id": 4,
                             "sub_channel_id": 31
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 22
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 9
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 21
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 1
                         },
                         {
                             "channel_id": 5,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 9,
                             "sub_channel_id": null
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 18
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 35
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 12
                         },
                         {
                             "channel_id": 4,
                             "sub_channel_id": 7
                         },
                         {
                             "channel_id": 7,
                             "sub_channel_id": 24
                         }
                     ],
                     "pinned": false,
                     "start_at": "2024-04-13T00:00:00.000Z",
                     "end_at": "2024-04-13T00:00:00.000Z",
                     "created_at": "2024-04-13T06:32:53.170+07:00",
                     "updated_at": "2024-04-13T13:30:55.166+07:00",
                     "hotel_id": 105
                 },
                 {
                     "id": 256,
                     "title": "Walk in",
                     "description": "akkkkkkkkk  lllloo",
                     "price": 850.0,
                     "total_price": "1300.0",
                     "period_types": [
                         "Wed",
                         "Thu",
                         "Sat",
                         "Sun",
                         "Mon",
                         "Fri",
                         "Tue"
                     ],
                     "exception_dates": [],
                     "reservable_type_id": 180,
                     "reservable_type_type": "RoomType",
                     "code": "WALKP",
                     "color": "#984b6d",
                     "bf": {
                         "included": true,
                         "adult": {
                             "price": "300.0",
                             "limit": 1,
                             "extra_rate": "50.0",
                             "extra_limit": 1
                         },
                         "child": {
                             "price": "150.0",
                             "limit": 1,
                             "extra_rate": "50.0",
                             "extra_limit": 1
                         }
                     },
                     "channels": [
                         {
                             "channel_id": 6,
                             "sub_channel_id": null
                         }
                     ],
                     "pinned": false,
                     "start_at": "2024-04-12T00:00:00.000Z",
                     "end_at": "2024-04-15T00:00:00.000Z",
                     "created_at": "2024-04-12T21:58:09.352+07:00",
                     "updated_at": "2024-04-13T13:30:29.427+07:00",
                     "hotel_id": 105
                 },
                 {
                     "id": 234,
                     "title": "เรทธรรมดา โปรโม",
                     "description": "",
                     "price": 999.0,
                     "total_price": "999.0",
                     "period_types": [
                         "Mon",
                         "Wed",
                         "Thu",
                         "Tue"
                     ],
                     "exception_dates": [],
                     "reservable_type_id": 180,
                     "reservable_type_type": "RoomType",
                     "code": null,
                     "color": null,
                     "bf": {
                         "included": false,
                         "adult": {
                             "price": "0.0",
                             "limit": 0,
                             "extra_rate": "0.0",
                             "extra_limit": 0
                         },
                         "child": {
                             "price": "0.0",
                             "limit": 0,
                             "extra_rate": "0.0",
                             "extra_limit": 0
                         }
                     },
                     "channels": [
                         {
                             "channel_id": 1,
                             "sub_channel_id": null
                         }
                     ],
                     "pinned": false,
                     "start_at": "2024-01-19T00:00:00.000Z",
                     "end_at": "2024-01-31T00:00:00.000Z",
                     "created_at": "2023-09-18T12:37:15.506+07:00",
                     "updated_at": "2024-03-16T15:49:43.826+07:00",
                     "hotel_id": 105
                 }
             ],
             "hotel_id": 105,
             "images": [],
             "rooms": [
                 {
                     "id": 644,
                     "code": "5",
                     "status": "available",
                     "need_cleaning": true,
                     "data": {},
                     "order": 0,
                     "created_at": "2022-01-11T00:50:21.937+07:00",
                     "updated_at": "2023-06-24T15:40:31.474+07:00",
                     "room_type_id": 180,
                     "images": []
                 },
                 {
                     "id": 643,
                     "code": "4",
                     "status": "available",
                     "need_cleaning": true,
                     "data": {},
                     "order": 0,
                     "created_at": "2022-01-11T00:50:05.682+07:00",
                     "updated_at": "2023-06-24T15:40:31.155+07:00",
                     "room_type_id": 180,
                     "images": []
                 },
                 {
                     "id": 624,
                     "code": "3",
                     "status": "available",
                     "need_cleaning": true,
                     "data": {},
                     "order": 0,
                     "created_at": "2020-01-15T20:27:51.061+07:00",
                     "updated_at": "2023-06-24T15:40:29.593+07:00",
                     "room_type_id": 180,
                     "images": []
                 },
                 {
                     "id": 623,
                     "code": "2",
                     "status": "available",
                     "need_cleaning": true,
                     "data": {},
                     "order": 0,
                     "created_at": "2020-01-15T20:27:51.054+07:00",
                     "updated_at": "2023-06-24T15:40:30.461+07:00",
                     "room_type_id": 180,
                     "images": []
                 },
                 {
                     "id": 622,
                     "code": "1",
                     "status": "available",
                     "need_cleaning": false,
                     "data": {},
                     "order": 0,
                     "created_at": "2020-01-15T20:27:51.042+07:00",
                     "updated_at": "2023-11-14T17:55:02.923+07:00",
                     "room_type_id": 180,
                     "images": []
                 }
             ]
         }
     ]
 }
 */
