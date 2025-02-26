//
//  HotelRouterService.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//

import Alamofire
import Foundation

enum HotelRouterService: AlamofireBaseRouterProtocol {
    
    case fetchHotels(request: HotelServiceRequest.FetchHotels)
    case createHotel(request: HotelServiceRequest.CreateHotel)
    case updateHotel(request: HotelServiceRequest.UpdateHotel)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchHotels(_):
            return "/v4/hotels"
        case .createHotel(_):
            return "/api/v4/hotels"
        case .updateHotel(let request):
            return "/api/v4/hotels/\(request.hotelId)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchHotels(_):
            return .get
        case .createHotel(_):
            return .post
        case .updateHotel(_):
            return .put
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .createHotel(_), .updateHotel(_):
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "Accept": "application/json"]
        default:
            return nil
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchHotels(let request):
            return nil 
        case .createHotel(let request):
            return request.asParameters()
        case .updateHotel(let request):
            return request.asParameters()
        }
    }
    
    var body: Data? {
        return nil
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
