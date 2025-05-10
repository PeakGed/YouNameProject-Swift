//
//  ChannelServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation

struct ChannelServiceRequest {
    
    // MARK: - Enums
    enum SortedBy: String, Codable {
        case id = "ID"
        case name = "NAME"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }
    
    struct FetchChannel: Encodable {
        let id: Int
        
        // id is not encoded as it's used in the URL path
        func encode(to encoder: Encoder) throws {
            // No properties to encode
        }
    }
    
    struct CreateChannel: Encodable {
        let name: String
        let feeRate: Float
        
        enum CodingKeys: String, CodingKey {
            case name
            case feeRate = "fee_rate"
        }
    }
    
    struct UpdateChannel: Encodable {
        let id: Int
        let name: String
        let feeRate: Float
        
        enum CodingKeys: String, CodingKey {
            case name
            case feeRate = "fee_rate"
            // id is not encoded as it's used in the URL path
        }
    }
    
    struct DeleteChannel: Encodable {
        let id: Int
        
        // id is not encoded as it's used in the URL path
        func encode(to encoder: Encoder) throws {
            // No properties to encode
        }
    }
    
    struct CreateSubChannel: Encodable {
        let channelId: Int
        let name: String
        let feeRate: Float
        
        enum CodingKeys: String, CodingKey {
            case name
            case feeRate = "fee_rate"
            // channelId is not encoded as it's used in the URL path
        }
    }
}
