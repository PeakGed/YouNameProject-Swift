//
//  FolioServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation

struct FolioServiceRequest {
    
    enum SortedBy: String, Codable {
        case id = "ID"
        case name = "NAME"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }
    
    enum VatOption: String, Codable {
        case excludedVat = "excluded_vat"
        case includedVat = "included_vat"
        case zeroVat = "zero_vat"
        case noVat = "no_vat"
    }
    
    struct FetchFolios: Encodable {
        let hotelId: Int
        let page: Int?
        let perPage: Int?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
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
        let hotelId: Int
        let name: String
        let amount: Double
        let description: String?
        let categoryId: Int?
        let amountVatOption: VatOption
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case name
            case amount
            case description
            case categoryId = "category_id"
            case amountVatOption = "amount_vat_option"
        }
    }
    
    struct UpdateFolio: Encodable {
        let id: Int
        let name: String?
        let amount: Double?
        let description: String?
        let categoryId: Int?
        let amountVatOption: VatOption?
        
        enum CodingKeys: String, CodingKey {
            case name
            case amount
            case description
            case categoryId = "category_id"
            case amountVatOption = "amount_vat_option"
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
   
} 
