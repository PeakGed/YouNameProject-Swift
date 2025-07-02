//
//  AccountServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Foundation

struct AccountServiceRequest {
    // MARK: - Type Aliases for simple requests
    typealias FetchById = ByID
    typealias DeleteAccount = ByID
    typealias SetAsDefault = ByID
    
    struct ByID { let id: Int }
    
    // MARK: - Sorting Enums
    enum SortedBy: String {
        case id = "ID"
        case name = "NAME"
        case startBalance = "START_BALANCE"
        case openDate = "OPEN_DATE"
        case createdAt = "CREATED_AT"
        case updatedAt = "UPDATED_AT"
    }
    
    // MARK: - Fetch Accounts Request
    struct FetchAccounts: Encodable {
        let hotelId: Int
        let kind: String?
        let currency: String?
        let isDefault: Bool?
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case kind
            case currency
            case isDefault = "is_default"
            case page
            case perPage = "per_page"
            case sortedBy = "sorted_by"
            case sortedOrder = "sorted_order"
        }
        
        var parameters: [String: Any]? {
            var dict: [String: Any] = [:]
            dict["hotel_id"] = hotelId
            if let kind = kind { dict["kind"] = kind }
            if let currency = currency { dict["currency"] = currency }
            if let isDefault = isDefault { dict["is_default"] = isDefault }
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }
            return dict
        }
    }
    
    // MARK: - Fetch Account Balance Request
    struct FetchAccountBalance: Encodable {
        let id: Int
        let limitDatetime: String?
        
        var parameters: [String: Any]? {
            var dict: [String: Any] = [:]
            if let limitDatetime = limitDatetime { dict["limit_datetime"] = limitDatetime }
            return dict
        }
    }
    
    // MARK: - Create Account Request
    struct CreateAccount: Encodable {
        let name: String
        let startBalance: String
        let kind: String
        let currency: String
        let openDate: String
        let isDefault: Bool
        let colorRef: Int
        let iconRef: Int
        let hotelId: Int
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
            case name
            case startBalance = "start_balance"
            case kind
            case currency
            case openDate = "open_date"
            case isDefault = "is_default"
            case colorRef = "color_ref"
            case iconRef = "icon_ref"
            case hotelId = "hotel_id"
        }
    }
    
    // MARK: - Update Account Request
    struct UpdateAccount: Encodable {
        let id: Int
        let name: String?
        let startBalance: String?
        let kind: String?
        let currency: String?
        let openDate: String?
        let isDefault: Bool?
        let colorRef: Int?
        let iconRef: Int?
        
        var body: Data? {
            return try? JSONEncoder().encode(self)
        }
        
        enum CodingKeys: String, CodingKey {
            case name
            case startBalance = "start_balance"
            case kind
            case currency
            case openDate = "open_date"
            case isDefault = "is_default"
            case colorRef = "color_ref"
            case iconRef = "icon_ref"
            // id is not encoded as it's used in the URL path
        }
    }
} 