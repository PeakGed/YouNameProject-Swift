//
//  NotificationItem.swift
//  YourProject
//
//  Created by IntrodexMac on 11/6/2568 BE.
//

import Foundation

struct NotificationItem: Codable {
    let id: Int
    let notificationType: NotificationType
    let checkInDate: Date
    let checkOutDate: Date
    let notifiableId: Int
    let notifiableType: ItemKind
    let readed: Bool
    let readedAt: Date?
    let channelId: Int?
    let subChannelId: Int?
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case notificationType = "notification_type"
        case checkInDate = "check_in_date"
        case checkOutDate = "check_out_date"
        case notifiableId = "notifiable_id"
        case notifiableType = "notifiable_type"
        case readed
        case readedAt = "readed_at"
        case channelId = "channel_id"
        case subChannelId = "sub_channel_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    init(id: Int,
    notificationType: NotificationType,
     checkInDate: Date,
      checkOutDate: Date, 
      notifiableId: Int,
       notifiableType: ItemKind, 
       readed: Bool, 
       readedAt: Date?,
        channelId: Int?,
         subChannelId: Int?, 
         createdAt: Date,
          updatedAt: Date) {
        self.id = id
        self.notificationType = notificationType
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
        self.notifiableId = notifiableId
        self.notifiableType = notifiableType
        self.readed = readed
        self.readedAt = readedAt
        self.channelId = channelId
        self.subChannelId = subChannelId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        notificationType = try container.decode(NotificationType.self, forKey: .notificationType)
        
        let dateFormat = FormConfig.DateFormat.yyyyMMdd
        checkInDate = try container.decode(String.self, forKey: .checkInDate).tryToDate(dateFormat: dateFormat)
        checkOutDate = try container.decode(String.self, forKey: .checkOutDate).tryToDate(dateFormat: dateFormat)
        
        notifiableId = try container.decode(Int.self, forKey: .notifiableId)
        notifiableType = try container.decode(ItemKind.self, forKey: .notifiableType)
        readed = try container.decode(Bool.self, forKey: .readed)
        
        let isoFormat = FormConfig.DateFormat.datetimeISO
        readedAt = try container.decodeIfPresent(String.self, forKey: .readedAt)?.tryToDate(dateFormat: isoFormat)
        channelId = try container.decodeIfPresent(Int.self, forKey: .channelId)
        subChannelId = try container.decodeIfPresent(Int.self, forKey: .subChannelId)
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: isoFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: isoFormat)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(notificationType.rawValue, forKey: .notificationType)
        
        let dateFormat = FormConfig.DateFormat.yyyyMMdd
        try container.encodeIfPresent(checkInDate.toDateString(dateFormat), forKey: .checkInDate)
        try container.encodeIfPresent(checkOutDate.toDateString(dateFormat), forKey: .checkOutDate)
        
        try container.encode(notifiableId, forKey: .notifiableId)
        try container.encode(notifiableType.rawValue, forKey: .notifiableType)
        try container.encode(readed, forKey: .readed)
        
        let isoFormat = FormConfig.DateFormat.datetimeISO
        try container.encodeIfPresent(readedAt?.toDateString(isoFormat), forKey: .readedAt)
        try container.encodeIfPresent(channelId, forKey: .channelId)
        try container.encodeIfPresent(subChannelId, forKey: .subChannelId)
        try container.encode(createdAt.toDateString(isoFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(isoFormat), forKey: .updatedAt)
    }
}

extension NotificationItem {
    
    public enum NotificationType: String, Decodable {
        case newCmBooking = "new_cm_booking"
        case updatedCmBooking = "cm_booking_was_updated"
        case cancelledCmBooking = "cm_booking_was_cancelled"
        
        case newHmsReservation = "new_hms_reservation"
        case updatedHmsReservation = "hms_reservation_was_updated"
        case cancelledHmsReservation = "hms_reservation_was_cancelled"
    }
    
    enum ItemKind: String, Decodable {
        case reservation = "Reservation"
        case cmBooking = "CmBooking"
        
    }
}


/*
 {
     "items": [
         {
             "id": 3560,
             "notification_type": "new_cm_booking",
             "check_in_date": null,
             "check_out_date": null,
             "first_night_date": "2024-05-31",
             "last_night_date": "2024-05-31",
             "notifiable_id": 83,
             "notifiable_type": "CmBooking",
             "channel_name": null,
             "sub_channel_name": null,
             "readed": true,
             "readed_at": "2024-06-09T07:43:44.953Z",
             "data": {},
             "created_at": "2024-05-23T08:32:02.592+07:00",
             "updated_at": "2024-06-03T15:43:19.014+07:00"
         },
         {
             "id": 3566,
             "notification_type": "new_hms_reservation",
             "check_in_date": "2024-05-14",
             "check_out_date": "2024-05-15",
             "first_night_date": null,
             "last_night_date": null,
             "notifiable_id": 1089,
             "notifiable_type": "Reservation",
             "channel_name": "Online Travel Agent (OTA)",
             "sub_channel_name": "Beds24",
             "readed": true,
             "readed_at": "2024-06-09T07:43:44.953Z",
             "data": {},
             "created_at": "2024-05-23T08:56:25.854+07:00",
             "updated_at": "2024-06-03T15:43:19.052+07:00"
         },
         {
             "id": 3571,
             "notification_type": "new_hms_reservation",
             "check_in_date": "2020-01-16",
             "check_out_date": "2020-01-18",
             "first_night_date": null,
             "last_night_date": null,
             "notifiable_id": 1090,
             "notifiable_type": "Reservation",
             "channel_name": "Online Travel Agent (OTA)",
             "sub_channel_name": "Beds24",
             "readed": true,
             "readed_at": "2024-06-09T07:43:25.871Z",
             "data": {},
             "created_at": "2024-05-23T08:56:47.632+07:00",
             "updated_at": "2024-06-03T15:43:19.056+07:00"
         }
         {
             "id": 3591,
             "notification_type": "new_cm_booking",
             "check_in_date": null,
             "check_out_date": null,
             "first_night_date": "2024-06-14",
             "last_night_date": "2024-06-14",
             "notifiable_id": 85,
             "notifiable_type": "CmBooking",
             "channel_name": null,
             "sub_channel_name": null,
             "readed": false,
             "readed_at": null,
             "data": {
                 "bookId": "56138458",
                 "roomId": "232710",
                 "unitId": "1",
                 "roomQty": "1",
                 "status": "2",
                 "substatus": "0",
                 "firstNight": "2024-06-14",
                 "lastNight": "2024-06-14",
                 "numAdult": "2",
                 "numChild": "0",
                 "guestTitle": "",
                 "guestFirstName": "Ingrid",
                 "guestName": "Tufts",
                 "guestEmail": "",
                 "guestPhone": "",
                 "guestMobile": "",
                 "guestFax": "",
                 "guestCompany": "",
                 "guestAddress": "",
                 "guestCity": "",
                 "guestState": "",
                 "guestPostcode": "",
                 "guestCountry": "",
                 "guestCountry2": "",
                 "guestArrivalTime": "",
                 "guestVoucher": "",
                 "guestComments": "",
                 "notes": "",
                 "message": "",
                 "groupNote": "",
                 "custom1": "",
                 "custom2": "",
                 "custom3": "",
                 "custom4": "",
                 "custom5": "",
                 "custom6": "",
                 "custom7": "",
                 "custom8": "",
                 "custom9": "",
                 "custom10": "",
                 "flagColor": "",
                 "flagText": "",
                 "statusCode": "0",
                 "lang": "",
                 "price": "3500.00",
                 "deposit": "0.00",
                 "tax": "0.00",
                 "commission": "0.00",
                 "currency": "THB",
                 "rateDescription": "2024-06-14 Rate (41477992) THB 3500\r\n",
                 "offerId": "0",
                 "referer": "homemadestay",
                 "refererEditable": "Booking.com",
                 "reference": "",
                 "apiSource": "0",
                 "apiReference": "",
                 "apiMessage": "Imported booking summary\r\nroom meal_plan=อาหารเช้ารวมในราคาห้องพัก",
                 "allowChannelUpdate": "1",
                 "allowAutoAction": "1",
                 "allowReview": "1",
                 "cancelUntil": "-1",
                 "stripeToken": "",
                 "propId": "102230",
                 "ownerId": "56401",
                 "invoiceeId": "",
                 "bookingTime": "2024-06-09 08:02:22",
                 "modified": "2024-06-09 08:02:52",
                 "cancelTime": "",
                 "masterId": "",
                 "invoiceNumber": "",
                 "invoiceDate": "",
                 "invoice": [
                     {
                         "invoiceId": "94821838",
                         "description": "Duluxe Room Friday, 14 June, 2024 - Saturday, 15 June, 2024",
                         "status": "",
                         "qty": "1",
                         "price": "3500.00",
                         "vatRate": "0.00",
                         "type": "8",
                         "type2": "0",
                         "invoiceeId": "",
                         "createBy": "56401",
                         "createTime": "2024-06-09 08:02:22"
                     }
                 ],
                 "infoItems": []
             },
             "created_at": "2024-06-09T15:03:03.123+07:00",
             "updated_at": "2024-06-09T15:03:03.123+07:00"
         }
     ],
     "total_items": 5,
     "total_pages": 1,
     "per_page": 20,
     "page": 1
 }
 */
