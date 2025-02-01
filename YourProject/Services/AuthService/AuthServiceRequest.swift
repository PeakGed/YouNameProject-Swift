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
    }
    
    struct AppleIdLogin: Encodable {
        let token: String
    }
    
    struct TokenRefresh: Encodable {
        let token: String
        
        enum CodingKeys: String, CodingKey {
            case token = "refresh_token"
        }
    }
}
