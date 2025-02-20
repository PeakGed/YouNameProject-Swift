//
//  APIAuthErrorResponse.swift
//  YourProject
//
//  Created by IntrodexMini on 31/1/2568 BE.
//
import Foundation

struct APIAuthErrorResponse: Decodable, Error {
    enum ErrorCode: Error {
        case accessTokenExpired
        case invalidAccessToken
        case invalidRefreshToken
        case missingAccessToken
        case missingRefreshToken
        
        var rawValue: String {
            switch self {
            case .accessTokenExpired:
                return "access_token_expired"
            case .invalidAccessToken:
                return "invalid_access_token"
            case .invalidRefreshToken:
                return "invalid_refresh_token"
            case .missingAccessToken:
                return "missing_access_token"
            case .missingRefreshToken:
                return "missing_refresh_token"
            }
        }
        
        var errorResponse: APIAuthErrorResponse {
            .init(errorCode: self)
        }
        
        init(rawValue: String) throws {
            switch rawValue {
            case "access_token_expired":
                self = .accessTokenExpired
            case "invalid_access_token":
                self = .invalidAccessToken
            case "invalid_refresh_token":
                self = .invalidRefreshToken
            case "missing_access_token":
                self = .missingAccessToken
            case "missing_refresh_token":
                self = .missingRefreshToken
            default:
                let error = DecodingError.dataCorrupted(.init(codingPath: [],
                                                              debugDescription: "Unknown error code: \(rawValue)"))
                throw APIError.decodingError(error: error)
            }
        }
    }
    
    let errorCode: ErrorCode
    let errorMessage: String?
    
    private enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let errorCodeString = try container.decode(String.self, forKey: .errorCode)
        self.errorCode = try ErrorCode(rawValue: errorCodeString)
        self.errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
    }
    
    init(errorCode: ErrorCode) {
        self.errorCode = errorCode
        self.errorMessage = nil
    }
    
}
