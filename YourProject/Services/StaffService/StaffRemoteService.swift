//
//  StaffRemoteService.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//
import Foundation
import Alamofire
import Mockable

@Mockable
protocol StaffServiceProtocol: AnyObject {
    func fetchStaffs(request: StaffServiceRequest.FetchStaffs) async throws -> Staffs
    func fetchStaff(request: StaffServiceRequest.FetchStaff) async throws -> Staff
    func createStaff(request: StaffServiceRequest.CreateStaff) async throws -> Staff
    func updateStaff(request: StaffServiceRequest.UpdateStaff) async throws -> Staff
    func deleteStaff(request: StaffServiceRequest.DeleteStaff) async throws
    // New methods for additional endpoints
    func changeHotel(request: StaffServiceRequest.ChangeHotel) async throws -> Staff
    func changePassword(request: StaffServiceRequest.ChangePassword) async throws -> Staff
    func updateStaffDetails(request: StaffServiceRequest.UpdateStaffDetails) async throws -> Staff
}

class StaffRemoteService: StaffServiceProtocol {
    
    private var localStorage: LocalStorageManagerProtocal
    private let apiManager: APIManagerProtocal
    
    init(localStorage: LocalStorageManagerProtocal = LocalStorageManager(),
         apiManager: APIManagerProtocal = APIManager.shared) {
        self.localStorage = localStorage
        self.apiManager = apiManager
    }
    
    func fetchStaffs(request: StaffServiceRequest.FetchStaffs) async throws -> Staffs {
        let router = StaffRouterService.fetchStaffs(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func fetchStaff(request: StaffServiceRequest.FetchStaff) async throws -> Staff {
        let router = StaffRouterService.fetchStaff(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func createStaff(request: StaffServiceRequest.CreateStaff) async throws -> Staff {
        let router = StaffRouterService.createStaff(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func updateStaff(request: StaffServiceRequest.UpdateStaff) async throws -> Staff {
        let router = StaffRouterService.updateStaff(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func deleteStaff(request: StaffServiceRequest.DeleteStaff) async throws {
        let router = StaffRouterService.deleteStaff(request: request)
        try await apiManager
            .requestACK(
                router: router,
                requiredAuthorization: true
            )
    }
    
    // Implementation of new methods
    
    func changeHotel(request: StaffServiceRequest.ChangeHotel) async throws -> Staff {
        let router = StaffRouterService.changeHotel(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func changePassword(request: StaffServiceRequest.ChangePassword) async throws -> Staff {
        let router = StaffRouterService.changePassword(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
    
    func updateStaffDetails(request: StaffServiceRequest.UpdateStaffDetails) async throws -> Staff {
        let router = StaffRouterService.updateStaffDetails(request: request)
        return try await apiManager.request(router: router,
                                            requiredAuthorization: true)
    }
} 
