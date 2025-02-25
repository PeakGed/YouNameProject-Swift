//
//  AuthServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//
import Foundation

struct AuthServiceRequest {
    struct EmailLogin: Encodable {
        let username: String
        let password: String
        
        enum CodingKeys: String, CodingKey {
            case username
            case password
        }
        
        func asParameters() -> [String: Any] {
            return [
                "username": username,
                "password": password
            ]
        }
    }
    
    struct AppleIdLogin: Encodable {
        let code: String
        let firstName: String?
        let lastName: String?
        let email: String?

        enum CodingKeys: String, CodingKey {
            case code
            case firstName = "first_name"
            case lastName = "last_name"
            case email
        }
        
        func asParameters() -> [String: Any] {
            var params: [String: Any] = [
                "code": code
            ]
            
            if let firstName = firstName {
                params["first_name"] = firstName
            }
            
            if let lastName = lastName {
                params["last_name"] = lastName
            }
            
            if let email = email {
                params["email"] = email
            }
            
            return params
        }
    }
    
    struct TokenRefresh: Encodable {
        let token: String
        
        enum CodingKeys: String, CodingKey {
            case token = "refresh_token"
        }
        
        func asParameters() -> [String: Any] {
            return ["refresh_token": token]
        }
    }

    struct ResendEmailConfirmation: Encodable {
        let email: String
        
        func asParameters() -> [String: Any] {
            return ["email": email]
        }
    }

    struct PasswordReset: Encodable {
        let email: String
        
        func asParameters() -> [String: Any] {
            return ["email": email]
        }
    }
    
    struct Signup: Encodable {
        let email: String
        let password: String
        let firstName: String?
        let lastName: String?
        let phoneNumber: String?
        let pinCode: String?
        
        enum CodingKeys: String, CodingKey {
            case email
            case password
            case firstName = "first_name"
            case lastName = "last_name"
            case phoneNumber = "phone_number"
            case pinCode = "pin_code"
        }
        
        func asParameters() -> [String: Any] {
            var params: [String: Any] = [
                "email": email,
                "password": password
            ]
            
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
            
            return params
        }
    }
}
