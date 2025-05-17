//
//  Additional.swift
//  YourProject
//
//  Created by IntrodexMini on 17/5/2568 BE.
//
import Foundation

struct Additional: Codable {
    let id: Int
    let status: String
    let note: String
    let dateIssue: Date
    let totalAmount: Double
    let creator: Creator
    let createdAt: Date
    let updatedAt: Date
    let hotelId: Int
    let reservationId: Int
    let additionalItems: AdditionalItems
    
    private enum CodingKeys: String, CodingKey {
        case id
        case status
        case note
        case dateIssue = "date_issue"
        case totalAmount = "total_amount"
        case creator
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hotelId = "hotel_id"
        case reservationId = "reservation_id"
        case additionalItems = "additional_items"
    }
    
    init(id: Int,
         status: String,
         note: String,
         dateIssue: Date,
         totalAmount: Double,
         creator: Creator,
         createdAt: Date,
         updatedAt: Date,
         hotelId: Int,
         reservationId: Int,
         additionalItems: AdditionalItems) {
        self.id = id
        self.status = status
        self.note = note
        self.dateIssue = dateIssue
        self.totalAmount = totalAmount
        self.creator = creator
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.hotelId = hotelId
        self.reservationId = reservationId
        self.additionalItems = additionalItems
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        status = try container.decode(String.self, forKey: .status)
        note = try container.decode(String.self, forKey: .note)
        dateIssue = try container.decode(String.self, forKey: .dateIssue).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        totalAmount = try container.decode(String.self, forKey: .totalAmount).trytoDouble()
        creator = try container.decode(Creator.self, forKey: .creator)
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        reservationId = try container.decode(Int.self, forKey: .reservationId)
        additionalItems = try container.decode(AdditionalItems.self, forKey: .additionalItems)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(status, forKey: .status)
        try container.encode(note, forKey: .note)
        try container.encode(dateIssue.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .dateIssue)
        try container.encode(totalAmount.toString(), forKey: .totalAmount)
        try container.encode(creator, forKey: .creator)
        try container.encode(createdAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .updatedAt)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(reservationId, forKey: .reservationId)
        try container.encode(additionalItems, forKey: .additionalItems)
    }
    
    
}

extension Additional {
    struct Creator: Codable {
        let id: Int
        let email: String
        let firstName: String
        let lastName: String
        let logoImage: String?
        let role: String
        
        private enum CodingKeys: String, CodingKey {
            case id
            case email
            case firstName = "first_name"
            case lastName = "last_name"
            case logoImage = "logo_image"
            case role
        }
    }
}

/*
 json response
 {
             "id": 273,
             "status": "active",
             "note": "",
             "date_issue": "2024-04-21T00:00:00.000+07:00",
             "total_amount": "111.11",
             "creator": {
                 "id": 38,
                 "email": "test1@email.com",
                 "first_name": "John2",
                 "last_name": "Doe2",
                 "logo_image": null,
                 "role": "owner"
             },
             "created_at": "2024-04-21T13:33:16.144+07:00",
             "updated_at": "2024-04-21T13:33:16.227+07:00",
             "hotel_id": 105,
             "reservation_id": 1067,
             "additional_items": [
                 {
                     "id": 454,
                     "price": "111.11", // convert to string value format
                     "quantity": 1,
                     "total_amount": "111.11", // convert to string value format
                     "itemable_id": 130,
                     "itemable_type": "Folio",
                     "created_at": "2024-04-21T13:33:16.191+07:00",
                     "updated_at": "2024-04-21T13:33:16.191+07:00",
                     "additional_id": 273
                 }
             ]
         }
 */
