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
    let checkInDate: Date
    let checkOutDate: Date
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
    let flags: [Flag]
    let tags: [String]
    let emoji: String?
    
    let hotelChannelReservationId: Int?
    let confirmationInfo: ConfirmationInfo
    let hotelId: Int
    let creatorId: Int
    let channelId: Int
    let subChannelId: Int?

    let checkedInAt: Date?
    let checkedOutAt: Date?
    let canceledAt: Date?
    let noShowAt: Date?
    let createdAt: Date
    let updatedAt: Date
    
    lazy var period: PeriodDate = {
        .init(start: checkInDate,
              end: checkOutDate)
    }()
    
    lazy var checkInDateText: String = {
        checkInDate.toDateString(FormConfig.DateFormat.yyyyMMdd)
    }()
    
    lazy var checkOutDateText: String = {
        checkOutDate.toDateString(FormConfig.DateFormat.yyyyMMdd)
    }()
        
    // roomIDs
//    var uniqueUnitIDs: Set<Int> {
//        items.bedIDs.union(items.roomIDs)
//    }
    
    // MARK:- Status flag

//    var isExistCustomer: Bool {
//        guests.count > 0
//    }
    var numberOfNight: Int {
        checkInDate.numberOfDaysUntilDateTime(checkOutDate)
    }
    
    var selectedFlag: Flag? {
        flags.first
    }
    
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
        case hotelChannelReservationId = "hotel_channel_reservation_id"
        case confirmationInfo = "confirmation_info"
        case hotelId = "hotel_id"
        case creatorId = "creator_id"
        case channelId = "channel_id"
        case subChannelId = "sub_channel_id"
        case checkedInAt = "checked_in_at"
        case checkedOutAt = "checked_out_at"
        case canceledAt = "canceled_at"
        case noShowAt = "no_showed_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        uid = try container.decode(String.self, forKey: .uid)
        status = try container.decode(Status.self, forKey: .status)
        checkInDate = try container.decode(String.self, forKey: .checkInDate).tryToDate(dateFormat: FormConfig.DateFormat.yyyyMMdd)
        checkOutDate = try container.decode(String.self, forKey: .checkOutDate).tryToDate(dateFormat: FormConfig.DateFormat.yyyyMMdd)
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
        markers = (try? container.decode([String].self, forKey: .markers)) ?? []
        flags = (try? container.decode([Flag].self, forKey: .flags)) ?? []
        tags = (try? container.decode([String].self, forKey: .tags)) ?? []
        emoji = try container.decodeIfPresent(String.self, forKey: .emoji)
        
        hotelChannelReservationId = try container.decodeIfPresent(Int.self, forKey: .hotelChannelReservationId)
        confirmationInfo = try container.decode(ConfirmationInfo.self, forKey: .confirmationInfo)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        creatorId = try container.decode(Int.self, forKey: .creatorId)
        channelId = try container.decode(Int.self, forKey: .channelId)
        subChannelId = try container.decodeIfPresent(Int.self, forKey: .subChannelId)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        checkedInAt = try container.decodeIfPresent(String.self, forKey: .checkedInAt)?.tryToDate(dateFormat: dateFormat)
        checkedOutAt = try container.decodeIfPresent(String.self, forKey: .checkedOutAt)?.tryToDate(dateFormat: dateFormat)
        canceledAt = try container.decodeIfPresent(String.self, forKey: .canceledAt)?.tryToDate(dateFormat: dateFormat)
        noShowAt = try container.decodeIfPresent(String.self, forKey: .noShowAt)?.tryToDate(dateFormat: dateFormat)
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
    }
    
    init(id: Int,
         uid: String,
         status: Status,
         checkInDate: Date,
         checkOutDate: Date,
         adultNumber: Int = 2,
         extraAdultNumber: Int = 0,
         childNumber: Int = 0,
         contacts: Contacts = .init(),
         note: String = "",
         canceledReason: String? = nil,
         documentPhotos: String? = nil,
         otaBookingId: String = "",
         relatedReservationId: String? = nil,
         guestComment: String? = nil,
         markers: [String] = [],
         flags: [Flag] = [],
         tags: [String] = [],
         emoji: String? = nil,         
         hotelChannelReservationId: Int? = nil,
         confirmationInfo: ConfirmationInfo = .init(),
         hotelId: Int,
         creatorId: Int,
         channelId: Int,
         subChannelId: Int? = nil,
         checkedInAt: Date? = nil,
         checkedOutAt: Date? = nil,
         canceledAt: Date? = nil,
         noShowAt: Date? = nil,
         createdAt: Date,
         updatedAt: Date) {
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
    
    func isStatus(status: Reservation.Status) -> Bool {
        return self.status == status
    }
    
    func isStatuses(statuses: [Reservation.Status]) -> Bool {
        return statuses.contains(self.status)
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
        try container.encodeIfPresent(hotelChannelReservationId, forKey: .hotelChannelReservationId)
        try container.encode(confirmationInfo, forKey: .confirmationInfo)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(creatorId, forKey: .creatorId)
        try container.encode(channelId, forKey: .channelId)
        try container.encodeIfPresent(subChannelId, forKey: .subChannelId)

        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encodeIfPresent(checkedInAt?.toDateString(dateFormat), forKey: .checkedInAt)
        try container.encodeIfPresent(checkedOutAt?.toDateString(dateFormat), forKey: .checkedOutAt)
        try container.encodeIfPresent(canceledAt?.toDateString(dateFormat), forKey: .canceledAt)
        try container.encodeIfPresent(noShowAt?.toDateString(dateFormat), forKey: .noShowAt)        
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
    }
}

extension Reservation {
    
    enum FilterBy {
        case id(id: Int)
        case ids(ids: [Int])
        case keyword(q: String)
        case guestId(id: Int)
        case roomId(id: Int)
        case status(status: Reservation.Status)
        case statuses(statuses: [Reservation.Status])
        
        case date(date: Date)
        case checkInDate(date: Date)
        case staythroughDate(date: Date)
        case checkOutDate(date: Date)
        
        case arrivalToday(date: Date)
        case departureToday(date: Date)
        case overCheckIn(date: Date)
        case beforeCheckIn(date: Date)
        case bookingChannel(channel: ChannelWithSubChannel)
        case bookingChannels(channels: [ChannelWithSubChannel])
        
    }
    
    enum SortBy {
        case id
        case contactNameAlphabet
        case status
        case totalCost
        case totalPaid
        case remainCost
        case nightCount
        case checkInDate
        case checkOutDate
        case createdAt
        case updatedAt
    }
    
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
        
        init(title: String? = nil,
             fullname: String = "",
             email: String = "",
             tel: String = "") {
            self.title = title
            self.fullname = fullname
            self.email = email
            self.tel = tel
        }
        
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
        
        init(createdAt: String? = nil,
             remark: String? = nil,
             url: String? = nil) {
            self.createdAt = createdAt
            self.remark = remark
            self.url = url
        }
        
        enum CodingKeys: String, CodingKey {
            case createdAt = "created_at"
            case remark
            case url
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
