//
//  HotelServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation

struct HotelServiceRequest {
    struct FetchHotels: Encodable {
        
    }
    
    struct CreateHotel: Encodable {
        let name: String
        let information: String?
        let address: String?
        let phone: String?
        let geolocation: String?
        let email: String?
        let website: String?
        let workingTime: String?
        let checkInTime: String?
        let checkOutTime: String?
        let note: String?
        let taxNumber: String?
        let policies: String?
        let quote: String?
        let termAndCondition: String?
        let latitude: Double?
        let longitude: Double?
        let otaRateCodes: RateCodeList?
        
        enum CodingKeys: String, CodingKey {
            case name
            case information
            case address
            case phone
            case geolocation
            case email
            case website
            case workingTime = "working_time"
            case checkInTime = "check_in_time"
            case checkOutTime = "check_out_time"
            case note
            case taxNumber = "tax_number"
            case policies
            case quote
            case termAndCondition = "term_and_condition"
            case latitude
            case longitude
            case otaRateCodes = "ota_rate_codes"
        }
        
        func asParameters() -> [String: Any] {
            var params: [String: Any] = [
                "name": name
            ]
            
            if let information = information {
                params["information"] = information
            }
            if let address = address {
                params["address"] = address
            }
            if let phone = phone {
                params["phone"] = phone
            }
            if let geolocation = geolocation {
                params["geolocation"] = geolocation
            }
            if let email = email {
                params["email"] = email
            }
            if let website = website {
                params["website"] = website
            }
            if let workingTime = workingTime {
                params["working_time"] = workingTime
            }
            if let checkInTime = checkInTime {
                params["check_in_time"] = checkInTime
            }
            if let checkOutTime = checkOutTime {
                params["check_out_time"] = checkOutTime
            }
            if let note = note {
                params["note"] = note
            }
            if let taxNumber = taxNumber {
                params["tax_number"] = taxNumber
            }
            if let policies = policies {
                params["policies"] = policies
            }
            if let quote = quote {
                params["quote"] = quote
            }
            if let termAndCondition = termAndCondition {
                params["term_and_condition"] = termAndCondition
            }
            if let latitude = latitude {
                params["latitude"] = latitude
            }
            if let longitude = longitude {
                params["longitude"] = longitude
            }
            if let otaRateCodes = otaRateCodes {
                params["ota_rate_codes"] = otaRateCodes
            }
            
            return params
        }
    }
    
    struct UpdateHotel: Encodable {
        let hotelId: Int
        let name: String?
        let information: String?
        let address: String?
        let phone: String?
        let geolocation: String?
        let email: String?
        let website: String?
        let workingTime: String?
        let checkInTime: String?
        let checkOutTime: String?
        let note: String?
        let taxNumber: String?
        let policies: String?
        let quote: String?
        let termAndCondition: String?
        let latitude: Double?
        let longitude: Double?
        let otaRateCodes: RateCodeList?
        
        enum CodingKeys: String, CodingKey {
            case name
            case information
            case address
            case phone
            case geolocation
            case email
            case website
            case workingTime = "working_time"
            case checkInTime = "check_in_time"
            case checkOutTime = "check_out_time"
            case note
            case taxNumber = "tax_number"
            case policies
            case quote
            case termAndCondition = "term_and_condition"
            case latitude
            case longitude
            case otaRateCodes = "ota_rate_codes"
            // hotelId is not encoded as it's used in the URL path
        }
        
        func asParameters() -> [String: Any] {
            var params: [String: Any] = [:]
            
            if let name = name {
                params["name"] = name
            }
            
            if let information = information {
                params["information"] = information
            }
            if let address = address {
                params["address"] = address
            }
            if let phone = phone {
                params["phone"] = phone
            }
            if let geolocation = geolocation {
                params["geolocation"] = geolocation
            }
            if let email = email {
                params["email"] = email
            }
            if let website = website {
                params["website"] = website
            }
            if let workingTime = workingTime {
                params["working_time"] = workingTime
            }
            if let checkInTime = checkInTime {
                params["check_in_time"] = checkInTime
            }
            if let checkOutTime = checkOutTime {
                params["check_out_time"] = checkOutTime
            }
            if let note = note {
                params["note"] = note
            }
            if let taxNumber = taxNumber {
                params["tax_number"] = taxNumber
            }
            if let policies = policies {
                params["policies"] = policies
            }
            if let quote = quote {
                params["quote"] = quote
            }
            if let termAndCondition = termAndCondition {
                params["term_and_condition"] = termAndCondition
            }
            if let latitude = latitude {
                params["latitude"] = latitude
            }
            if let longitude = longitude {
                params["longitude"] = longitude
            }
            if let otaRateCodes = otaRateCodes {
                params["ota_rate_codes"] = otaRateCodes
            }
            
            return params
        }
    }
} 
