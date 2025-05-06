//
//  RoomServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation

struct RoomServiceRequest {
    struct FetchRooms: Encodable {
        
    }
    
    struct FetchRoomDetail: Encodable {
        let id: Int
        
        // id is not encoded as it's used in the URL path
        // Empty implementation since we don't need to encode anything
        func encode(to encoder: Encoder) throws {
            // No properties to encode
        }
    }
    
    struct CreateRoom: Encodable {
        let code: String
        let roomTypeId: Int
        let hotelId: Int
        
        enum CodingKeys: String, CodingKey {
            case code
            case roomTypeId = "room_type_id"
            case hotelId = "hotel_id"
        }
    }
    
    struct UpdateRoom: Encodable {
        let id: Int
        let code: String?
        let status: Room.Status?
        let needCleaning: Bool?
        let roomTypeId: Int?
        
        enum CodingKeys: String, CodingKey {
            case code
            case status
            case needCleaning = "need_cleaning"
            case roomTypeId = "room_type_id"
            // id is not encoded as it's used in the URL path
        }

    }
    
    struct DeleteRoom: Encodable {
        let id: Int
        
        // id is not encoded as it's used in the URL path
        // Empty implementation since we don't need to encode anything
        func encode(to encoder: Encoder) throws {
            // No properties to encode
        }
    }
    
    struct ChangeRoomType: Encodable {
        let id: Int
        let roomTypeId: Int
        
        enum CodingKeys: String, CodingKey {
            case roomTypeId = "room_type_id"
            // id is not encoded as it's used in the URL path
        }

    }
    
    struct BatchCreateRooms: Encodable {
        let hotelId: Int
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
        }
    }
    
    struct BatchDeleteRooms: Encodable {
        // Empty implementation since we don't need to encode anything
        func encode(to encoder: Encoder) throws {
            // No properties to encode
        }
    }
} 
