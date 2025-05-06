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
    }
    
    struct ChangePassword: Encodable {
        let id: Int
        let password: String
        
        enum CodingKeys: String, CodingKey {
            case password
            // id is not encoded as it's used in the URL path
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
    }
} 