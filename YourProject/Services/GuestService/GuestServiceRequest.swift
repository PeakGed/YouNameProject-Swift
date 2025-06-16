//
//  StaffServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//
import Foundation


struct GuestServiceRequest {

    typealias HideGuest = ById
    typealias UnhideGuest = ById
    typealias RemoveGuestCompany = ById
    typealias FetchGuest = ById
    typealias DeleteGuest = ById
    
    struct ById {
        let id: Int
    }

    struct FetchGuests: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        let includeHidden: Bool?
        
        var parameters: [String: Any]? {
            var parameters: [String: Any] = [:]
            if let page = page { parameters["page"] = page }
            if let perPage = perPage { parameters["per_page"] = perPage }
            if let sortedBy = sortedBy { parameters["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { parameters["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { parameters["hotel_id"] = hotelId }
            if let includeHidden = includeHidden { parameters["include_hidden"] = includeHidden.toString() }
            return parameters.isEmpty ? nil : parameters
        }
    }
    struct FetchGuestsQuery: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        let q: String?
        let includeHidden: Bool?
        
        var parameters: [String: Any]? {
            var parameters: [String: Any] = [:]
            if let page = page { parameters["page"] = page }
            if let perPage = perPage { parameters["per_page"] = perPage }
            if let sortedBy = sortedBy { parameters["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { parameters["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { parameters["hotel_id"] = hotelId }
            if let q = q { parameters["q"] = q }
            if let includeHidden = includeHidden { parameters["include_hidden"] = includeHidden.toString() }
            return parameters.isEmpty ? nil : parameters
        }
    }
    struct FetchGuestsCompany: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        let companyId: Int?
        let includeHidden: Bool?
        
        var parameters: [String: Any]? {
            var parameters: [String: Any] = [:]
            if let page = page { parameters["page"] = page }
            if let perPage = perPage { parameters["per_page"] = perPage }
            if let sortedBy = sortedBy { parameters["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { parameters["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { parameters["hotel_id"] = hotelId }
            if let companyId = companyId { parameters["company_id"] = companyId }
            if let includeHidden = includeHidden { parameters["include_hidden"] = includeHidden.toString() }
            return parameters.isEmpty ? nil : parameters
        }
    }
    struct FetchGuestsReservation: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        let reservationId: Int?
        let includeHidden: Bool?
        
        var parameters: [String: Any]? {
            var parameters: [String: Any] = [:]
            if let page = page { parameters["page"] = page }
            if let perPage = perPage { parameters["per_page"] = perPage }
            if let sortedBy = sortedBy { parameters["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { parameters["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { parameters["hotel_id"] = hotelId }
            if let reservationId = reservationId { parameters["reservation_id"] = reservationId }
            if let includeHidden = includeHidden { parameters["include_hidden"] = includeHidden.toString() }
            return parameters.isEmpty ? nil : parameters
        }
    }
    struct FetchGuestsDatetimeOffset: Encodable {
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        let hotelId: Int?
        let datetimeOffset: String?
        let includeHidden: Bool?
        
        var parameters: [String: Any]? {
            var parameters: [String: Any] = [:]
            if let page = page { parameters["page"] = page }
            if let perPage = perPage { parameters["per_page"] = perPage }
            if let sortedBy = sortedBy { parameters["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { parameters["sorted_order"] = sortedOrder }
            if let hotelId = hotelId { parameters["hotel_id"] = hotelId }
            if let datetimeOffset = datetimeOffset { parameters["datetime_offset"] = datetimeOffset }
            if let includeHidden = includeHidden { parameters["include_hidden"] = includeHidden.toString() }
            return parameters.isEmpty ? nil : parameters
        }
    }
    struct CreateGuest: Encodable {
        let firstName: String
        let lastName: String
        let nationality: String
        let country: String
        let reservationId: Int?
        let companyId: Int?
        let hotelId: Int
        let title: String?
        let middleName: String?
        let dateOfBirth: String?
        let idCardNo: String?
        let passportNo: String?
        let gender: Guest.Gender?
        let email: String?
        let occupation: String?
        let phone: String?
        let address: String?
        let district: String?
        let province: String?
        let zipCode: String?
        let note: String?
        let nickname: String?
        let photos: [String]?
        let documentPhotos: [String]?

        //encode
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(firstName, forKey: .firstName)
            try container.encode(lastName, forKey: .lastName)
            try container.encode(nationality, forKey: .nationality)
            try container.encode(country, forKey: .country)
            try container.encode(reservationId, forKey: .reservationId)
            try container.encode(companyId, forKey: .companyId)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(title, forKey: .title)
            try container.encode(middleName, forKey: .middleName)
            try container.encode(dateOfBirth, forKey: .dateOfBirth)
            try container.encode(idCardNo, forKey: .idCardNo)
            try container.encode(passportNo, forKey: .passportNo)
            try container.encode(gender?.rawValue, forKey: .gender)
            try container.encode(email, forKey: .email)
            try container.encode(occupation, forKey: .occupation)
            try container.encode(phone, forKey: .phone)
            try container.encode(address, forKey: .address)
            try container.encode(district, forKey: .district)
            try container.encode(province, forKey: .province)
            try container.encode(zipCode, forKey: .zipCode)
            try container.encode(note, forKey: .note)
            try container.encode(nickname, forKey: .nickname)
            try container.encode(photos, forKey: .photos)
            try container.encode(documentPhotos, forKey: .documentPhotos)
        }
        
        enum CodingKeys: String, CodingKey {
            case firstName = "first_name"
            case lastName = "last_name"
            case nationality
            case country
            case reservationId = "reservation_id"
            case companyId = "company_id"
            case hotelId = "hotel_id"
            case title
            case middleName = "middle_name"
            case dateOfBirth = "date_of_birth"
            case idCardNo = "id_card_no"
            case passportNo = "passport_no"
            case gender
            case email
            case occupation
            case phone
            case address
            case district
            case province
            case zipCode = "zip_code"
            case note
            case nickname
            case photos
            case documentPhotos = "document_photos"
        }
    }
    struct UpdateGuest: Encodable {
        let id: Int
        let companyId: Int?
        let title: String?
        let firstName: String?
        let middleName: String?
        let lastName: String?
        let nationality: String?
        let country: String?
        let dateOfBirth: String?
        let idCardNo: String?
        let passportNo: String?
        let gender: Guest.Gender?
        let email: String?
        let occupation: String?
        let phone: String?
        let address: String?
        let district: String?
        let province: String?
        let zipCode: String?
        let note: String?
        let nickname: String?
        let photos: [String]?
        let documentPhotos: [String]?
        
        //encode
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(companyId, forKey: .companyId)
            try container.encodeIfPresent(title, forKey: .title)
            try container.encodeIfPresent(firstName, forKey: .firstName)
            try container.encodeIfPresent(middleName, forKey: .middleName)
            try container.encodeIfPresent(lastName, forKey: .lastName)
            try container.encodeIfPresent(nationality, forKey: .nationality)
            try container.encodeIfPresent(country, forKey: .country)
            try container.encodeIfPresent(dateOfBirth, forKey: .dateOfBirth)
            try container.encodeIfPresent(idCardNo, forKey: .idCardNo)
            try container.encodeIfPresent(passportNo, forKey: .passportNo)
            try container.encodeIfPresent(gender?.rawValue, forKey: .gender)
            try container.encodeIfPresent(email, forKey: .email)
            try container.encodeIfPresent(occupation, forKey: .occupation)
            try container.encodeIfPresent(phone, forKey: .phone)
            try container.encodeIfPresent(address, forKey: .address)
            try container.encodeIfPresent(district, forKey: .district)
            try container.encodeIfPresent(province, forKey: .province)
            try container.encodeIfPresent(zipCode, forKey: .zipCode)
            try container.encodeIfPresent(note, forKey: .note)
            try container.encodeIfPresent(nickname, forKey: .nickname)
            try container.encodeIfPresent(photos, forKey: .photos)
            try container.encodeIfPresent(documentPhotos, forKey: .documentPhotos)
        }
        
        enum CodingKeys: String, CodingKey {
            case companyId = "company_id"
            case title
            case firstName = "first_name"
            case middleName = "middle_name"
            case lastName = "last_name"
            case nationality
            case country
            case dateOfBirth = "date_of_birth"
            case idCardNo = "id_card_no"
            case passportNo = "passport_no"
            case gender
            case email
            case occupation
            case phone
            case address
            case district
            case province
            case zipCode = "zip_code"
            case note
            case nickname
            case photos
            case documentPhotos = "document_photos"
        }
    }

} 
