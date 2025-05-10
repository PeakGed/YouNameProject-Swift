//
//  ReservationServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation

struct ReservationServiceRequest {
    struct FetchReservations: Encodable {
        let hotelId: Int
        let status: String?
        let fromDate: String?
        let toDate: String?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case status
            case fromDate = "from_date"
            case toDate = "to_date"
        }
    }
    
    struct FetchReservation: Encodable {
        let id: Int
        
        // id is not encoded as it's used in the URL path
        func encode(to encoder: Encoder) throws {
            // No properties to encode
        }
    }
    
    struct CreateReservation: Encodable {
        let hotelId: Int
        let roomId: Int
        let guestName: String
        let checkIn: String
        let checkOut: String
        let adults: Int
        let children: Int
        let specialRequests: String?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case roomId = "room_id"
            case guestName = "guest_name"
            case checkIn = "check_in"
            case checkOut = "check_out"
            case adults
            case children
            case specialRequests = "special_requests"
        }
    }
    
    struct UpdateReservation: Encodable {
        let id: Int
        let roomId: Int?
        let guestName: String?
        let checkIn: String?
        let checkOut: String?
        let adults: Int?
        let children: Int?
        let status: String?
        let specialRequests: String?
        
        enum CodingKeys: String, CodingKey {
            case roomId = "room_id"
            case guestName = "guest_name"
            case checkIn = "check_in"
            case checkOut = "check_out"
            case adults
            case children
            case status
            case specialRequests = "special_requests"
            // id is not encoded as it's used in the URL path
        }
    }
    
    struct DeleteReservation: Encodable {
        let id: Int
        
        // id is not encoded as it's used in the URL path
        func encode(to encoder: Encoder) throws {
            // No properties to encode
        }
    }
    
    struct CheckIn: Encodable {
        let id: Int
        
        // id is not encoded as it's used in the URL path
        func encode(to encoder: Encoder) throws {
            // No properties to encode
        }
    }
    
    struct CheckOut: Encodable {
        let id: Int
        
        // id is not encoded as it's used in the URL path
        func encode(to encoder: Encoder) throws {
            // No properties to encode
        }
    }
} 