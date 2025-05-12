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
    case fetchReservationsByFlags(request: ReservationServiceRequest.FetchReservationsByFlags)
    case fetchReservationsByGuest(request: ReservationServiceRequest.FetchReservationsByGuest)
    case fetchReservationsByCompany(request: ReservationServiceRequest.FetchReservationsByCompany)
    case fetchReservationsByPeriod(request: ReservationServiceRequest.FetchReservationsByPeriod)
    case fetchReservationsByCreatedAt(request: ReservationServiceRequest.FetchReservationsByCreatedAt)
    case fetchReservationsByTags(request: ReservationServiceRequest.FetchReservationsByTags)
    case fetchReservationsByKeyword(request: ReservationServiceRequest.FetchReservationsByKeyword)
    case fetchReservationsByBatchIds(request: ReservationServiceRequest.FetchReservationsByBatchIds)
    case fetchReservationByUid(request: ReservationServiceRequest.FetchReservationByUid)
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
        case .fetchReservations:
            return "/api/v4/reservations"
        case .fetchReservationsByFlags:
            return "/api/v4/reservations/flags"
        case .fetchReservationsByGuest:
            return "/api/v4/reservations/guest"
        case .fetchReservationsByCompany:
            return "/api/v4/reservations/company"
        case .fetchReservationsByPeriod:
            return "/api/v4/reservations/period"
        case .fetchReservationsByCreatedAt:
            return "/api/v4/reservations/created_at"
        case .fetchReservationsByTags:
            return "/api/v4/reservations/tags"
        case .fetchReservationsByKeyword:
            return "/api/v4/reservations/keyword"
        case .fetchReservationsByBatchIds:
            return "/api/v4/reservations/batch_ids"
        case .fetchReservationByUid:
            return "/api/v4/reservations/uid"
        case .fetchReservation(let request):
            return "/api/v4/reservations/\(request.id)"
        case .updateReservation(let request):
            return "/api/v4/reservations/\(request.id)"
        case .deleteReservation(let request):
            return "/api/v4/reservations/\(request.id)"
        case .createReservation:
            return "/api/v4/reservations"
        case .checkIn(let request):
            return "/api/v4/reservations/\(request.id)/check_in"
        case .checkOut(let request):
            return "/api/v4/reservations/\(request.id)/check_out"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchReservations, .fetchReservationsByFlags, .fetchReservationsByGuest, .fetchReservationsByCompany, .fetchReservationsByPeriod, .fetchReservationsByCreatedAt, .fetchReservationsByTags, .fetchReservationsByKeyword, .fetchReservationsByBatchIds, .fetchReservationByUid, .fetchReservation:
            return .get
        case .createReservation, .checkIn, .checkOut:
            return .post
        case .updateReservation:
            return .put
        case .deleteReservation:
            return .delete
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchReservations(let request):
            return request.toDictionary()
        case .fetchReservationsByFlags(let request):
            return request.toDictionary()
        case .fetchReservationsByGuest(let request):
            return request.toDictionary()
        case .fetchReservationsByCompany(let request):
            return request.toDictionary()
        case .fetchReservationsByPeriod(let request):
            return request.toDictionary()
        case .fetchReservationsByCreatedAt(let request):
            return request.toDictionary()
        case .fetchReservationsByTags(let request):
            return request.toDictionary()
        case .fetchReservationsByKeyword(let request):
            return request.toDictionary()
        case .fetchReservationsByBatchIds(let request):
            return request.toDictionary()
        case .fetchReservationByUid(let request):
            return request.toDictionary()
        default:
            return nil
        }
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
