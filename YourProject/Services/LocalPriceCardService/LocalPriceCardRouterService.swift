//
//  LocalPriceCardRouterService.swift
//  YourProject
//
//  Created by IntrodexMini on 28/2/2568 BE.
//

import Alamofire
import Foundation

enum LocalPriceCardRouterService: AlamofireBaseRouterProtocol {
    
    case fetchPriceCards(request: LocalPriceCardServiceRequest.FetchPriceCards)
    case getPriceCard(request: LocalPriceCardServiceRequest.GetPriceCard)
    case createPriceCard(request: LocalPriceCardServiceRequest.CreatePriceCard)
    case updatePriceCard(request: LocalPriceCardServiceRequest.UpdatePriceCard)
    case deletePriceCard(request: LocalPriceCardServiceRequest.DeletePriceCard)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchPriceCards(_):
            return "/api/v4/price-cards/period"
        case .getPriceCard(let request):
            return "/api/v4/price-cards/\(request.id)"
        case .createPriceCard(_):
            return "/api/v4/price-cards"
        case .updatePriceCard(let request):
            return "/api/v4/price-cards/\(request.id)"
        case .deletePriceCard(let request):
            return "/api/v4/price-cards/\(request.id)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchPriceCards(_), .getPriceCard(_):
            return .get
        case .createPriceCard(_):
            return .post
        case .updatePriceCard(_):
            return .put
        case .deletePriceCard(_):
            return .delete
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .createPriceCard(_), .updatePriceCard(_):
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "Accept": "application/json"]
        case .getPriceCard(_), .fetchPriceCards(_):
            return ["Accept": "application/json"]
        default:
            return nil
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchPriceCards(let request):
            return request.asParameters()
        case .getPriceCard(_):
            return nil
        case .createPriceCard(let request):
            return request.asParameters()
        case .updatePriceCard(let request):
            return request.asParameters()
        case .deletePriceCard(_):
            return nil
        }
    }
    
    var body: Data? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: domain + path) else {
            throw APIError.invalidURL
        }
        
        let encoding: ParameterEncoding
        if method == .get {
            encoding = URLEncoding.default
        } else {
            encoding = URLEncoding.httpBody // Use httpBody for form-urlencoded
        }
        
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
