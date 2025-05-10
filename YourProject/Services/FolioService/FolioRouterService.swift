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
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchFolios(_), .fetchFolio(_):
            return .get
        case .createFolio(_):
            return .post
        case .updateFolio(_):
            return .put
        case .deleteFolio(_):
            return .delete
        }
    }
    
    var headers: [String: String]? {
        var headers = ["Content-Type": "application/json"]
        if method == .post {
            headers["Content-Type"] = "application/x-www-form-urlencoded"
        }
        headers["Accept"] = "application/json"
        return headers
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchFolios(let request):
            var params: [String: Any] = ["hotel_id": request.hotelId]
            if let page = request.page { params["page"] = page }
            if let perPage = request.perPage { params["per_page"] = perPage }
            if let sortedBy = request.sortedBy { params["sorted_by"] = sortedBy }
            if let sortedOrder = request.sortedOrder { params["sorted_order"] = sortedOrder }
            return params
        case .createFolio(let request):
            return [
                "hotel_id": request.hotelId,
                "name": request.name,
                "amount": request.amount,
                "description": request.description,
                "category_id": request.categoryId,
                "amount_vat_option": request.amountVatOption
            ]
        case .updateFolio(let request):
            var params: [String: Any] = [:]
            if let name = request.name { params["name"] = name }
            if let amount = request.amount { params["amount"] = amount }
            if let description = request.description { params["description"] = description }
            if let categoryId = request.categoryId { params["category_id"] = categoryId }
            if let amountVatOption = request.amountVatOption { params["amount_vat_option"] = amountVatOption }
            return params
        default:
            return nil
        }
    }
    
    var body: Data? {
        return nil // We're using parameters instead of body for all requests
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: domain + path) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers?.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : URLEncoding.httpBody
        return try encoding.encode(request, with: parameters)
    }
} 