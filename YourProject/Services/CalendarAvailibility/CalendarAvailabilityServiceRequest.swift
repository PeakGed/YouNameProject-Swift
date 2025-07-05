//
//  CalendarAvailabilityServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 14/6/2568 BE.
//
import Foundation

struct CalendarAvailabilityServiceRequest {
    
    struct FetchAvailability: Encodable {
        let hotelId: String
        let checkInDate: Date
        let checkOutDate: Date
        let roomIds: [Int]?
        
        var parameters: [String: Any]? {
            guard let data = try? JSONEncoder().encode(self),
                  let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return dict
        }
        
        enum CodingKeys: String, CodingKey {
            case hotelId = "hotel_id"
            case checkInDate = "check_in_date"
            case checkOutDate = "check_out_date"
            case roomIds = "room_ids"
        }
        
        init(hotelId: String,
             checkInDate: Date,
             checkOutDate: Date,
             roomIds: [Int]? = nil) {
            self.hotelId = hotelId
            self.checkInDate = checkInDate
            self.checkOutDate = checkOutDate
            self.roomIds = roomIds
        }
        
        init(hotelId: String,
             period: PeriodDate,
             roomIds: [Int]? = nil) {
            self.hotelId = hotelId
            self.checkInDate = period.start
            self.checkOutDate = period.end
            self.roomIds = roomIds
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            let dateFormat = FormConfig.DateFormat.yyyyMMdd
            try container.encode(checkInDate.toDateString(dateFormat), forKey: .checkInDate)
            try container.encode(checkOutDate.toDateString(dateFormat), forKey: .checkOutDate)
            
            if let roomIds = roomIds, !roomIds.isEmpty {
                let roomIdsString = roomIds.map { String($0) }.joined(separator: ",")
                try container.encode(roomIdsString, forKey: .roomIds)
            }
        }
    }
} 