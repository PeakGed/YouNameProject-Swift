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

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(username, forKey: .username)
            try container.encode(password, forKey: .password)
        }

         var body: Data? {
                try? JSONEncoder().encode(self)
            }
    }

    struct AppleIdLogin: Encodable {
        let token: String
    }
}
