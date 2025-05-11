//
//  StaffRouterService.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

import Alamofire
import Foundation

enum GuestRouterService: AlamofireBaseRouterProtocol {
    
    case fetchGuests(request: GuestServiceRequest.FetchGuests)
    case fetchGuestsQuery(request: GuestServiceRequest.FetchGuestsQuery)
    case fetchGuestsCompany(request: GuestServiceRequest.FetchGuestsCompany)
    case fetchGuestsReservation(request: GuestServiceRequest.FetchGuestsReservation)
    case fetchGuestsDatetimeOffset(request: GuestServiceRequest.FetchGuestsDatetimeOffset)
    case fetchGuest(id: Int)
    case createGuest(request: GuestServiceRequest.CreateGuest)
    case updateGuest(id: Int, request: GuestServiceRequest.UpdateGuest)
    case deleteGuest(id: Int)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchGuests:
            return "/v4/guests"
        case .fetchGuestsQuery:
            return "/v4/guests/query"
        case .fetchGuestsCompany:
            return "/v4/guests/company"
        case .fetchGuestsReservation:
            return "/v4/guests/reservation"
        case .fetchGuestsDatetimeOffset:
            return "/v4/guests/datetime-offset"
        case .fetchGuest(let id), .updateGuest(let id, _), .deleteGuest(let id):
            return "/v4/guests/\(id)"
        case .createGuest:
            return "/v4/guests"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchGuests, .fetchGuestsQuery, .fetchGuestsCompany, .fetchGuestsReservation, .fetchGuestsDatetimeOffset, .fetchGuest:
            return .get
        case .createGuest:
            return .post
        case .updateGuest:
            return .put
        case .deleteGuest:
            return .delete
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchGuests(let request):
            return request.toDictionary()
        case .fetchGuestsQuery(let request):
            return request.toDictionary()
        case .fetchGuestsCompany(let request):
            return request.toDictionary()
        case .fetchGuestsReservation(let request):
            return request.toDictionary()
        case .fetchGuestsDatetimeOffset(let request):
            return request.toDictionary()
        default:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .createGuest(let request):
            return try? JSONEncoder().encode(request)
        case .updateGuest(_, let request):
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
