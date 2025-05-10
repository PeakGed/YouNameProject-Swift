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
        let perPage: PerPage?
        let sortedBy: SortedBy?
        let sortedOrder: ServiceSortedOrder?
        
        var parameters: [String: Any]? {
            var params: [String: Any] = [:]
            params["hotel_id"] = hotelId
            if let page = page { params["page"] = page }
            if let perPage = perPage { params["per_page"] = perPage.rawValue }
            if let sortedBy = sortedBy { params["sorted_by"] = sortedBy.rawValue }
            if let sortedOrder = sortedOrder { params["sorted_order"] = sortedOrder.rawValue }
            return params
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
    }
    
    struct FetchFolio {
        let id: Int
    }
    
    struct CreateFolio: Encodable {
        let hotelId: Int
        let name: String
        let amount: Double
        let description: String?
        let categoryId: Int?
        let amountVatOption: VatOption
        
        func encode(to encoder: any Encoder) throws {
            var container: KeyedEncodingContainer<FolioServiceRequest.CreateFolio.CodingKeys> = encoder.container(keyedBy: FolioServiceRequest.CreateFolio.CodingKeys.self)
            try container.encode(self.hotelId, forKey: .hotelId)
            try container.encode(self.name, forKey: .name)
            try container.encode(self.amount.toString(), forKey: .amount)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.categoryId, forKey: .categoryId)
            try container.encode(self.amountVatOption.rawValue, forKey: .amountVatOption)
        }
        
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
        
        func encode(to encoder: any Encoder) throws {
            var container: KeyedEncodingContainer<FolioServiceRequest.CreateFolio.CodingKeys> = encoder.container(keyedBy: FolioServiceRequest.CreateFolio.CodingKeys.self)
            try container.encode(self.name, forKey: .name)
            try container.encodeIfPresent(self.amount?.toString(), forKey: .amount)
            try container.encodeIfPresent(self.description, forKey: .description)
            try container.encodeIfPresent(self.categoryId, forKey: .categoryId)
            try container.encodeIfPresent(self.amountVatOption?.rawValue, forKey: .amountVatOption)
        }
        
        enum CodingKeys: String, CodingKey {
            case name
            case amount
            case description
            case categoryId = "category_id"
            case amountVatOption = "amount_vat_option"
            // id is not encoded as it's used in the URL path
        }
    }
    
    struct DeleteFolio {
        let id: Int
    }
   
} 
