//
//  CMCalendarItem.swift
//  YourProject
//
//  Created by IntrodexMini on 9/7/2568 BE.
//

import Foundation

struct CMCalendarItem: Codable {
    let date: Date
    let reservedType: ReservedType
    let reservedTypeId: Int
    let checkInDate: Date
    let checkOutDate: Date
    let cmBookingId: Int
    let cmBookingStatus: String
    let unitCount: Int
    let reservationId: Int
    
    enum CodingKeys: String, CodingKey {
        case date
        case reservedType = "reserved_type"
        case reservedTypeId = "reserved_type_id"
        case checkInDate = "check_in_date"
        case checkOutDate = "check_out_date"
        case cmBookingId = "cm_booking_id"
        case cmBookingStatus = "cm_booking_status"
        case unitCount = "unit_count"
        case reservationId = "reservation_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dateFormat = FormConfig.DateFormat.yyyyMMdd
        date = try container.decode(String.self, forKey: .date).tryToDate(dateFormat: dateFormat)
        reservedType = try container.decode(ReservedType.self, forKey: .reservedType)
        reservedTypeId = try container.decode(Int.self, forKey: .reservedTypeId)
        checkInDate = try container.decode(String.self, forKey: .checkInDate).tryToDate(dateFormat: dateFormat)
        checkOutDate = try container.decode(String.self, forKey: .checkOutDate).tryToDate(dateFormat: dateFormat)
        cmBookingId = try container.decode(Int.self, forKey: .cmBookingId)
        cmBookingStatus = try container.decode(String.self, forKey: .cmBookingStatus)
        unitCount = try container.decode(Int.self, forKey: .unitCount)
        reservationId = try container.decode(Int.self, forKey: .reservationId)
    }
    
    init(date: Date,
         reservedType: ReservedType,
         reservedTypeId: Int,
         checkInDate: Date,
         checkOutDate: Date,
         cmBookingId: Int,
         cmBookingStatus: String,
         unitCount: Int,
         reservationId: Int) {
        self.date = date
        self.reservedType = reservedType
        self.reservedTypeId = reservedTypeId
        self.checkInDate = checkInDate
        self.checkOutDate = checkOutDate
        self.cmBookingId = cmBookingId
        self.cmBookingStatus = cmBookingStatus
        self.unitCount = unitCount
        self.reservationId = reservationId
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        let dateFormat = FormConfig.DateFormat.yyyyMMdd
        try container.encode(date.toDateString(dateFormat), forKey: .date)
        try container.encode(reservedType.rawValue, forKey: .reservedType)
        try container.encode(reservedTypeId, forKey: .reservedTypeId)
        try container.encode(checkInDate.toDateString(dateFormat), forKey: .checkInDate)
        try container.encode(checkOutDate.toDateString(dateFormat), forKey: .checkOutDate)
        try container.encode(cmBookingId, forKey: .cmBookingId)
        try container.encode(cmBookingStatus, forKey: .cmBookingStatus)
        try container.encode(unitCount, forKey: .unitCount)
        try container.encode(reservationId, forKey: .reservationId)
    }
}

extension CMCalendarItem {
  enum ReservedType: String, Codable {
    case roomType = "ROOM_TYPE"
    case room = "ROOM"
  }
}

/* Example JSON Response:
 {
   "date": "2024-05-13",
   "reserved_type": "RoomType",
   "reserved_type_id": 179,
   "check_in_date": "2024-05-13",
   "check_out_date": "2024-05-14",
   "cm_booking_id": 76,
   "cm_booking_status": "2",
   "unit_count": 1,
   "reservation_id": 1081
 }
 */
