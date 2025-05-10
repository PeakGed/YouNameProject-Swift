//
//  FolioServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation

struct FolioServiceRequest {
    struct FetchFolios: Encodable {
        let reservationId: Int
        
        enum CodingKeys: String, CodingKey {
            case reservationId = "reservation_id"
        }
    }
    
    struct FetchFolio: Encodable {
        let id: Int
        
        // id is not encoded as it's used in the URL path
        func encode(to encoder: Encoder) throws {
            // No properties to encode
        }
    }
    
    struct CreateFolio: Encodable {
        let reservationId: Int
        let amount: Double
        let description: String
        let type: String // charge/payment
        
        enum CodingKeys: String, CodingKey {
            case reservationId = "reservation_id"
            case amount
            case description
            case type
        }
    }
    
    struct UpdateFolio: Encodable {
        let id: Int
        let amount: Double?
        let description: String?
        let status: String?
        
        enum CodingKeys: String, CodingKey {
            case amount
            case description
            case status
            // id is not encoded as it's used in the URL path
        }
    }
    
    struct DeleteFolio: Encodable {
        let id: Int
        
        // id is not encoded as it's used in the URL path
        func encode(to encoder: Encoder) throws {
            // No properties to encode
        }
    }
    
    struct BatchCreateFolios: Encodable {
        let reservationId: Int
        let folios: [CreateFolio]
        
        enum CodingKeys: String, CodingKey {
            case reservationId = "reservation_id"
            case folios
        }
    }
} 