//
//  LocalStorageManager.swift
//  YourProject
//
//  Created by IntrodexMini on 30/1/2568 BE.
//
import Foundation
import KeychainSwift

protocol LocalStorageManagerProtocal {
    var accessToken: String? { get set }
    var refreshToken: String? { get set }
}

class LocalStorageManager: LocalStorageManagerProtocal {
    @SecureEnclaveWrapper(key: Key.accessToken.rawValue)
    var accessToken: String?
    
    @SecureEnclaveWrapper(key: Key.refreshToken.rawValue)
    var refreshToken: String?
    
    private let keychainHelper: KeychainHelperable
    
    init(keychainHelper: KeychainHelperable = KeyChainHelper()) {
        self.keychainHelper = keychainHelper
    }
    
}

extension LocalStorageManager {
    enum Key: String {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
