//
//  APIErrorResponse.swift
//  YourProject
//
//  Created by IntrodexMini on 31/1/2568 BE.
//
import Foundation

struct APIErrorResponse: Decodable, Error {

    let errorCode: Int
    let errorMessage: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.errorCode = try container.decode(Int.self, forKey: .errorCode)
        self.errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
    }

//    func isAuthenticatedErrorCode() -> Bool {
//        switch self.errorCode {
//        case "access_token_expired",
//             "invalid_access_token",
//             "invalid_refresh_token",
//             "missing_access_token":
//            return true
//        default:
//            return false
//        }
//    }

     private enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
}
