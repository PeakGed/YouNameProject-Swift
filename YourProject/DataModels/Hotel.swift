//
//  Hotel.swift
//  YourProject
//
//  Created by IntrodexMini on 26/2/2568 BE.
//

struct Hotel: Codable {
    let id: Int
    let name: String
    let status: String
    let information: String
    let address: String
    let geolocation: String?
    let phone: String?
    let policies: String?
    let email: String?
    let website: String?
    let workingTime: String?
    let checkInTime: String?
    let checkOutTime: String?
    let note: String?
    let hotelLogo300: String?
    let taxNumber: String?
    let photos: [String]
    let headerLogoPhotos: [String]
    let tags: [String]
    let quote: String?
    let termAndCondition: String?
    let latitude: String?
    let longitude: String?
    let channelManagerEnabled: Bool
    let channelManager: ChannelManagerFeature?
    let logoImage: String?
    let bannerImage: String?
    let createdAt: String
    let updatedAt: String
    let beds24Config: Beds24Config?
    let colorProfile: ColorProfile?
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, information, address, geolocation, phone, policies, email, website
        case workingTime = "working_time"
        case checkInTime = "check_in_time"
        case checkOutTime = "check_out_time"
        case note
        case hotelLogo300 = "hotel_logo_300"
        case taxNumber = "tax_number"
        case photos, headerLogoPhotos = "header_logo_photos", tags, quote
        case termAndCondition = "term_and_condition"
        case latitude, longitude
        case channelManagerEnabled = "channel_manager_enabled"
        case channelManager = "channel_manager"
        case logoImage = "logo_image"
        case bannerImage = "banner_image"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case beds24Config = "beds24_config"
        case colorProfile = "color_profile"
    }
}

struct ChannelManagerFeature: Codable {
    let enabled: Bool
    let otas: [Ota]
    let otaRateCodes: [String: RateCodeList]
    
    enum CodingKeys: String, CodingKey {
        case enabled
        case otas = "otas_list"
        case otaRateCodes = "ota_rate_codes"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        enabled = try container.decode(Bool.self, forKey: .enabled)
        
        // Handle otas which might be missing in some responses
        if container.contains(.otas) {
            otas = try container.decode([Ota].self, forKey: .otas)
        } else {
            otas = []
        }
        
        // Handle otaRateCodes which is a dictionary with dynamic keys
        if container.contains(.otaRateCodes) {
            let rateCodesContainer = try container.nestedContainer(keyedBy: DynamicCodingKeys.self, forKey: .otaRateCodes)
            var tempRateCodes = [String: RateCodeList]()
            
            for key in rateCodesContainer.allKeys {
                if let value = try? rateCodesContainer.decode([RateCode].self, forKey: key) {
                    tempRateCodes[key.stringValue] = RateCodeList(rateCodes: value)
                }
            }
            otaRateCodes = tempRateCodes
        } else {
            otaRateCodes = [:]
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(otas, forKey: .otas)
        
        var rateCodesContainer = container.nestedContainer(keyedBy: DynamicCodingKeys.self, forKey: .otaRateCodes)
        for (key, value) in otaRateCodes {
            try rateCodesContainer.encode(value.rateCodes, forKey: DynamicCodingKeys(stringValue: key)!)
        }
    }
    
    // Helper struct for dynamic keys
    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }
        
        init?(intValue: Int) {
            self.stringValue = "\(intValue)"
            self.intValue = intValue
        }
    }
}

// Helper struct to wrap the array of rate codes
struct RateCodeList: Codable {
    let rateCodes: [RateCode]
    
    init(rateCodes: [RateCode]) {
        self.rateCodes = rateCodes
    }
}

// Rate code model
struct RateCode: Codable {
    let code: String
    let name: String
}

struct Ota: Codable {
    let otaName: String
    let beds24Id: String?
    let enabledSyncAllotment: Bool
    let enabledSyncRate: Bool
    
    enum CodingKeys: String, CodingKey {
        case otaName = "ota_name"
        case beds24Id = "beds24_id"
        case enabledSyncAllotment = "enabled_sync_allotment"
        case enabledSyncRate = "enabled_sync_rate"
    }
}

struct Beds24Config: Codable {
    let enabledAutoCancelReservationFromCm: Bool
    
    enum CodingKeys: String, CodingKey {
        case enabledAutoCancelReservationFromCm = "enabled_auto_cancel_reservation_from_cm"
    }
}

struct ColorProfile: Codable {
    let color: String?
    let backgroundColor: String?
    let fontColor: String?
    
    enum CodingKeys: String, CodingKey {
        case color
        case backgroundColor = "background_color"
        case fontColor = "font_color"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        color = try container.decodeIfPresent(String.self, forKey: .color)
        backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor)
        fontColor = try container.decodeIfPresent(String.self, forKey: .fontColor)
    }
}

struct GeoLocation {
    let latitude: Double
    let longtitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longtitude = "longtitude"
    }
    
    enum Location {
        case bangkok
        
        var geoLocation: GeoLocation {
            switch self {
            case .bangkok:
                return GeoLocation(latitude: 13.7245601,
                                   longtitude: 100.4930266)
            }
        }
    }
    
}

/*
 [
 {
 "id": 107,
 "name": "HMS2",
 "status": "created",
 "information": "",
 "address": "",
 "geolocation": null,
 "phone": "",
 "policies": null,
 "email": "",
 "website": "",
 "working_time": null,
 "check_in_time": null,
 "check_out_time": null,
 "note": null,
 "hotel_logo_300": null,
 "tax_number": null,
 "photos": [],
 "header_logo_photos": [],
 "tags": [],
 "quote": null,
 "term_and_condition": null,
 "latitude": null,
 "longitude": null,
 "channel_manager_enabled": false,
 "channel_manager": {
 "enabled": false,
 "otas": [
 {
 "ota_name": "booking.com",
 "beds24_id": null,
 "enabled_sync_allotment": false,
 "enabled_sync_rate": false
 },
 {
 "ota_name": "agoda",
 "beds24_id": null,
 "enabled_sync_allotment": false,
 "enabled_sync_rate": false
 },
 {
 "ota_name": "airbnb",
 "beds24_id": null,
 "enabled_sync_allotment": false,
 "enabled_sync_rate": false
 }
 ],
 "ota_rate_codes": {}
 },
 "logo_image": null,
 "banner_image": null,
 "created_at": "2021-11-13T16:23:50.637+07:00",
 "updated_at": "2021-11-13T16:23:50.637+07:00",
 "beds24_config": {
 "enabled_auto_cancel_reservation_from_cm": true
 },
 "color_profile": {}
 },
 {
 "id": 105,
 "name": "โอมเมดเสตย์",
 "status": "created",
 "information": "dddddddd",
 "address": "127/4 ถ. สุขุมวิท แขวง พระโขนงเหนือ เขตวัฒนา กรุงเทพมหานคร 10110 ประเทศไทย",
 "geolocation": null,
 "phone": "0223232655",
 "policies": null,
 "email": "asdd@asd.com",
 "website": null,
 "working_time": "",
 "check_in_time": "1",
 "check_out_time": "2",
 "note": null,
 "hotel_logo_300": null,
 "tax_number": null,
 "photos": [],
 "header_logo_photos": [],
 "tags": [],
 "quote": "ฟกฟกไฟหกฟกหก",
 "term_and_condition": "344r///ำ  sdfdsf  ",
 "latitude": "13.706704797987564",
 "longitude": "100.60173992067575",
 "channel_manager_enabled": true,
 "channel_manager": {
 "enabled": true,
 "otas": [
 {
 "ota_name": "booking.com",
 "beds24_id": null,
 "enabled_sync_allotment": false,
 "enabled_sync_rate": false
 },
 {
 "ota_name": "agoda",
 "beds24_id": null,
 "enabled_sync_allotment": false,
 "enabled_sync_rate": false
 },
 {
 "ota_name": "airbnb",
 "beds24_id": null,
 "enabled_sync_allotment": false,
 "enabled_sync_rate": false
 }
 ],
 "ota_rate_codes": {
 "ctripRateCode": [
 {
 "code": "C20774025",
 "name": "CTrip"
 },
 {
 "code": "9705762",
 "name": "Standard"
 }
 ],
 "traviaRateCode": [
 {
 "code": "2T0774025",
 "name": "Travia"
 },
 {
 "code": "9705762",
 "name": "Standard"
 }
 ],
 "agodacomRateCode": [
 {
 "code": "A20774025",
 "name": "Agoda"
 },
 {
 "code": "9705762",
 "name": "Standard"
 }
 ],
 "bookingcomRateCode": [
 {
 "code": "20774025",
 "name": "None Refund"
 },
 {
 "code": "9705762",
 "name": "Standard"
 }
 ],
 "expediacomRateCode": [
 {
 "code": "E20774025",
 "name": "Expedia"
 },
 {
 "code": "9705762",
 "name": "Standard"
 }
 ],
 "travelokacomRateCode": [
 {
 "code": "T20774025",
 "name": "Traveloka"
 },
 {
 "code": "9705762",
 "name": "Standard"
 }
 ]
 }
 },
 "logo_image": "https://hms-heroku.s3.ap-southeast-1.amazonaws.com/documents/c3b43969-ac5b-4099-9351-6607cd778475/BFD53D03-8E67-491B-BCF7-45C3D0B8451C.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2I7XJ7WJNRHU7NRV%2F20250225%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20250225T225910Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=9f992ccfa815f6dc5c611c68b57ebb0b4b638f9e4969bec8726833c1a578d227",
 "banner_image": null,
 "created_at": "2019-11-19T17:08:46.877+07:00",
 "updated_at": "2024-05-11T06:13:49.864+07:00",
 "beds24_config": {
 "enabled_auto_cancel_reservation_from_cm": true
 },
 "color_profile": {}
 }
 ]
 */
