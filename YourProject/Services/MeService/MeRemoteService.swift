//
//  MeRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 25/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol MeServiceProtocol: AnyObject {
    func fetchProfile() async throws -> Me
    func updateProfile(request: MeServiceRequest.UpdateProfile) async throws -> Me
    func changeEmail(request: MeServiceRequest.ChangeEmail) async throws -> Me
    func changePassword(request: MeServiceRequest.ChangePassword) async throws -> Me
    func verification(userId: Int, request: MeServiceRequest.Verification) async throws -> Me
}

class MeRemoteService: MeServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }    
    
    func fetchProfile() async throws -> Me {
        let router = MeRouterService.fetchProfile
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func updateProfile(request: MeServiceRequest.UpdateProfile) async throws -> Me {
        let router = MeRouterService.updateProfile(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func changeEmail(request: MeServiceRequest.ChangeEmail) async throws -> Me {
        let router = MeRouterService.changeEmail(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func changePassword(request: MeServiceRequest.ChangePassword) async throws -> Me {
        let router = MeRouterService.changePassword(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
    
    func verification(userId: Int, request: MeServiceRequest.Verification) async throws -> Me {
        let router = MeRouterService.verification(request: request)
        return try await apiManager.request(router: router, requiredAuthorization: true)
    }
} 
