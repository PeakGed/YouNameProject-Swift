//
//  GuestRegisterCard.swift
//  YourProject
//
//  Created by IntrodexMini on 18/6/2568 BE.
//

import Foundation

struct GuestRegisterCard: Codable {
    let id: Int
    let hotelId: Int
    let customerId: Int
    let reservationId: Int
    let pdpaId: Int?
    
    let purposeOfVisit: PurposeOfVisit
    let fromAddress: String?
    let fromCountry: String?
    let nextAddress: String?
    let nextCountry: String?
    let remark: String?
    
    let acceptedRulesAt: Date?
    let acceptedPdpaAt: Date?
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case hotelId = "hotel_id"
        case customerId = "customer_id"
        case reservationId = "reservation_id"
        case pdpaId = "pdpa_id"
        case purposeOfVisit = "purpose_of_visit"
        case fromAddress = "from_address"
        case fromCountry = "from_country"
        case nextAddress = "next_address"
        case nextCountry = "next_country"
        case remark        
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case acceptedRulesAt = "accepted_rules_at"
        case acceptedPdpaAt = "accepted_pdpa_at"
    }
    
    init(id: Int,
         hotelId: Int,
         customerId: Int,
         reservationId: Int,
         pdpaId: Int?,
         purposeOfVisit: PurposeOfVisit,
         fromAddress: String?,
         nextAddress: String?,
         remark: String?,
         fromCountry: String?,
         nextCountry: String?,
         acceptedRulesAt: Date?,
         acceptedPdpaAt: Date?,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.purposeOfVisit = purposeOfVisit
        self.fromAddress = fromAddress
        self.nextAddress = nextAddress
        self.remark = remark
        self.fromCountry = fromCountry
        self.nextCountry = nextCountry
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.acceptedRulesAt = acceptedRulesAt
        self.acceptedPdpaAt = acceptedPdpaAt
        self.hotelId = hotelId
        self.customerId = customerId
        self.reservationId = reservationId
        self.pdpaId = pdpaId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        purposeOfVisit = try container.decode(PurposeOfVisit.self, forKey: .purposeOfVisit)
        fromAddress = try container.decodeIfPresent(String.self, forKey: .fromAddress)
        nextAddress = try container.decodeIfPresent(String.self, forKey: .nextAddress)
        remark = try container.decodeIfPresent(String.self, forKey: .remark)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        fromCountry = try container.decodeIfPresent(String.self, forKey: .fromCountry)
        nextCountry = try container.decodeIfPresent(String.self, forKey: .nextCountry)
        
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        customerId = try container.decode(Int.self, forKey: .customerId)
        reservationId = try container.decode(Int.self, forKey: .reservationId)
        pdpaId = try container.decodeIfPresent(Int.self, forKey: .pdpaId)

        acceptedRulesAt = try container.decodeIfPresent(String.self, forKey: .acceptedRulesAt)?.tryToDate(dateFormat: dateFormat)
        acceptedPdpaAt = try container.decodeIfPresent(String.self, forKey: .acceptedPdpaAt)?.tryToDate(dateFormat: dateFormat)
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(purposeOfVisit.rawValue, forKey: .purposeOfVisit)
        try container.encode(fromAddress, forKey: .fromAddress)
        try container.encode(nextAddress, forKey: .nextAddress)
        try container.encode(remark, forKey: .remark)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encode(fromCountry, forKey: .fromCountry)
        try container.encode(nextCountry, forKey: .nextCountry)        
        
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(customerId, forKey: .customerId)
        try container.encode(reservationId, forKey: .reservationId)
        try container.encode(pdpaId, forKey: .pdpaId)
        
        try container.encode(acceptedRulesAt?.toDateString(dateFormat), forKey: .acceptedRulesAt)
        try container.encode(acceptedPdpaAt?.toDateString(dateFormat), forKey: .acceptedPdpaAt)

        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
}

extension GuestRegisterCard {
    enum PurposeOfVisit: String, Codable {
        case leisure = "Leisure"
        case business = "Business"
    }
}

/*
 {
             "id": 17,
             "purpose_of_visit": "Leisure",
             "from_address": null,
             "next_address": null,
             "remark": null,
             //"guest_signature": "https://hms-heroku.s3.ap-southeast-1.amazonaws.com/documents/248d1e0f-252c-45ca-bc0c-860cc37d76c7/ED4250C1-C03A-4826-8E03-26A9AA28E558.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2I7XJ7WJNRHU7NRV%2F20250617%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250617T100309Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=7edfffed461a65c342568257bcd8787100fa225873dec32f582a5cc9ab37d268",
             //"guest_signature_updated_at": "2023-11-03T23:32:15.919+07:00",
             //"report_rr3_info": {...}, // remove
             "from_country": "THA",
             "next_country": "THA",
             "created_at": "2023-11-03T23:31:46.734+07:00",
             "updated_at": "2023-11-03T23:32:39.120+07:00",
             "accepted_rules_at": "2023-11-03T23:32:16.372+07:00",
             "accepted_pdpa_at": "2023-11-03T23:32:16.685+07:00",
             "hotel_id": 105,
             "customer_id": 267,
             "reservation_id": 987,
             "pdpa_id": 1
         }
 */
