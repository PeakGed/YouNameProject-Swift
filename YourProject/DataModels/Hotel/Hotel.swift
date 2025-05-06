//
//  Hotel.swift
//  YourProject
//
//  Created by IntrodexMini on 6/5/2568 BE.
//

import Foundation

struct Hotel: Codable {
    let id: Int
    let name: String
    let hotelLogo300: String?
    let photos: [String]
    let headerLogoPhotos: [String]
    let quote: String?
    let bannerImage: String?
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case hotelLogo300 = "hotel_logo_300"
        case photos
        case headerLogoPhotos = "header_logo_photos"
        case quote
        case bannerImage = "banner_image"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        hotelLogo300 = try container.decodeIfPresent(String.self, forKey: .hotelLogo300)
        photos = try container.decode([String].self, forKey: .photos)
        headerLogoPhotos = try container.decode([String].self, forKey: .headerLogoPhotos)
        quote = try container.decodeIfPresent(String.self, forKey: .quote)
        bannerImage = try container.decodeIfPresent(String.self, forKey: .bannerImage)
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(hotelLogo300, forKey: .hotelLogo300)
        try container.encode(photos, forKey: .photos)
        try container.encode(headerLogoPhotos, forKey: .headerLogoPhotos)
        try container.encodeIfPresent(quote, forKey: .quote)
        try container.encodeIfPresent(bannerImage, forKey: .bannerImage)
        try container.encode(createdAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .updatedAt)
    }
}

