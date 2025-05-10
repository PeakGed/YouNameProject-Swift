//
//  SupportVersion.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import Foundation

struct SupportVersion: Codable {
    
    let minAppVersion: String
    
    enum CodingKeys: String, CodingKey {
        case minAppVersion = "supported_minimum_api_version"
    }
    
}

/*
 {
     "supported_minimum_api_version": "2.7.19"
 }
 */
