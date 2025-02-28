//
//  User.swift
//  YourProject
//
//  Created by IntrodexMini on 28/2/2568 BE.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let role: String
    let idCard: String
    let logoImage: String?
    let signSignatureImage: String?
    let verifiedAt: String?
    let passwordChangedAt: String?
    let currentPackage: CurrentPackage?
    let notificationSetting: NotificationSetting?
    let authProviders: [String]
    let images: [String]
    let staff: Staff?
    let promoCode: String?
    let staffRole: String?
    let maxUnits: Int?
    let maxHotels: Int?
    let trustAuthor: Bool?
    let notificationLanguage: String?
    let registeredLineAccessToken: Bool?
    
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id, email, role, images, staff
        case firstName = "first_name"
        case lastName = "last_name"
        case phoneNumber = "phone_number"
        case idCard = "id_card"
        case logoImage = "logo_image"
        case signSignatureImage = "sign_signature_image"
        case verifiedAt = "verified_at"
        case passwordChangedAt = "password_changed_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case currentPackage = "current_package"
        case notificationSetting = "notification_setting"
        case authProviders = "auth_providers"
        case promoCode = "promo_code"
        case staffRole = "staff_role"
        case maxUnits = "max_units"
        case maxHotels = "max_hotels"
        case trustAuthor = "trust_author"
        case notificationLanguage = "notification_language"
        case registeredLineAccessToken = "registered_line_access_token"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        email = try container.decode(String.self, forKey: .email)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        role = try container.decode(String.self, forKey: .role)
        idCard = try container.decode(String.self, forKey: .idCard)
        logoImage = try container.decodeIfPresent(String.self, forKey: .logoImage)
        signSignatureImage = try container.decodeIfPresent(String.self, forKey: .signSignatureImage)
        verifiedAt = try container.decodeIfPresent(String.self, forKey: .verifiedAt)
        passwordChangedAt = try container.decodeIfPresent(String.self, forKey: .passwordChangedAt)        
        currentPackage = try container.decodeIfPresent(CurrentPackage.self, forKey: .currentPackage)
        notificationSetting = try container.decodeIfPresent(NotificationSetting.self, forKey: .notificationSetting)
        authProviders = try container.decode([String].self, forKey: .authProviders)
        images = try container.decode([String].self, forKey: .images)
        
        // Skip decoding staff since it's a circular reference
        staff = nil
        
        promoCode = try container.decodeIfPresent(String.self, forKey: .promoCode)
        staffRole = try container.decodeIfPresent(String.self, forKey: .staffRole)
        maxUnits = try container.decodeIfPresent(Int.self, forKey: .maxUnits)
        maxHotels = try container.decodeIfPresent(Int.self, forKey: .maxHotels)
        trustAuthor = try container.decodeIfPresent(Bool.self, forKey: .trustAuthor)
        notificationLanguage = try container.decodeIfPresent(String.self, forKey: .notificationLanguage)
        registeredLineAccessToken = try container.decodeIfPresent(Bool.self, forKey: .registeredLineAccessToken)

        self.createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(role, forKey: .role)
        try container.encode(idCard, forKey: .idCard)
        try container.encodeIfPresent(logoImage, forKey: .logoImage)
        try container.encodeIfPresent(signSignatureImage, forKey: .signSignatureImage)
        try container.encodeIfPresent(verifiedAt, forKey: .verifiedAt)
        try container.encodeIfPresent(passwordChangedAt, forKey: .passwordChangedAt)        
        try container.encodeIfPresent(currentPackage, forKey: .currentPackage)
        try container.encodeIfPresent(notificationSetting, forKey: .notificationSetting)
        try container.encode(authProviders, forKey: .authProviders)
        try container.encode(images, forKey: .images)
        
        // Skip encoding staff since it's a circular reference
        
        try container.encodeIfPresent(promoCode, forKey: .promoCode)
        try container.encodeIfPresent(staffRole, forKey: .staffRole)
        try container.encodeIfPresent(maxUnits, forKey: .maxUnits)
        try container.encodeIfPresent(maxHotels, forKey: .maxHotels)
        try container.encodeIfPresent(trustAuthor, forKey: .trustAuthor)
        try container.encodeIfPresent(notificationLanguage, forKey: .notificationLanguage)
        try container.encodeIfPresent(registeredLineAccessToken, forKey: .registeredLineAccessToken)

        try container.encode(createdAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .updatedAt)
    }
}

struct CurrentPackage: Codable {
    let maxUnits: Int
    let maxHotels: Int
    let currentUnits: Int
    let currentHotels: Int
    let expiresAt: String?
    let salePackages: [SalePackage]
    
    enum CodingKeys: String, CodingKey {
        case maxUnits = "max_units"
        case maxHotels = "max_hotels"
        case currentUnits = "current_units"
        case currentHotels = "current_hotels"
        case expiresAt = "expires_at"
        case salePackages = "sale_packages"
    }
}

struct SalePackage: Codable {
    let title: String
    let description: String
    let pmsIncluded: Bool
    let cmIncluded: Bool
    let extendExpiredDay: Int
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case title, description
        case pmsIncluded = "pms_included"
        case cmIncluded = "cm_included"
        case extendExpiredDay = "extend_expired_day"
        case createdAt = "created_at"
    }
}

struct NotificationSetting: Codable {
    let notificationLanguage: String
    let registeredLineAccessToken: Bool
    let pushNotification: NotificationChannelSettings
    let lineNotification: NotificationChannelSettings
    
    enum CodingKeys: String, CodingKey {
        case notificationLanguage = "notification_language"
        case registeredLineAccessToken = "registered_line_access_token"
        case pushNotification = "push_notification"
        case lineNotification = "line_notification"
    }
}

struct NotificationChannelSettings: Codable {
    let cmBooking: NotificationMessageSettings
    let hmsReservation: NotificationMessageSettings
    let broadcastMessage: BroadcastMessageSettings
    
    enum CodingKeys: String, CodingKey {
        case cmBooking = "cm_booking"
        case hmsReservation = "hms_reservation"
        case broadcastMessage = "broadcast_message"
    }
}

struct NotificationMessageSettings: Codable {
    let newMessage: Bool
    let updatedMessage: Bool
    let cancelledMessage: Bool
    
    enum CodingKeys: String, CodingKey {
        case newMessage = "new_message"
        case updatedMessage = "updated_message"
        case cancelledMessage = "cancelled_message"
    }
}

struct BroadcastMessageSettings: Codable {
    let adminMessage: Bool
    let systemMessage: Bool
    let operatorMessage: Bool
    
    enum CodingKeys: String, CodingKey {
        case adminMessage = "admin_message"
        case systemMessage = "system_message"
        case operatorMessage = "operator_message"
    }
}

/*
 json response
 {
     "id": 38,
     "email": "test1@email.com",
     "first_name": "John2",
     "last_name": "Doe2",
     "phone_number": "1234567890",
     "role": "ROLE_SUPPORT_SUPER_ADMIN",
     "id_card": "1232323232333",
     "logo_image": null,
     "sign_signature_image": null,
     "verified_at": null,
     "password_changed_at": "2023-11-28T06:11:43.011+07:00",
     "created_at": "2016-12-28T20:54:08.650+07:00",
     "updated_at": "2025-02-26T05:35:58.313+07:00",
     "current_package": {
         "max_units": 43,
         "max_hotels": 4,
         "current_units": 15,
         "current_hotels": 2,
         "expires_at": null,
         "sale_packages": [
             {
                 "title": "PMS 1Y",
                 "description": "1Y",
                 "pms_included": true,
                 "cm_included": false,
                 "extend_expired_day": 365,
                 "created_at": "2022-10-16T18:35:28.066+07:00"
             },
             {
                 "title": "PMS 1Y",
                 "description": "1Y",
                 "pms_included": true,
                 "cm_included": false,
                 "extend_expired_day": 365,
                 "created_at": "2022-10-16T18:45:25.690+07:00"
             },
             {
                 "title": "PMS 1Y",
                 "description": "1Y",
                 "pms_included": true,
                 "cm_included": false,
                 "extend_expired_day": 365,
                 "created_at": "2022-10-16T18:54:40.899+07:00"
             },
             {
                 "title": "PMS 1Y",
                 "description": "1Y",
                 "pms_included": true,
                 "cm_included": false,
                 "extend_expired_day": 365,
                 "created_at": "2022-10-19T21:12:45.206+07:00"
             }
         ]
     },
     "notification_setting": {
         "notification_language": "th",
         "registered_line_access_token": true,
         "push_notification": {
             "cm_booking": {
                 "new_message": true,
                 "updated_message": true,
                 "cancelled_message": true
             },
             "hms_reservation": {
                 "new_message": true,
                 "updated_message": true,
                 "cancelled_message": true
             },
             "broadcast_message": {
                 "admin_message": true,
                 "system_message": true,
                 "operator_message": true
             }
         },
         "line_notification": {
             "cm_booking": {
                 "new_message": true,
                 "updated_message": true,
                 "cancelled_message": true
             },
             "hms_reservation": {
                 "new_message": true,
                 "updated_message": true,
                 "cancelled_message": true
             },
             "broadcast_message": {
                 "admin_message": true,
                 "system_message": true,
                 "operator_message": true
             }
         }
     },
     "auth_providers": [],
     "images": [],
     "staff": null
 }
 */


