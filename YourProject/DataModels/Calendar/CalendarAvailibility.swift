//
//  Availibility.swift
//  YourProject
//
//  Created by IntrodexMini on 5/7/2568 BE.
//
import Foundation

struct CalendarAvailability: Codable {
    let availableRoomTypes: [AvailableRoomType]
    
    enum CodingKeys: String, CodingKey {
        case availableRoomTypes = "available_room_types"
    }
    
    init(availableRoomTypes: [AvailableRoomType]) {
        self.availableRoomTypes = availableRoomTypes
    }
}

extension CalendarAvailability {
    struct AvailableRoomType: Codable {
        let id: Int
        let name: String
        let description: String
        let limitedNumberOfCmUnits: Int?
        let order: Int
        let hotelId: Int
        let availableRooms: [Int]
        let availableDates: [AvailableDate]
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case description
            case limitedNumberOfCmUnits = "limited_number_of_cm_units"
            case order
            case hotelId = "hotel_id"
            case availableRooms = "available_rooms"
            case availableDates = "available_dates"
        }
        
        init(id: Int,
             name: String,
             description: String,
             limitedNumberOfCmUnits: Int?,
             order: Int,
             hotelId: Int,
             availableRooms: [Int],
             availableDates: [AvailableDate]) {
            self.id = id
            self.name = name
            self.description = description
            self.limitedNumberOfCmUnits = limitedNumberOfCmUnits
            self.order = order
            self.hotelId = hotelId
            self.availableRooms = availableRooms
            self.availableDates = availableDates
        }
    }
    
    struct AvailableDate: Codable {
        let date: Date
        let hmsUnselectedReservedCount: Int
        let hmsSelectedReservedCount: Int
        let hmsReservedCount: Int
        let cmReservedCount: Int
        let availableUnitCount: Int
        let unavailableUnitCount: Int
        let blackoutUnitCount: Int
        let totalUnits: Int
        
        enum CodingKeys: String, CodingKey {
            case date
            case hmsUnselectedReservedCount = "hms_unselected_reserved_count"
            case hmsSelectedReservedCount = "hms_selected_reserved_count"
            case hmsReservedCount = "hms_reserved_count"
            case cmReservedCount = "cm_reserved_count"
            case availableUnitCount = "available_unit_count"
            case unavailableUnitCount = "unavailable_unit_count"
            case blackoutUnitCount = "blackout_unit_count"
            case totalUnits = "total_units"
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let dateFormat = FormConfig.DateFormat.yyyyMMdd
            date = try container.decode(String.self, forKey: .date).tryToDate(dateFormat: dateFormat)
            hmsUnselectedReservedCount = try container.decode(Int.self, forKey: .hmsUnselectedReservedCount)
            hmsSelectedReservedCount = try container.decode(Int.self, forKey: .hmsSelectedReservedCount)
            hmsReservedCount = try container.decode(Int.self, forKey: .hmsReservedCount)
            cmReservedCount = try container.decode(Int.self, forKey: .cmReservedCount)
            availableUnitCount = try container.decode(Int.self, forKey: .availableUnitCount)
            unavailableUnitCount = try container.decode(Int.self, forKey: .unavailableUnitCount)
            blackoutUnitCount = try container.decode(Int.self, forKey: .blackoutUnitCount)
            totalUnits = try container.decode(Int.self, forKey: .totalUnits)
        }
        
        init(date: Date,
             hmsUnselectedReservedCount: Int,
             hmsSelectedReservedCount: Int,
             hmsReservedCount: Int,
             cmReservedCount: Int,
             availableUnitCount: Int,
             unavailableUnitCount: Int,
             blackoutUnitCount: Int,
             totalUnits: Int) {
            self.date = date
            self.hmsUnselectedReservedCount = hmsUnselectedReservedCount
            self.hmsSelectedReservedCount = hmsSelectedReservedCount
            self.hmsReservedCount = hmsReservedCount
            self.cmReservedCount = cmReservedCount
            self.availableUnitCount = availableUnitCount
            self.unavailableUnitCount = unavailableUnitCount
            self.blackoutUnitCount = blackoutUnitCount
            self.totalUnits = totalUnits
        }
    }
}

/*
 {
   "available_room_types": [
     {
       "id": 179,
       "name": "Duluxe Room",
       "description": "test description",
       "limited_number_of_cm_units": null,
       "order": 0,
       "hotel_id": 105,
       "available_rooms": [642, 625, 621, 620], //filter only AVAILABLE ROOM
       "available_dates": [
         {
           "date": "2020-01-01",
           "hms_unselected_reserved_count": 0,
           "hms_selected_reserved_count": 0,
           "hms_reserved_count": 0,
           "cm_reserved_count": 0,
           "available_unit_count": 4,
           "unavailable_unit_count": 0,
           "blackout_unit_count": 0,
           "total_units": 4
         },
         {
           "date": "2020-01-02",
           "hms_unselected_reserved_count": 0,
           "hms_selected_reserved_count": 0,
           "hms_reserved_count": 0,
           "cm_reserved_count": 0,
           "available_unit_count": 4,
           "unavailable_unit_count": 0,
           "blackout_unit_count": 0,
           "total_units": 4
         },
         {
           "date": "2020-01-03",
           "hms_unselected_reserved_count": 0,
           "hms_selected_reserved_count": 0,
           "hms_reserved_count": 0,
           "cm_reserved_count": 0,
           "available_unit_count": 4,
           "unavailable_unit_count": 0,
           "blackout_unit_count": 0,
           "total_units": 4
         }
       ]
     } , {...}
   ]
 }

 
 */
