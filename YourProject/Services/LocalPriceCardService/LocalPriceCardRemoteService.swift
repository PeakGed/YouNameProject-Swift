//
//  LocalPriceCardRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 28/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol LocalPriceCardServiceProtocol: AnyObject {
    func fetchPriceCards(request: LocalPriceCardServiceRequest.FetchPriceCards) async throws -> LocalPriceCards
    func getPriceCard(request: LocalPriceCardServiceRequest.GetPriceCard) async throws -> LocalPriceCards
    func createPriceCard(request: LocalPriceCardServiceRequest.CreatePriceCard) async throws -> LocalPriceCards
    func updatePriceCard(request: LocalPriceCardServiceRequest.UpdatePriceCard) async throws -> LocalPriceCards
    func deletePriceCard(request: LocalPriceCardServiceRequest.DeletePriceCard) async throws 
}

class LocalPriceCardRemoteService: LocalPriceCardServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchPriceCards(request: LocalPriceCardServiceRequest.FetchPriceCards) async throws -> LocalPriceCards {
        let router = LocalPriceCardServiceRouter.fetchPriceCards(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func getPriceCard(request: LocalPriceCardServiceRequest.GetPriceCard) async throws -> LocalPriceCards {
        let router = LocalPriceCardServiceRouter.getPriceCard(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func createPriceCard(request: LocalPriceCardServiceRequest.CreatePriceCard) async throws -> LocalPriceCards {
        let router = LocalPriceCardServiceRouter.createPriceCard(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func updatePriceCard(request: LocalPriceCardServiceRequest.UpdatePriceCard) async throws -> LocalPriceCards {
        let router = LocalPriceCardServiceRouter.updatePriceCard(request: request)
        return try await apiManager.request(router: router,
                                           requiredAuthorization: true)
    }
    
    func deletePriceCard(request: LocalPriceCardServiceRequest.DeletePriceCard) async throws {
        let router = LocalPriceCardServiceRouter.deletePriceCard(request: request)
        try await apiManager.requestACK(router: router,
                                        requiredAuthorization: true)
    }
} 
