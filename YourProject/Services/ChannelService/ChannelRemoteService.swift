//
//  FolioRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

// MARK: - Protocol
@Mockable
protocol ChannelServiceProtocol: AnyObject {
    func fetchChannels(request: ChannelServiceRequest.FetchChannels) async throws -> Channels
    func fetchChannel(request: ChannelServiceRequest.FetchChannel) async throws -> Channel
    func createChannel(request: ChannelServiceRequest.CreateChannel) async throws -> Channel
    func updateChannel(request: ChannelServiceRequest.UpdateChannel) async throws -> Channel
    func deleteChannel(request: ChannelServiceRequest.DeleteChannel) async throws
    func createSubChannel(request: ChannelServiceRequest.CreateSubChannel) async throws -> Channel
}

// MARK: - Implementation
final class ChannelRemoteService: ChannelServiceProtocol {
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchChannels(request: ChannelServiceRequest.FetchChannels) async throws -> Channels {
        let router = ChannelRouterService.fetchChannels(request: request)
        return try await apiManager.request(router: router,
                                          requiredAuthorization: true)
    }
    
    func fetchChannel(request: ChannelServiceRequest.FetchChannel) async throws -> Channel {
        let router = ChannelRouterService.fetchChannel(request: request)
        return try await apiManager.request(router: router,
                                          requiredAuthorization: true)
    }
    
    func createChannel(request: ChannelServiceRequest.CreateChannel) async throws -> Channel {
        let router = ChannelRouterService.createChannel(request: request)
        return try await apiManager.request(router: router,
                                          requiredAuthorization: true)
    }
    
    func updateChannel(request: ChannelServiceRequest.UpdateChannel) async throws -> Channel {
        let router = ChannelRouterService.updateChannel(request: request)
        return try await apiManager.request(router: router,
                                          requiredAuthorization: true)
    }
    
    func deleteChannel(request: ChannelServiceRequest.DeleteChannel) async throws {
        let router = ChannelRouterService.deleteChannel(request: request)
        try await apiManager.requestACK(router: router,
                                      requiredAuthorization: true)
    }
    
    func createSubChannel(request: ChannelServiceRequest.CreateSubChannel) async throws -> Channel {
        let router = ChannelRouterService.createSubChannel(request: request)
        return try await apiManager.request(router: router,
                                          requiredAuthorization: true)
    }
} 
