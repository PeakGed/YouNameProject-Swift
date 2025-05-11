//
//  MeServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation

struct MeServiceRequest {
    
    struct UpdateProfile: Encodable {
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
    }

    struct ChangePassword: Encodable {
        let currentPassword: String
        let newPassword: String
        let newPasswordConfirmation: String

        enum CodingKeys: String, CodingKey {
            case currentPassword = "current_password"
            case newPassword = "new_password"
            case newPasswordConfirmation = "new_password_confirmation"
        }
    }

    struct Verification: Encodable {        
        let pinCode: String

        enum CodingKeys: String, CodingKey {
            case pinCode = "pin_code"
        }
    }
} 
