//
//  Folio.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//
import Foundation

struct Folio: Codable {
   
    let id: Int
    let name: String
    let amount: Double
    let amountBeforeVat: Double
    let vatAmount: Double
    let barcode: String?
    let code: String?
    let categoryId: Int?
    let status: String
    let description: String
    let vatIncluded: Bool
    let createdAt: Date
    let updatedAt: Date
    let hotelId: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case amount
        case amountBeforeVat = "amount_before_vat"
        case vatAmount = "vat_amount"
        case barcode
        case code
        case categoryId = "category_id"
        case status
        case description
        case vatIncluded = "vat_included"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hotelId = "hotel_id"
    }
    
    init(id: Int,
         name: String,
         amount: Double,
         amountBeforeVat: Double,
         vatAmount: Double,
         barcode: String? = nil,
         code: String? = nil,
         categoryId: Int? = nil,
         status: String,
         description: String,
         vatIncluded: Bool,
         hotelId: Int,
         createdAt: Date,
         updatedAt: Date) {
        self.id = id
        self.name = name
        self.amount = amount
        self.amountBeforeVat = amountBeforeVat
        self.vatAmount = vatAmount
        self.barcode = barcode
        self.code = code
        self.categoryId = categoryId
        self.status = status
        self.description = description
        self.vatIncluded = vatIncluded
        self.hotelId = hotelId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        amount = try container.decode(String.self, forKey: .amount).trytoDouble()
        amountBeforeVat = try container.decode(String.self, forKey: .amountBeforeVat).trytoDouble()
        vatAmount = try container.decode(String.self, forKey: .vatAmount).trytoDouble()
        barcode = try container.decodeIfPresent(String.self, forKey: .barcode)
        code = try container.decodeIfPresent(String.self, forKey: .code)
        categoryId = try container.decodeIfPresent(Int.self, forKey: .categoryId)
        status = try container.decode(String.self, forKey: .status)
        description = (try? container.decode(String.self, forKey: .description)) ?? ""
        vatIncluded = try container.decode(Bool.self, forKey: .vatIncluded)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
    }

    //encode
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(amount.toString(), forKey: .amount)
        try container.encode(amountBeforeVat.toString(), forKey: .amountBeforeVat)
        try container.encode(vatAmount.toString(), forKey: .vatAmount)
        try container.encode(barcode, forKey: .barcode)
        try container.encode(code, forKey: .code)
        try container.encode(categoryId, forKey: .categoryId)
        try container.encode(status, forKey: .status)
        try container.encode(description, forKey: .description)
        try container.encode(vatIncluded, forKey: .vatIncluded)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(createdAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .updatedAt)
    }

}

extension Folio {
    
    enum FilterBy {
        case id(id: Int)
        case name(name: String)
        case status(status: Status)
    }
    
    enum SortBy {
        case id
        case name
        case amount
        case createdAt
        case updatedAt
    }
    
    enum Status: String, Codable {
        case created = "created"
    }
}

/*
 json response
 {
             "id": 115,
             "name": "รับส่ง",
             "amount": "500.0",
             "amount_before_vat": "500.0",
             "vat_amount": "0.0",
             "barcode": null,
             "code": null,
             "category_id": null,
             "status": "available",
             "description": "",
             "vat_included": false,
             "created_at": "2019-11-29T08:20:26.443+07:00",
             "updated_at": "2023-08-25T11:25:01.734+07:00",
             "hotel_id": 105
         }
 */
