//  FolioFormServiceRequest.swift
//  YourProject
//
//  Created by IntrodexMini on 13/6/2568 BE.
//
import Foundation

struct FolioFormServiceRequest {
    typealias FetchById = ByID    
    typealias CancelFolioForm = ByID
    typealias PreviewEmail = ByID
    typealias PreviewPDF = ByID
    typealias ExportPDF = ByID
    typealias ExportImage = ByID

    struct ByID { let id: Int }

    struct FetchByHotel: Encodable {
        let hotelId: Int
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?
        
        var parameters: [String: Any]? {
            var dict: [String: Any] = ["hotel_id": hotelId]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }

            if dict.isEmpty { return nil }

            return dict
        }
    }
    
    struct FetchByQuery: Encodable {
        let hotelId: Int
        let query: String
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?

        var parameters: [String: Any]? {
            var dict: [String: Any] = ["hotel_id": hotelId, "query": query]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }

            if dict.isEmpty { return nil }

            return dict
        }
    }
    
    struct FetchByPeriod: Encodable {
        let hotelId: Int
        let startDate: String
        let endDate: String
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?

        var parameters: [String: Any]? {
            var dict: [String: Any] = ["hotel_id": hotelId, "start_date": startDate, "end_date": endDate]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }

            if dict.isEmpty { return nil }

            return dict
        }
    }
    
    struct FetchByReservation: Encodable {
        let hotelId: Int
        let reservationId: Int
        let page: Int?
        let perPage: Int?
        let sortedBy: String?
        let sortedOrder: String?

        var parameters: [String: Any]? {
            var dict: [String: Any] = ["hotel_id": hotelId, "reservation_id": reservationId]
            if let page = page { dict["page"] = page }
            if let perPage = perPage { dict["per_page"] = perPage }
            if let sortedBy = sortedBy { dict["sorted_by"] = sortedBy }
            if let sortedOrder = sortedOrder { dict["sorted_order"] = sortedOrder }

            if dict.isEmpty { return nil }

            return dict
        }
    }    
    
    struct CreateFolioFormReservation: Encodable {
       /*
        {
          "hotel_id": 1,
          "hotel_contact_id": "<integer>",
          "customer_contact_id": "<integer>",
          "vat_included": "<boolean>",
          "remark": "<string>",
          "internal_note": "<string>",
          "payment_info": "<string>",
          "group_room_charge": "<boolean>",
          "group_additional_item": "<boolean>"
        }
        */

        let hotelId: Int
        let hotelContactId: Int
        let customerContactId: Int
        let vatIncluded: Bool
        let remark: String?
        let internalNote: String?
        let paymentInfo: String
        let groupRoomCharge: Bool
        let groupAdditionalItem: Bool

        var body: Data? {
            return try? JSONEncoder().encode(self)
        }

        init(hotelId: Int,
         hotelContactId: Int, 
         customerContactId: Int,
          vatIncluded: Bool, 
          remark: String?,
           internalNote: String?,
            paymentInfo: String, 
            groupRoomCharge: Bool, 
            groupAdditionalItem: Bool) {
            self.hotelId = hotelId
            self.hotelContactId = hotelContactId
            self.customerContactId = customerContactId
            self.vatIncluded = vatIncluded
            self.remark = remark
            self.internalNote = internalNote
            self.paymentInfo = paymentInfo
            self.groupRoomCharge = groupRoomCharge
            self.groupAdditionalItem = groupAdditionalItem
        }

       enum CodingKeys: String, CodingKey {
        case hotelId = "hotel_id"
        case hotelContactId = "hotel_contact_id"
        case customerContactId = "customer_contact_id"
        case vatIncluded = "vat_included"
        case remark = "remark"
        case internalNote = "internal_note"
        case paymentInfo = "payment_info"
        case groupRoomCharge = "group_room_charge"
        case groupAdditionalItem = "group_additional_item"
       }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(hotelId, forKey: .hotelId)
            try container.encode(hotelContactId, forKey: .hotelContactId)
            try container.encode(customerContactId, forKey: .customerContactId)
            try container.encode(vatIncluded, forKey: .vatIncluded)
            try container.encodeIfPresent(remark, forKey: .remark)
            try container.encodeIfPresent(internalNote, forKey: .internalNote)
            try container.encode(paymentInfo, forKey: .paymentInfo)
            try container.encode(groupRoomCharge, forKey: .groupRoomCharge)
            try container.encode(groupAdditionalItem, forKey: .groupAdditionalItem)
        }
       
    }
    
    struct UpdateFolioForm: Encodable {
       /*
       {
  "hotel_contact_id": "<integer>",
  "customer_contact_id": "<integer>",
  "remark": "<string>",
  "internal_note": "<string>",
  "payment_info": "<string>",
  "group_room_charge": "<boolean>",
  "group_additional_item": "<boolean>"
}
*/
        let id: Int
        let hotelContactId: Int?
        let customerContactId: Int?
        let remark: String?
        let internalNote: String?
        let paymentInfo: String?
        let groupRoomCharge: Bool?
        let groupAdditionalItem: Bool?

        var body: Data? {
            return try? JSONEncoder().encode(self)
        }

        init(id: Int, 
        hotelContactId: Int, 
        customerContactId: Int, 
        remark: String?, 
        internalNote: String?, 
        paymentInfo: String?, 
        groupRoomCharge: Bool?, 
        groupAdditionalItem: Bool?) {
            self.id = id
            self.hotelContactId = hotelContactId
            self.customerContactId = customerContactId
            self.remark = remark
            self.internalNote = internalNote
            self.paymentInfo = paymentInfo
            self.groupRoomCharge = groupRoomCharge
            self.groupAdditionalItem = groupAdditionalItem
            }

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case hotelContactId = "hotel_contact_id"
            case customerContactId = "customer_contact_id"
            case remark = "remark"
            case internalNote = "internal_note"
            case paymentInfo = "payment_info"
            case groupRoomCharge = "group_room_charge"
            case groupAdditionalItem = "group_additional_item"
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)            
            try container.encodeIfPresent(hotelContactId, forKey: .hotelContactId)
            try container.encodeIfPresent(customerContactId, forKey: .customerContactId)
            try container.encodeIfPresent(remark, forKey: .remark)
            try container.encodeIfPresent(internalNote, forKey: .internalNote)
            try container.encodeIfPresent(paymentInfo, forKey: .paymentInfo)
            try container.encodeIfPresent(groupRoomCharge, forKey: .groupRoomCharge)
            try container.encodeIfPresent(groupAdditionalItem, forKey: .groupAdditionalItem)
            try container.encodeIfPresent(remark, forKey: .remark)            
        }
    }
    
} 
