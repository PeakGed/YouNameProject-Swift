//
//  AuthService.swift
//  YourProject
//
//  Created by IntrodexMini on 1/2/2568 BE.
//
import Foundation
import Alamofire

protocol AuthServiceProtocol: AnyObject {
    func emailLogin(request: AuthServiceRequest.EmailLogin) async throws
    func tokenRefresh(request: AuthServiceRequest.TokenRefresh) async throws
    func logout() async throws
}

class AuthRemoteService: AuthServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager()) {
        self.localStorage = localStorage
    }
    
    func emailLogin(request: AuthServiceRequest.EmailLogin) async throws {
        let router = AuthRouterService.emailLogin(request: request)
        let response: AuthTokenResponse = try await APIManager.shared.request(router.path,
                                                                              method: router.method,
                                                                              parameters: router.parameters,
                                                                              requiredAuthorization: false)
        localStorage.setToken(response)
    }

    func tokenRefresh(request: AuthServiceRequest.TokenRefresh) async throws {
        let router = AuthRouterService.refreshToken(request: request)
        let response: AuthTokenResponse = try await APIManager.shared.request(router.path,
                                                                              method: router.method,
                                                                              parameters: router.parameters,
                                                                              requiredAuthorization: false)
        localStorage.setToken(response)
    }
    
    func logout() async throws {
        
    }
    
    
}
