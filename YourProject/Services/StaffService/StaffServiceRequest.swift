//
//  StaffServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//
import Foundation


struct StaffServiceRequest {
    struct FetchStaffs: Encodable {
        // Query parameters can be added here if needed
    }
    
    struct FetchStaff: Encodable {
        let id: Int
        
        enum CodingKeys: String, CodingKey {
            // This is a placeholder case to make the enum valid
            case placeholder
            // id is not encoded as it's used in the URL path
        }
        
        func encode(to encoder: Encoder) throws {
            // Nothing to encode as id is used in the URL path
        }
    }
    
    struct CreateStaff: Encodable {
        let hotelId: Int
        let name: String
        let baseRate: Float
        let baseGuestNumber: Int
        let extraBedRate: Float?
        let extraGuestRate: Float?
        let maxExtraBedNumber: Int?
        let maxExtraGuestNumber: Int?
        let limitedNumberOfCmUnits: Int?
        let description: String?
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case name
            case baseRate = "base_rate"
            case baseGuestNumber = "base_guest_number"
            case extraBedRate = "extra_bed_rate"
            case extraGuestRate = "extra_guest_rate"
            case maxExtraBedNumber = "max_extra_bed_number"
            case maxExtraGuestNumber = "max_extra_guest_number"
            case limitedNumberOfCmUnits = "limited_number_of_cm_units"
            case description
        }
        
        func asParameters() -> [String: Any] {
            var params: [String: Any] = [
                "hotel_id": hotelId,
                "name": name,
                "base_rate": baseRate,
                "base_guest_number": baseGuestNumber
            ]
            
            if let extraBedRate = extraBedRate {
                params["extra_bed_rate"] = extraBedRate
            }
            if let extraGuestRate = extraGuestRate {
                params["extra_guest_rate"] = extraGuestRate
            }
            if let maxExtraBedNumber = maxExtraBedNumber {
                params["max_extra_bed_number"] = maxExtraBedNumber
            }
            if let maxExtraGuestNumber = maxExtraGuestNumber {
                params["max_extra_guest_number"] = maxExtraGuestNumber
            }
            if let limitedNumberOfCmUnits = limitedNumberOfCmUnits {
                params["limited_number_of_cm_units"] = limitedNumberOfCmUnits
            }
            if let description = description {
                params["description"] = description
            }
            
            return params
        }
    }
    
    struct UpdateStaff: Encodable {
        let id: Int
        let name: String?
        let baseRate: Float?
        let baseGuestNumber: Int?
        let extraBedRate: Float?
        let extraGuestRate: Float?
        let maxExtraBedNumber: Int?
        let maxExtraGuestNumber: Int?
        let limitedNumberOfCmUnits: Int?
        let description: String?
        
        enum CodingKeys: String, CodingKey {
            case name
            case baseRate = "base_rate"
            case baseGuestNumber = "base_guest_number"
            case extraBedRate = "extra_bed_rate"
            case extraGuestRate = "extra_guest_rate"
            case maxExtraBedNumber = "max_extra_bed_number"
            case maxExtraGuestNumber = "max_extra_guest_number"
            case limitedNumberOfCmUnits = "limited_number_of_cm_units"
            case description
            // id is not encoded as it's used in the URL path
        }
        
        func asParameters() -> [String: Any] {
            var params: [String: Any] = [:]
            
            if let name = name {
                params["name"] = name
            }
            if let baseRate = baseRate {
                params["base_rate"] = baseRate
            }
            if let baseGuestNumber = baseGuestNumber {
                params["base_guest_number"] = baseGuestNumber
            }
            if let extraBedRate = extraBedRate {
                params["extra_bed_rate"] = extraBedRate
            }
            if let extraGuestRate = extraGuestRate {
                params["extra_guest_rate"] = extraGuestRate
            }
            if let maxExtraBedNumber = maxExtraBedNumber {
                params["max_extra_bed_number"] = maxExtraBedNumber
            }
            if let maxExtraGuestNumber = maxExtraGuestNumber {
                params["max_extra_guest_number"] = maxExtraGuestNumber
            }
            if let limitedNumberOfCmUnits = limitedNumberOfCmUnits {
                params["limited_number_of_cm_units"] = limitedNumberOfCmUnits
            }
            if let description = description {
                params["description"] = description
            }
            
            return params
        }
    }
    
    struct DeleteStaff: Encodable {
        let id: Int
        
        enum CodingKeys: String, CodingKey {
            // This is a placeholder case to make the enum valid
            case placeholder
            // id is not encoded as it's used in the URL path
        }
        
        func encode(to encoder: Encoder) throws {
            // Nothing to encode as id is used in the URL path
        }
    }
    
    // New request structures for the additional endpoints
    
    struct ChangeHotel: Encodable {
        let id: Int
        let hotelId: Int
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            // id is not encoded as it's used in the URL path
        }
        
        func asParameters() -> [String: Any] {
            return ["hotel_id": hotelId]
        }
    }
    
    struct ChangePassword: Encodable {
        let id: Int
        let password: String
        
        enum CodingKeys: String, CodingKey {
            case password
            // id is not encoded as it's used in the URL path
        }
        
        func asParameters() -> [String: Any] {
            return ["password": password]
        }
    }
    
    struct UpdateStaffDetails: Encodable {
        let id: Int
        let firstName: String?
        let lastName: String?
        let phoneNumber: String?
        let pinCode: String?
        let idCard: String?
        
        enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case lastName = "last_name"
            case phoneNumber = "phone_number"
            case pinCode = "pin_code"
            case idCard = "id_card"
            // id is not encoded as it's used in the URL path
        }
        
        func asParameters() -> [String: Any] {
            var params: [String: Any] = [:]
            
            if let firstName = firstName {
                params["first_name"] = firstName
            }
            if let lastName = lastName {
                params["last_name"] = lastName
            }
            if let phoneNumber = phoneNumber {
                params["phone_number"] = phoneNumber
            }
            if let pinCode = pinCode {
                params["pin_code"] = pinCode
            }
            if let idCard = idCard {
                params["id_card"] = idCard
            }
            
            return params
        }
    }
} 