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
        
        func asParameters() -> [String: Any] {
            var params: [String: Any] = [:]
            
            if let hotelId = hotelId {
                params["hotel_id"] = hotelId
            }
            if let startDate = startDate {
                params["start_date"] = startDate
            }
            if let endDate = endDate {
                params["end_date"] = endDate
            }
            if let channelId = channelId {
                params["channel_id"] = channelId
            }
            if let subChannelId = subChannelId {
                params["sub_channel_id"] = subChannelId
            }
            if let reservableTypeType = reservableTypeType {
                params["reservable_type_type"] = reservableTypeType
            }
            if let reservableTypeId = reservableTypeId {
                params["reservable_type_id"] = reservableTypeId
            }
            
            return params
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
        
        func asParameters() -> [String: Any] {
            var params: [String: Any] = [
                "hotel_id": hotelId,
                "title": title,
                "reservable_type_id": reservableTypeId,
                "reservable_type_type": reservableTypeType,
                "price": price,
                "start_at": startAt,
                "end_at": endAt
            ]
            
            if let description = description {
                params["description"] = description
            }
            if let code = code {
                params["code"] = code
            }
            if let color = color {
                params["color"] = color
            }
            if let bfIncluded = bfIncluded {
                params["bf_included"] = bfIncluded
            }
            if let bfAdultPrice = bfAdultPrice {
                params["bf_adult_price"] = bfAdultPrice
            }
            if let bfAdultLimit = bfAdultLimit {
                params["bf_adult_limit"] = bfAdultLimit
            }
            if let bfAdultExtraRate = bfAdultExtraRate {
                params["bf_adult_extra_rate"] = bfAdultExtraRate
            }
            if let bfAdultExtraLimit = bfAdultExtraLimit {
                params["bf_adult_extra_limit"] = bfAdultExtraLimit
            }
            if let bfChildPrice = bfChildPrice {
                params["bf_child_price"] = bfChildPrice
            }
            if let bfChildLimit = bfChildLimit {
                params["bf_child_limit"] = bfChildLimit
            }
            if let bfChildExtraRate = bfChildExtraRate {
                params["bf_child_extra_rate"] = bfChildExtraRate
            }
            if let bfChildExtraLimit = bfChildExtraLimit {
                params["bf_child_extra_limit"] = bfChildExtraLimit
            }
            if let channels = channels {
                params["channels"] = channels
            }
            if let pinned = pinned {
                params["pinned"] = pinned
            }
            
            return params
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
        
        func asParameters() -> [String: Any] {
            var params: [String: Any] = [:]
            
            if let title = title {
                params["title"] = title
            }
            if let description = description {
                params["description"] = description
            }
            if let reservableTypeId = reservableTypeId {
                params["reservable_type_id"] = reservableTypeId
            }
            if let reservableTypeType = reservableTypeType {
                params["reservable_type_type"] = reservableTypeType
            }
            if let price = price {
                params["price"] = price
            }
            if let code = code {
                params["code"] = code
            }
            if let color = color {
                params["color"] = color
            }
            if let bfIncluded = bfIncluded {
                params["bf_included"] = bfIncluded
            }
            if let bfAdultPrice = bfAdultPrice {
                params["bf_adult_price"] = bfAdultPrice
            }
            if let bfAdultLimit = bfAdultLimit {
                params["bf_adult_limit"] = bfAdultLimit
            }
            if let bfAdultExtraRate = bfAdultExtraRate {
                params["bf_adult_extra_rate"] = bfAdultExtraRate
            }
            if let bfAdultExtraLimit = bfAdultExtraLimit {
                params["bf_adult_extra_limit"] = bfAdultExtraLimit
            }
            if let bfChildPrice = bfChildPrice {
                params["bf_child_price"] = bfChildPrice
            }
            if let bfChildLimit = bfChildLimit {
                params["bf_child_limit"] = bfChildLimit
            }
            if let bfChildExtraRate = bfChildExtraRate {
                params["bf_child_extra_rate"] = bfChildExtraRate
            }
            if let bfChildExtraLimit = bfChildExtraLimit {
                params["bf_child_extra_limit"] = bfChildExtraLimit
            }
            if let startAt = startAt {
                params["start_at"] = startAt
            }
            if let endAt = endAt {
                params["end_at"] = endAt
            }
            if let channels = channels {
                params["channels"] = channels
            }
            if let pinned = pinned {
                params["pinned"] = pinned
            }
            
            return params
        }
    }
    
    struct DeletePriceCard: Encodable {
        let id: Int
        
        // No CodingKeys needed as this is used for URL path only
    }
} 
