//
//  UserServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 28/2/2568 BE.
//
import Foundation


struct UserServiceRequest {
    struct FetchUsers: Encodable {
        // Query parameters can be added here if needed
    }
    
    struct FetchUser: Encodable {
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
    
    struct CreateUser: Encodable {
        let name: String
        let email: String
        let password: String
        let role: String?
        let phoneNumber: String?
        let address: String?
        let profileImage: String?
        
        enum CodingKeys: String, CodingKey {
            case name
            case email
            case password
            case role
            case phoneNumber = "phone_number"
            case address
            case profileImage = "profile_image"
        }
        
        func asParameters() -> [String: Any] {
            var params: [String: Any] = [
                "name": name,
                "email": email,
                "password": password
            ]
            
            if let role = role {
                params["role"] = role
            }
            if let phoneNumber = phoneNumber {
                params["phone_number"] = phoneNumber
            }
            if let address = address {
                params["address"] = address
            }
            if let profileImage = profileImage {
                params["profile_image"] = profileImage
            }
            
            return params
        }
    }
    
    struct UpdateUser: Encodable {
        let id: Int
        let name: String?
        let email: String?
        let password: String?
        let role: String?
        let phoneNumber: String?
        let address: String?
        let profileImage: String?
        
        enum CodingKeys: String, CodingKey {
            case name
            case email
            case password
            case role
            case phoneNumber = "phone_number"
            case address
            case profileImage = "profile_image"
            // id is not encoded as it's used in the URL path
        }
        
        func asParameters() -> [String: Any] {
            var params: [String: Any] = [:]
            
            if let name = name {
                params["name"] = name
            }
            if let email = email {
                params["email"] = email
            }
            if let password = password {
                params["password"] = password
            }
            if let role = role {
                params["role"] = role
            }
            if let phoneNumber = phoneNumber {
                params["phone_number"] = phoneNumber
            }
            if let address = address {
                params["address"] = address
            }
            if let profileImage = profileImage {
                params["profile_image"] = profileImage
            }
            
            return params
        }
    }
    
    struct DeleteUser: Encodable {
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
    
    struct ChangeEmail: Encodable {
        let currentPassword: String
        let newEmail: String
        let newEmailConfirmation: String
        
        enum CodingKeys: String, CodingKey {
            case currentPassword = "current_password"
            case newEmail = "new_email"
            case newEmailConfirmation = "new_email_confirmation"
        }
        
        func asParameters() -> [String: Any] {
            return [
                "current_password": currentPassword,
                "new_email": newEmail,
                "new_email_confirmation": newEmailConfirmation
            ]
        }
    }
    
    struct FetchNotificationSettings: Encodable {
        // No parameters needed for this GET request
    }
    
    struct FetchUserDevices: Encodable {
        // No parameters needed for this GET request
    }
    
    struct ResendEmailLoginCode: Encodable {
        let code: String
        
        func asParameters() -> [String: Any] {
            return ["code": code]
        }
    }
    
    struct EmailLoginLink: Encodable {
        let code: String
        let password: String
        let confirmPassword: String
        
        enum CodingKeys: String, CodingKey {
            case code
            case password
            case confirmPassword = "confirm_password"
        }
        
        func asParameters() -> [String: Any] {
            return [
                "code": code,
                "password": password,
                "confirm_password": confirmPassword
            ]
        }
    }
    
    struct SendEmailLoginCode: Encodable {
        let email: String
        
        func asParameters() -> [String: Any] {
            return ["email": email]
        }
    }
    
    struct AppleLoginLink: Encodable {
        let code: String
        
        func asParameters() -> [String: Any] {
            return ["code": code]
        }
    }
    
    struct FetchUserCompanies: Encodable {
        let userId: Int
        
        enum CodingKeys: String, CodingKey {
            // This is a placeholder case to make the enum valid
            case placeholder
            // userId is not encoded as it's used in the URL path
        }
        
        func encode(to encoder: Encoder) throws {
            // Nothing to encode as userId is used in the URL path
        }
    }
    
    struct ChangePassword: Encodable {
        let userId: Int
        let currentPassword: String
        let newPassword: String
        let newPasswordConfirmation: String
        
        enum CodingKeys: String, CodingKey {
            case currentPassword = "current_password"
            case newPassword = "new_password"
            case newPasswordConfirmation = "new_password_confirmation"
            // userId is not encoded as it's used in the URL path
        }
        
        func asParameters() -> [String: Any] {
            return [
                "current_password": currentPassword,
                "new_password": newPassword,
                "new_password_confirmation": newPasswordConfirmation
            ]
        }
    }
    
    struct UpdateUserProfile: Encodable {
        let userId: Int
        let firstName: String?
        let lastName: String?
        let phoneNumber: String?
        let pinCode: String?
        let idCard: String?
        let lineAccessToken: String?
        let notificationLanguage: String?
        
        enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case lastName = "last_name"
            case phoneNumber = "phone_number"
            case pinCode = "pin_code"
            case idCard = "id_card"
            case lineAccessToken = "line_access_token"
            case notificationLanguage = "notification_language"
            // userId is not encoded as it's used in the URL path
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
            if let lineAccessToken = lineAccessToken {
                params["line_access_token"] = lineAccessToken
            }
            if let notificationLanguage = notificationLanguage {
                params["notification_language"] = notificationLanguage
            }
            
            return params
        }
    }
    
    struct FetchUserDetail: Encodable {
        let userId: Int
        
        enum CodingKeys: String, CodingKey {
            // This is a placeholder case to make the enum valid
            case placeholder
            // userId is not encoded as it's used in the URL path
        }
        
        func encode(to encoder: Encoder) throws {
            // Nothing to encode as userId is used in the URL path
        }
    }
} 