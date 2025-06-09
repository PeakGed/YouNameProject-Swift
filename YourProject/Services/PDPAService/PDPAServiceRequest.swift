//
//  PDPAServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//
import Foundation

struct PDPAServiceRequest {
    
    typealias FetchPdpa = ByID
    
    struct ByID {
        let id: Int
    }
    
    struct FetchPdpas: Encodable {
        let version: Version?
        
        var parameters: [String: Any]? {
            var parameters: [String: Any] = [:]
            
            if let version = version?.raw {
                parameters["version"] = version
            }
            
            // if parameters is empty, return nil
            if parameters.isEmpty {
                return nil
            }
            
            return parameters
        }
        enum CodingKeys: String, CodingKey {
            case version = "version"
        }
        
        //encode
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            if let raw = version?.raw as? String {
                try container.encode(raw, forKey: .version)
            }
        }
        
    }
}
