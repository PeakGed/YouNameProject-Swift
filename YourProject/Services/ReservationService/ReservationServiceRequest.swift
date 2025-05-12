//
//  ReservationServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation

struct ReservationServiceRequest {
    struct FetchReservations: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        let status: String?
        
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            if let status = status { dict["status"] = status }
            return dict
        }
    }
    struct FetchReservationsByFlags: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let flags: String?
        let hotelId: Int?
        
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }
            if let flags = flags { dict["flags"] = flags }
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            return dict
        }
    }
    struct FetchReservationsByGuest: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        let guestId: Int?
        
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            if let guestId = guestId { dict["guest_id"] = guestId }
            return dict
        }
    }
    struct FetchReservationsByCompany: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        let companyId: Int?
        
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            if let companyId = companyId { dict["company_id"] = companyId }
            return dict
        }
    }
    struct FetchReservationsByPeriod: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        let startAt: String?
        let endAt: String?
        let status: String?
        
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            if let startAt = startAt { dict["start_at"] = startAt }
            if let endAt = endAt { dict["end_at"] = endAt }
            if let status = status { dict["status"] = status }
            return dict
        }
    }
    struct FetchReservationsByCreatedAt: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        let startAt: String?
        let endAt: String?
        
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            if let startAt = startAt { dict["start_at"] = startAt }
            if let endAt = endAt { dict["end_at"] = endAt }
            return dict
        }
    }
    struct FetchReservationsByTags: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let tags: String?
        let hotelId: Int?
        
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }
            if let tags = tags { dict["tags"] = tags }
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            return dict
        }
    }
    struct FetchReservationsByKeyword: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        let keyword: String?
        
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            if let keyword = keyword { dict["keyword"] = keyword }
            return dict
        }
    }
    struct FetchReservationsByBatchIds: Encodable {
        let ids: String?
        let hotelId: Int?
        
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let ids = ids { dict["ids"] = ids }
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            return dict
        }
    }
    struct FetchReservationByUid: Encodable {
        let uid: String
        let hotelId: Int
        
        func toDictionary() -> [String: Any] {
            return ["uid": uid, "hotel_id": hotelId]
        }
    }
    struct FetchReservation: Encodable {
        let id: Int
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