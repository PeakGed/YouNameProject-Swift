//
//  ReservationServiceRouter.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//

import Alamofire
import Foundation

enum ReservationServiceRouter: AlamofireBaseRouterProtocol {
    
    case fetchReservations(request: ReservationServiceRequest.FetchReservations)
    case fetchReservation(request: ReservationServiceRequest.FetchReservation)
    case createReservation(request: ReservationServiceRequest.CreateReservation)
    case updateReservation(request: ReservationServiceRequest.UpdateReservation)
    case deleteReservation(request: ReservationServiceRequest.DeleteReservation)
    case checkIn(request: ReservationServiceRequest.CheckIn)
    case checkOut(request: ReservationServiceRequest.CheckOut)
    
    var domain: String {
        return AppConfiguration.shared.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchReservations(_):
            return "/api/v4/reservations"
        case .fetchReservation(let request):
            return "/api/v4/reservations/\(request.id)"
        case .createReservation(_):
            return "/api/v4/reservations"
        case .updateReservation(let request):
            return "/api/v4/reservations/\(request.id)"
        case .deleteReservation(let request):
            return "/api/v4/reservations/\(request.id)"
        case .checkIn(let request):
            return "/api/v4/reservations/\(request.id)/check_in"
        case .checkOut(let request):
            return "/api/v4/reservations/\(request.id)/check_out"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchReservations(_), .fetchReservation(_):
            return .get
        case .createReservation(_), .checkIn(_), .checkOut(_):
            return .post
        case .updateReservation(_):
            return .put
        case .deleteReservation(_):
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
        case .createReservation(let request):
            return try? JSONEncoder().encode(request)
        case .updateReservation(let request):
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
