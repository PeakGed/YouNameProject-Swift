//
//  LocalPriceCardServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 28/2/2568 BE.
//
import Foundation

struct LocalPriceCardServiceRequest {
    struct FetchPriceCards: Encodable {
        let hotelId: Int?
        let startDate: String?
        let endDate: String?
        let channelId: Int?
        let subChannelId: Int?
        let reservableTypeType: String?
        let reservableTypeId: Int?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case startDate = "start_date"
            case endDate = "end_date"
            case channelId = "channel_id"
            case subChannelId = "sub_channel_id"
            case reservableTypeType = "reservable_type_type"
            case reservableTypeId = "reservable_type_id"
        }
    }
    
    struct GetPriceCard: Encodable {
        let id: Int
        
        // No CodingKeys needed as this is used for URL path only
    }
    
    struct CreatePriceCard: Encodable {
        let hotelId: Int
        let title: String
        let reservableTypeId: Int
        let reservableTypeType: String
        let price: Double
        let description: String?
        let code: String?
        let color: String?
        let bfIncluded: Bool?
        let bfAdultPrice: Double?
        let bfAdultLimit: Int?
        let bfAdultExtraRate: Double?
        let bfAdultExtraLimit: Int?
        let bfChildPrice: Double?
        let bfChildLimit: Int?
        let bfChildExtraRate: Double?
        let bfChildExtraLimit: Int?
        let startAt: String
        let endAt: String
        let channels: [String]?
        let pinned: Bool?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case title
            case reservableTypeId = "reservable_type_id"
            case reservableTypeType = "reservable_type_type"
            case price
            case description
            case code
            case color
            case bfIncluded = "bf_included"
            case bfAdultPrice = "bf_adult_price"
            case bfAdultLimit = "bf_adult_limit"
            case bfAdultExtraRate = "bf_adult_extra_rate"
            case bfAdultExtraLimit = "bf_adult_extra_limit"
            case bfChildPrice = "bf_child_price"
            case bfChildLimit = "bf_child_limit"
            case bfChildExtraRate = "bf_child_extra_rate"
            case bfChildExtraLimit = "bf_child_extra_limit"
            case startAt = "start_at"
            case endAt = "end_at"
            case channels
            case pinned
        }
    }
    
    struct UpdatePriceCard: Encodable {
        let id: Int
        let title: String?
        let description: String?
        let reservableTypeId: Int?
        let reservableTypeType: String?
        let price: Double?
        let code: String?
        let color: String?
        let bfIncluded: Bool?
        let bfAdultPrice: Double?
        let bfAdultLimit: Int?
        let bfAdultExtraRate: Double?
        let bfAdultExtraLimit: Int?
        let bfChildPrice: Double?
        let bfChildLimit: Int?
        let bfChildExtraRate: Double?
        let bfChildExtraLimit: Int?
        let startAt: String?
        let endAt: String?
        let channels: [String]?
        let pinned: Bool?
        
        enum CodingKeys: String, CodingKey {
            case title
            case description
            case reservableTypeId = "reservable_type_id"
            case reservableTypeType = "reservable_type_type"
            case price
            case code
            case color
            case bfIncluded = "bf_included"
            case bfAdultPrice = "bf_adult_price"
            case bfAdultLimit = "bf_adult_limit"
            case bfAdultExtraRate = "bf_adult_extra_rate"
            case bfAdultExtraLimit = "bf_adult_extra_limit"
            case bfChildPrice = "bf_child_price"
            case bfChildLimit = "bf_child_limit"
            case bfChildExtraRate = "bf_child_extra_rate"
            case bfChildExtraLimit = "bf_child_extra_limit"
            case startAt = "start_at"
            case endAt = "end_at"
            case channels
            case pinned
            // id is not encoded as it's used in the URL path
        }
    }
    
    struct DeletePriceCard: Encodable {
        let id: Int
        
        // No CodingKeys needed as this is used for URL path only
    }
} 
