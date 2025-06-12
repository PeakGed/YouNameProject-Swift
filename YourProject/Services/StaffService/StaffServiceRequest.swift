//
//  StaffServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//
import Foundation

struct StaffServiceRequest {
    
    typealias FetchStaff = ById
    typealias DeleteStaff = ById
    
    struct ById {
        let id: Int
    }
    
    // MARK: - Fetch Staffs with hotel_id parameter
    struct FetchStaffs: Encodable {
        let hotelId: Int
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
        }
        
        var parameters: [String: Any]? {
            var params: [String: Any] = [:]
            params["hotel_id"] = hotelId
            return params
        }
    }
    
    // MARK: - Create Staff
    struct CreateStaff: Encodable {
        let hotelId: Int
        let password: String
        //let email: String
        let username: String // not use for now
        let role: Staff.Role
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case password
            //case email
            case username
            case role
        }
        
        //encode
        func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(password, forKey: .password)
            //try container.encode(email, forKey: .email)
            try container.encode(username, forKey: .username) // not use for now
            try container.encode(role.rawValue, forKey: .role)
        }
    }
    
    // MARK: - Update Staff Details
    struct UpdateStaff: Encodable {
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
    
    // MARK: - Change Hotel
    struct ChangeHotel: Encodable {
        let id: Int
        let hotelId: Int
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            // id is not encoded as it's used in the URL path
        }
    }
    
    // MARK: - Change Password
    struct ChangePassword: Encodable {
        let id: Int
        let password: String
        
        enum CodingKeys: String, CodingKey {
            case password
            // id is not encoded as it's used in the URL path
        }
    }
    
    // MARK: - Update Status
    struct UpdateStatus: Encodable {
        let id: Int
        let status: Staff.Status
        
        enum CodingKeys: String, CodingKey {
            case status
            // id is not encoded as it's used in the URL path
        }
        
        //encode
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(status.rawValue, forKey: .status)
        }
    }
    
    // MARK: - Verify PIN
    struct VerifyPin: Encodable {
        let id: Int
        let pinCode: String
        
        enum CodingKeys: String, CodingKey {
            case pinCode = "pin_code"
            // id is not encoded as it's used in the URL path
        }
    }
} 
