//
//  HotelRouterService.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//

import Alamofire
import Foundation

enum HotelRouterService: AlamofireBaseRouterProtocol {
    
    case fetchHotels
    case createHotel(request: HotelServiceRequest.CreateHotel)
    case updateHotel(request: HotelServiceRequest.UpdateHotel)
    case fetchHotelsShort
    case deleteHotel(request: HotelServiceRequest.DeleteHotel)
    case fetchChannelManager(request: HotelServiceRequest.FetchChannelManagerFeature)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchHotels:
            return "/v4/hotels"
        case .createHotel(_):
            return "/api/v4/hotels"
        case .updateHotel(let request):
            return "/api/v4/hotels/\(request.hotelId)"
        case .fetchHotelsShort:
            return "/api/v4/hotels/short"
        case .deleteHotel(let request):
            return "/api/v4/hotels/\(request.hotelId)"
        case .fetchChannelManager(let request):
            return "/api/v4/hotels/\(request.hotelId)/channel-manager"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchHotels:
            return .get
        case .createHotel(_):
            return .post
        case .updateHotel(_):
            return .put
        case .fetchHotelsShort:
            return .get
        case .deleteHotel(_):
            return .delete
        case .fetchChannelManager(_):
            return .get
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
        case .createHotel(let request):
            return try? JSONEncoder().encode(request)
        case .updateHotel(let request):
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
