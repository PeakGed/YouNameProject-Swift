//
//  Reservation.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//
import Foundation

struct Reservation: Codable {
    let id: Int
    let uid: String
    let status: Status
    let checkInDate: String
    let checkOutDate: String
    let adultNumber: Int
    let extraAdultNumber: Int
    let childNumber: Int
    let contacts: Contacts
    let note: String
    let canceledReason: String?
    let documentPhotos: String?
    let otaBookingId: String
    let relatedReservationId: String?
    let guestComment: String?
    let markers: [String]
    let flags: [String]
    let tags: [String]
    let emoji: String?
    let checkedInAt: String?
    let checkedOutAt: String?
    let canceledAt: String?
    let noShowAt: String?
    let createdAt: String
    let updatedAt: String
    let hotelChannelReservationId: String?
    let confirmationInfo: ConfirmationInfo
    let hotelId: Int
    let creatorId: Int
    let channelId: Int
    let subChannelId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case uid
        case status
        case checkInDate = "check_in_date"
        case checkOutDate = "check_out_date"
        case adultNumber = "adult_number"
        case extraAdultNumber = "extra_adult_number"
        case childNumber = "child_number"
        case contacts
        case note
        case canceledReason = "canceled_reason"
        case documentPhotos = "document_photos"
        case otaBookingId = "ota_booking_id"
        case relatedReservationId = "related_reservation_id"
        case guestComment = "guest_comment"
        case markers
        case flags
        case tags
        case emoji
        case checkedInAt = "checked_in_at"
        case checkedOutAt = "checked_out_at"
        case canceledAt = "canceled_at"
        case noShowAt = "no_showed_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hotelChannelReservationId = "hotel_channel_reservation_id"
        case confirmationInfo = "confirmation_info"
        case hotelId = "hotel_id"
        case creatorId = "creator_id"
        case channelId = "channel_id"
        case subChannelId = "sub_channel_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        uid = try container.decode(String.self, forKey: .uid)
        status = try container.decode(Status.self, forKey: .status)
        checkInDate = try container.decode(String.self, forKey: .checkInDate)
        checkOutDate = try container.decode(String.self, forKey: .checkOutDate)
        adultNumber = try container.decode(Int.self, forKey: .adultNumber)
        extraAdultNumber = try container.decode(Int.self, forKey: .extraAdultNumber)
        childNumber = try container.decode(Int.self, forKey: .childNumber)
        contacts = try container.decode(Contacts.self, forKey: .contacts)
        note = (try? container.decode(String.self, forKey: .note)) ?? ""
        canceledReason = try container.decodeIfPresent(String.self, forKey: .canceledReason)
        documentPhotos = try container.decodeIfPresent(String.self, forKey: .documentPhotos)
        otaBookingId = (try? container.decode(String.self, forKey: .otaBookingId)) ?? ""
        relatedReservationId = try container.decodeIfPresent(String.self, forKey: .relatedReservationId)
        guestComment = try container.decodeIfPresent(String.self, forKey: .guestComment)
        markers = try container.decode([String].self, forKey: .markers)
        flags = try container.decode([String].self, forKey: .flags)
        tags = try container.decode([String].self, forKey: .tags)
        emoji = try container.decodeIfPresent(String.self, forKey: .emoji)
        checkedInAt = try container.decodeIfPresent(String.self, forKey: .checkedInAt)
        checkedOutAt = try container.decodeIfPresent(String.self, forKey: .checkedOutAt)
        canceledAt = try container.decodeIfPresent(String.self, forKey: .canceledAt)
        noShowAt = try container.decodeIfPresent(String.self, forKey: .noShowAt)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
        hotelChannelReservationId = try container.decodeIfPresent(String.self, forKey: .hotelChannelReservationId)
        confirmationInfo = try container.decode(ConfirmationInfo.self, forKey: .confirmationInfo)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        creatorId = try container.decode(Int.self, forKey: .creatorId)
        channelId = try container.decode(Int.self, forKey: .channelId)
        subChannelId = try container.decodeIfPresent(String.self, forKey: .subChannelId)
    }
    
    init(id: Int,
         uid: String,
         status: Status,
         checkInDate: String,
         checkOutDate: String,
         adultNumber: Int,
         extraAdultNumber: Int,
         childNumber: Int,
         contacts: Contacts,
         note: String = "",
         canceledReason: String? = nil,
         documentPhotos: String? = nil,
         otaBookingId: String = "",
         relatedReservationId: String? = nil,
         guestComment: String? = nil,
         markers: [String] = [],
         flags: [String] = [],
         tags: [String] = [],
         emoji: String? = nil,
         checkedInAt: String? = nil,
         checkedOutAt: String? = nil,
         canceledAt: String? = nil,
         noShowAt: String? = nil,
         createdAt: String,
         updatedAt: String,
         hotelChannelReservationId: String? = nil,
         confirmationInfo: ConfirmationInfo,
         hotelId: Int,
         creatorId: Int,
         channelId: Int,
         subChannelId: String? = nil) {
        self.id = id
        self.uid = uid
        self.status = status
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
        self.adultNumber = adultNumber
        self.extraAdultNumber = extraAdultNumber
        self.childNumber = childNumber
        self.contacts = contacts
        self.note = note
        self.canceledReason = canceledReason
        self.documentPhotos = documentPhotos
        self.otaBookingId = otaBookingId
        self.relatedReservationId = relatedReservationId
        self.guestComment = guestComment
        self.markers = markers
        self.flags = flags
        self.tags = tags
        self.emoji = emoji
        self.checkedInAt = checkedInAt
        self.checkedOutAt = checkedOutAt
        self.canceledAt = canceledAt
        self.noShowAt = noShowAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.hotelChannelReservationId = hotelChannelReservationId
        self.confirmationInfo = confirmationInfo
        self.hotelId = hotelId
        self.creatorId = creatorId
        self.channelId = channelId
        self.subChannelId = subChannelId
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(uid, forKey: .uid)
        try container.encode(status, forKey: .status)
        try container.encode(checkInDate, forKey: .checkInDate)
        try container.encode(checkOutDate, forKey: .checkOutDate)
        try container.encode(adultNumber, forKey: .adultNumber)
        try container.encode(extraAdultNumber, forKey: .extraAdultNumber)
        try container.encode(childNumber, forKey: .childNumber)
        try container.encode(contacts, forKey: .contacts)
        try container.encode(note, forKey: .note)
        try container.encodeIfPresent(canceledReason, forKey: .canceledReason)
        try container.encodeIfPresent(documentPhotos, forKey: .documentPhotos)
        try container.encode(otaBookingId, forKey: .otaBookingId)
        try container.encodeIfPresent(relatedReservationId, forKey: .relatedReservationId)
        try container.encodeIfPresent(guestComment, forKey: .guestComment)
        try container.encode(markers, forKey: .markers)
        try container.encode(flags, forKey: .flags)
        try container.encode(tags, forKey: .tags)
        try container.encodeIfPresent(emoji, forKey: .emoji)
        try container.encodeIfPresent(checkedInAt, forKey: .checkedInAt)
        try container.encodeIfPresent(checkedOutAt, forKey: .checkedOutAt)
        try container.encodeIfPresent(canceledAt, forKey: .canceledAt)
        try container.encodeIfPresent(noShowAt, forKey: .noShowAt)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encodeIfPresent(hotelChannelReservationId, forKey: .hotelChannelReservationId)
        try container.encode(confirmationInfo, forKey: .confirmationInfo)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(creatorId, forKey: .creatorId)
        try container.encode(channelId, forKey: .channelId)
        try container.encodeIfPresent(subChannelId, forKey: .subChannelId)
    }
}

extension Reservation {
    
    enum Status: String, Codable ,CaseIterable {
        case booked = "created"
        case checkedIn = "checked_in"
        case checkedOut = "checked_out"
        case confirmed = "confirmed"
        case canceled = "canceled"
        case noShown = "no_showed"
        
        var description: String {
            switch self {
            case .booked:
                return "Booked"
            case .checkedIn:
                return "Checked-in"
            case .checkedOut:
                return "Checked-out"
            case .canceled:
                return "Canceled"
            case .confirmed:
                return "Confirmed"
            case .noShown:
                return "No shown"
            }
        }
        
    }
    
    enum Flag: String, Codable {
        case red = "FLAG_RED"
        case blue = "FLAG_BLUE"
        case orange = "FLAG_ORANGE"
        case yellow = "FLAG_YELLOW"
        case purple = "FLAG_PURPLE"
        case green = "FLAG_GREEN"
        case gray = "FLAG_GRAY"
    }
    
    struct Contacts: Codable {
        let title: String?
        let fullname: String
        let email: String
        let tel: String
        
        enum CodingKeys: String, CodingKey {
            case title
            case fullname
            case email
            case tel
        }
    }
    
    struct ConfirmationInfo: Codable {
        let createdAt: String?
        let remark: String?
        let url: String?
        
        enum CodingKeys: String, CodingKey {
            case createdAt = "created_at"
            case remark
            case url
        }
    }
    
    struct ReservationData: Codable {
        let additionServices: String
        let financeRecords: String
        
        enum CodingKeys: String, CodingKey {
            case additionServices = "addition_services"
            case financeRecords = "finance_records"
        }
    }
}

/* example json
 {
 "id": 512,
 "uid": "rsvt_5la15znqpb30lz5rmqj",
 "status": "checked_out",
 "check_in_date": "2019-11-28",
 "check_out_date": "2019-12-01",
 "adult_number": 1,
 "extra_adult_number": 0,
 "child_number": 0,
 "contacts": {
 "title": null,
 "fullname": "abc",
 "email": "avc@email.com",
 "tel": "1234567890"
 },
 "note": "test",
 "canceled_reason": null,
 "document_photos": null,
 "ota_booking_id": "",
 "related_reservation_id": null,
 "guest_comment": null,
 "markers": [],
 "flags": [],
 "tags": [],
 "emoji": null,
 "checked_in_at": "2019-11-28T13:51:22.214+07:00",
 "checked_out_at": "2020-08-27T21:58:06.587+07:00",
 "canceled_at": null,
 "no_showed_at": null,
 "created_at": "2019-11-28T13:43:02.888+07:00",
 "updated_at": "2020-08-27T21:58:06.595+07:00",
 "hotel_channel_reservation_id": null,
 "confirmation_info": {
 "created_at": null,
 "remark": null,
 "url": null
 },
 "hotel_id": 105,
 "creator_id": 38,
 "channel_id": 9,
 "sub_channel_id": null
 },
 {
 "id": 528,
 "uid": "rsvt_5la15zp03yyhsxbvsl5",
 "status": "checked_out",
 "check_in_date": "2020-01-21",
 "check_out_date": "2020-01-22",
 "adult_number": 1,
 "extra_adult_number": 0,
 "child_number": 0,
 "contacts": {
 "title": null,
 "fullname": "test",
 "email": "",
 "tel": ""
 },
 "note": "",
 "canceled_reason": null,
 "document_photos": null,
 "ota_booking_id": "",
 "related_reservation_id": null,
 "guest_comment": null,
 "markers": [],
 "flags": [],
 "tags": [],
 "emoji": null,
 "checked_in_at": "2020-01-21T12:04:47.827+07:00",
 "checked_out_at": "2020-02-01T16:15:17.793+07:00",
 "canceled_at": null,
 "no_showed_at": null,
 "created_at": "2020-01-21T12:01:19.993+07:00",
 "updated_at": "2020-02-01T16:15:17.797+07:00",
 "hotel_channel_reservation_id": null,
 "confirmation_info": {
 "created_at": null,
 "remark": null,
 "url": null
 },
 "hotel_id": 105,
 "creator_id": 38,
 "channel_id": 8,
 "sub_channel_id": null
 }
 */
