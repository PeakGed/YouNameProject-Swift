//
//  AuthService.swift
//  YourProject
//
//  Created by IntrodexMini on 1/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol AuthServiceProtocol: AnyObject {
    func emailLogin(request: AuthServiceRequest.EmailLogin) async throws
    func tokenRefresh(request: AuthServiceRequest.TokenRefresh) async throws
    func logout() async throws
}

class AuthRemoteService: AuthServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func emailLogin(request: AuthServiceRequest.EmailLogin) async throws {
        let router = AuthRouterService.emailLogin(request: request)
        
        let response: AuthTokenResponse = try await apiManager.request(router: router,
                                                                       requiredAuthorization: false)
        localStorage.setToken(response)
    }
    
    func tokenRefresh(request: AuthServiceRequest.TokenRefresh) async throws {
        let router = AuthRouterService.refreshToken(request: request)
        let response: AuthTokenResponse = try await apiManager.request(router: router,
                                                                       requiredAuthorization: true)
        localStorage.setToken(response)
    }
    
    func logout() async throws {
        let router = AuthRouterService.logout
        try await apiManager.requestACK(router: router,
                                        requiredAuthorization: false)
        localStorage.clearToken()
    }
    
    
}
