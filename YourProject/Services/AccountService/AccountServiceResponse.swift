//
//  AccountServiceResponse.swift
//  YourProject
//
//  Created by IntrodexMini on 11/5/2568 BE.
//

import Foundation

struct AccountServiceResponse {
    
    struct BalanceInfo: Codable {
        let balance: String
        let limitDatetime: String?
        
        enum CodingKeys: String, CodingKey {
            case balance
            case limitDatetime = "limit_datetime"
        }
    }
} 