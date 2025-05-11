//
//  StaffServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//
import Foundation


struct GuestServiceRequest {
    struct FetchGuests: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        let includeHidden: Bool?
        
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            if let includeHidden = includeHidden { dict["include_hidden"] = includeHidden }
            return dict
        }
    }
    struct FetchGuestsQuery: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        let q: String?
        let includeHidden: Bool?
        
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            if let q = q { dict["q"] = q }
            if let includeHidden = includeHidden { dict["include_hidden"] = includeHidden }
            return dict
        }
    }
    struct FetchGuestsCompany: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        let companyId: Int?
        let includeHidden: Bool?
        
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            if let companyId = companyId { dict["company_id"] = companyId }
            if let includeHidden = includeHidden { dict["include_hidden"] = includeHidden }
            return dict
        }
    }
    struct FetchGuestsReservation: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        let reservationId: Int?
        let includeHidden: Bool?
        
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            if let reservationId = reservationId { dict["reservation_id"] = reservationId }
            if let includeHidden = includeHidden { dict["include_hidden"] = includeHidden }
            return dict
        }
    }
    struct FetchGuestsDatetimeOffset: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        let datetimeOffset: String?
        let includeHidden: Bool?
        
        func toDictionary() -> [String: Any] {
            var dict: [String: Any] = [:]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { dict["hotel_id"] = hotelId }
            if let datetimeOffset = datetimeOffset { dict["datetime_offset"] = datetimeOffset }
            if let includeHidden = includeHidden { dict["include_hidden"] = includeHidden }
            return dict
        }
    }
    struct CreateGuest: Encodable {
        let firstName: String
        let lastName: String
        let nationality: String
        let country: String
        let reservationId: Int?
        let companyId: Int?
        let hotelId: Int
        let title: String?
        let middleName: String?
        let dateOfBirth: String?
        let idCardNo: String?
        let passportNo: String?
        let gender: String?
        let email: String?
        let occupation: String?
        let phone: String?
        let address: String?
        let district: String?
        let province: String?
        let zipCode: String?
        let note: String?
        let nickname: String?
        let photos: [String]?
        let documentPhotos: [String]?
        
        enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case lastName = "last_name"
            case nationality
            case country
            case reservationId = "reservation_id"
            case companyId = "company_id"
            case hotelId = "hotel_id"
            case title
            case middleName = "middle_name"
            case dateOfBirth = "date_of_birth"
            case idCardNo = "id_card_no"
            case passportNo = "passport_no"
            case gender
            case email
            case occupation
            case phone
            case address
            case district
            case province
            case zipCode = "zip_code"
            case note
            case nickname
            case photos
            case documentPhotos = "document_photos"
        }
    }
    struct UpdateGuest: Encodable {
        let id: Int
        let companyId: Int?
        let title: String?
        let firstName: String?
        let middleName: String?
        let lastName: String?
        let nationality: String?
        let country: String?
        let dateOfBirth: String?
        let idCardNo: String?
        let passportNo: String?
        let gender: String?
        let email: String?
        let occupation: String?
        let phone: String?
        let address: String?
        let district: String?
        let province: String?
        let zipCode: String?
        let note: String?
        let nickname: String?
        let photos: [String]?
        let documentPhotos: [String]?
        
        enum CodingKeys: String, CodingKey {
            case companyId = "company_id"
            case title
            case firstName = "first_name"
            case middleName = "middle_name"
            case lastName = "last_name"
            case nationality
            case country
            case dateOfBirth = "date_of_birth"
            case idCardNo = "id_card_no"
            case passportNo = "passport_no"
            case gender
            case email
            case occupation
            case phone
            case address
            case district
            case province
            case zipCode = "zip_code"
            case note
            case nickname
            case photos
            case documentPhotos = "document_photos"
        }
    }
    
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
    
    struct FetchGuest {
        let id: Int
    }
    
    struct DeleteGuest {
        let id: Int
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
