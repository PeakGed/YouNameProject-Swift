//
//  Staff.swift
//  YourProject
//
//  Created by IntrodexMini on 28/2/2568 BE.
//
import Foundation

struct Staff: Codable {
    let id: Int
    let status: String
    let role: String
    let data: [String: String]
    let createdAt: Date
    let updatedAt: Date
    let hotelId: Int
    let user: Self.User

    enum CodingKeys: String, CodingKey {
        case id, status, role, data
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hotelId = "hotel_id"
        case user
    }
    
    // Custom init to handle the [String: Any] data field
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        status = try container.decode(String.self, forKey: .status)
        role = try container.decode(String.self, forKey: .role)
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        user = try container.decode(Self.User.self, forKey: .user)
        
        // Handle the data field which is a dictionary
        // In the example it's empty, but we'll decode it as [String: String]
        // You might need to adjust this based on the actual data structure
        if let dataDict = try? container.decode([String: String].self, forKey: .data) {
            data = dataDict
        } else {
            data = [:]
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(status, forKey: .status)
        try container.encode(role, forKey: .role)
        try container.encode(createdAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .updatedAt)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(user, forKey: .user)
    }
    
}

extension Staff {
    
    struct User: Codable {
        let id: Int
        let email: String
        let firstName: String
        let lastName: String
        let promoCode: String?
        let phoneNumber: String
        let role: String
        let staffRole: String
        let idCard: String
        let maxUnits: Int
        let maxHotels: Int
        let trustAuthor: Bool
        let logoImage: String?
        let signSignatureImage: String?
        let notificationLanguage: String
        let registeredLineAccessToken: Bool
        let verifiedAt: String?
        let passwordChangedAt: String?
        let createdAt: String
        let updatedAt: String
        let images: [String]
        
        enum CodingKeys: String, CodingKey {
            case id, email, images
            case firstName = "first_name"
            case lastName = "last_name"
            case promoCode = "promo_code"
            case phoneNumber = "phone_number"
            case role
            case staffRole = "staff_role"
            case idCard = "id_card"
            case maxUnits = "max_units"
            case maxHotels = "max_hotels"
            case trustAuthor = "trust_author"
            case logoImage = "logo_image"
            case signSignatureImage = "sign_signature_image"
            case notificationLanguage = "notification_language"
            case registeredLineAccessToken = "registered_line_access_token"
            case verifiedAt = "verified_at"
            case passwordChangedAt = "password_changed_at"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
}



/*
 [
     {
         "id": 36,
         "status": "active",
         "role": "front_desk",
         "data": {},
         "created_at": "2021-11-16T13:17:05.109+07:00",
         "updated_at": "2021-11-16T13:17:05.109+07:00",
         "hotel_id": 105,
         "user": {
             "id": 127,
             "email": "demo_staff123@email.com",
             "first_name": "rrr",
             "last_name": "fff",
             "promo_code": null,
             "phone_number": "[[rpr[e",
             "role": "ROLE_USER",
             "staff_role": "front_desk",
             "id_card": "3434434",
             "max_units": 40,
             "max_hotels": 1,
             "trust_author": false,
             "logo_image": "https://hms-heroku.s3.ap-southeast-1.amazonaws.com/documents/65f988f3-b52c-47dc-8e82-5bddf1c47b8b/F9FD7BD0-356A-407C-892B-946C9EBAB000.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2I7XJ7WJNRHU7NRV%2F20250228%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250228T013925Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=fd2aad73c210f7d381c44fba25c24d50e7473b19277d05bfd7bf551d36ef9b88",
             "sign_signature_image": null,
             "notification_language": "en",
             "registered_line_access_token": false,
             "verified_at": null,
             "password_changed_at": null,
             "created_at": "2021-11-16T13:17:05.093+07:00",
             "updated_at": "2021-11-16T13:17:05.436+07:00",
             "images": []
         }
     },
     {
         "id": 33,
         "status": "active",
         "role": "manager",
         "data": {},
         "created_at": "2020-01-24T15:49:05.724+07:00",
         "updated_at": "2020-01-24T15:49:05.724+07:00",
         "hotel_id": 105,
         "user": {
             "id": 121,
             "email": "mnager2@email.com",
             "first_name": "Manaqe3",
             "last_name": "5555",
             "promo_code": null,
             "phone_number": "0111011010",
             "role": "ROLE_USER",
             "staff_role": "manager",
             "id_card": "99999",
             "max_units": 40,
             "max_hotels": 1,
             "trust_author": false,
             "logo_image": "https://hms-heroku.s3.ap-southeast-1.amazonaws.com/documents/3ca681bf-e4e2-47ae-b8b9-7ba9ac9d9972/33CBD222-CE4C-47F4-BE2A-1AB8DFEBF594.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2I7XJ7WJNRHU7NRV%2F20250228%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250228T013925Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=e883af1242336af1f319f32c5dc780dccba1650bff0a2b913685a4ba65b262ab",
             "sign_signature_image": null,
             "notification_language": "en",
             "registered_line_access_token": false,
             "verified_at": null,
             "password_changed_at": null,
             "created_at": "2020-01-24T15:49:05.678+07:00",
             "updated_at": "2021-11-16T08:39:29.778+07:00",
             "images": []
         }
     },
     {
         "id": 32,
         "status": "active",
         "role": "front_desk",
         "data": {},
         "created_at": "2020-01-23T08:17:11.621+07:00",
         "updated_at": "2020-01-23T08:17:11.621+07:00",
         "hotel_id": 105,
         "user": {
             "id": 120,
             "email": "staff101@email.com",
             "first_name": "salads",
             "last_name": "asdsadas",
             "promo_code": null,
             "phone_number": "00292992",
             "role": "ROLE_USER",
             "staff_role": "front_desk",
             "id_card": "1213213",
             "max_units": 40,
             "max_hotels": 1,
             "trust_author": false,
             "logo_image": null,
             "sign_signature_image": null,
             "notification_language": "en",
             "registered_line_access_token": false,
             "verified_at": "2020-09-12T15:09:14.108+07:00",
             "password_changed_at": "2023-06-17T13:58:56.870+07:00",
             "created_at": "2020-01-23T08:17:11.606+07:00",
             "updated_at": "2023-06-17T13:58:56.927+07:00",
             "images": []
         }
     },
     {
         "id": 31,
         "status": "active",
         "role": "manager",
         "data": {},
         "created_at": "2020-01-23T07:52:36.268+07:00",
         "updated_at": "2020-01-23T07:52:36.268+07:00",
         "hotel_id": 105,
         "user": {
             "id": 119,
             "email": "manager1@email.com",
             "first_name": "ABCD",
             "last_name": "DEFG",
             "promo_code": null,
             "phone_number": "0938388833",
             "role": "ROLE_USER",
             "staff_role": "manager",
             "id_card": "1212121221212",
             "max_units": 40,
             "max_hotels": 1,
             "trust_author": false,
             "logo_image": null,
             "sign_signature_image": null,
             "notification_language": "en",
             "registered_line_access_token": false,
             "verified_at": "2021-04-27T10:18:00.000+07:00",
             "password_changed_at": "2020-10-25T17:22:10.259+07:00",
             "created_at": "2020-01-23T07:52:36.220+07:00",
             "updated_at": "2023-10-04T13:05:19.219+07:00",
             "images": []
         }
     }
 ]
 */
