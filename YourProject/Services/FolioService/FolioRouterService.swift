//
//  FolioRouterService.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//

import Alamofire
import Foundation

enum FolioRouterService: AlamofireBaseRouterProtocol {
    
    case fetchFolios(request: FolioServiceRequest.FetchFolios)
    case fetchFolio(request: FolioServiceRequest.FetchFolio)
    case createFolio(request: FolioServiceRequest.CreateFolio)
    case updateFolio(request: FolioServiceRequest.UpdateFolio)
    case deleteFolio(request: FolioServiceRequest.DeleteFolio)
    case batchCreateFolios(request: FolioServiceRequest.BatchCreateFolios)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchFolios(_):
            return "/api/v4/folios"
        case .fetchFolio(let request):
            return "/api/v4/folios/\(request.id)"
        case .createFolio(_):
            return "/api/v4/folios"
        case .updateFolio(let request):
            return "/api/v4/folios/\(request.id)"
        case .deleteFolio(let request):
            return "/api/v4/folios/\(request.id)"
        case .batchCreateFolios(_):
            return "/api/v4/folios/batch_create"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchFolios(_), .fetchFolio(_):
            return .get
        case .createFolio(_), .batchCreateFolios(_):
            return .post
        case .updateFolio(_):
            return .put
        case .deleteFolio(_):
            return .delete
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var body: Data? {
        switch self {
        case .createFolio(let request):
            return try? JSONEncoder().encode(request)
        case .updateFolio(let request):
            return try? JSONEncoder().encode(request)
        case .batchCreateFolios(let request):
            return try? JSONEncoder().encode(request)
        default:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: domain + path) else {
            throw APIError.invalidURL
        }
        let encoding: ParameterEncoding = (method == .get) ? URLEncoding.default : JSONEncoding.default
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        headers?.forEach {
            request.addValue($0.value,
                             forHTTPHeaderField: $0.key)
        }
        
        return try encoding.encode(request,
                                   with: parameters)
    }
} 