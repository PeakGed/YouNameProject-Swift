//
//  FinancialRecord.swift
//  YourProject
//
//  Created by IntrodexMini on 17/5/2568 BE.
//

import Foundation

struct FinancialRecord: Codable {
        
    /*
    json format
    [
      {
        "name": "Bank Transfer",
        "subMethods": []
      },
      {
        "name": "Cash", 
        "subMethods": []
      },
      {
        "name": "Cheque",
        "subMethods": []
      },
      {
        "name": "Credit Card",
        "subMethods": []
      },
      {
        "name": "Fin Tech",
        "subMethods": [
          "Alipay",
          "Apple Pay",
          "Prompt pay", 
          "Samsung Pay",
          "WeChat Pay"
        ]
      },
      {
        "name": "OTA Transfer",
        "subMethods": []
      },
      {
        "name": "Paypal",
        "subMethods": []
      }
    ]
    */
    static let paymentMethods = [
                                 Method(name: "Bank Transfer",
                                        subMethods: []) ,
                                 Method(name: "Cash",
                                        subMethods: []) ,
                                 Method(name: "Cheque",
                                        subMethods: []) ,
                                 Method(name: "Credit Card",
                                        subMethods: []) ,
                                 Method(name: "Fin Tech",
                                        subMethods: [
                                    "Alipay" ,
                                    "Apple Pay" ,
                                    "Prompt pay" ,
                                    "Samsung Pay" ,
                                    "WeChat Pay"
                                 ]) ,
                                 Method(name: "OTA Transfer",
                                        subMethods: []) ,
                                 Method(name: "Paypal",
                                        subMethods: []) ]
    
    static let defaultPaymentMethod = FinancialRecord.paymentMethods[1] // Cash
    
    internal let dateFormat = "dd MMM yyyy HH:mm"
    
    let id: Int
    let name: String
    let paymentMethod: String
    let note: String?
    let timestamp: Date
    let amount: Double
    let recordableId: Int
    let recordableType: String
    let createdAt: Date
    let updatedAt: Date
    let hotelId: Int
    let bankAccount: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case paymentMethod = "payment_method"
        case note
        case timestamp
        case amount
        case recordableId = "recordable_id"
        case recordableType = "recordable_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hotelId = "hotel_id"
        case bankAccount = "bank_account"
    }
    
    init(id: Int,
         name: String,
         paymentMethod: String,
         note: String?,
         timestamp: Date,
         amount: Double,
         recordableId: Int,
         recordableType: String,
         createdAt: Date,
         updatedAt: Date,
         hotelId: Int,
         bankAccount: String?) {
        self.id = id
        self.name = name
        self.paymentMethod = paymentMethod
        self.note = note
        self.timestamp = timestamp
        self.amount = amount
        self.recordableId = recordableId
        self.recordableType = recordableType
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.hotelId = hotelId
        self.bankAccount = bankAccount
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        paymentMethod = try container.decode(String.self, forKey: .paymentMethod)
        note = try container.decodeIfPresent(String.self, forKey: .note)
        timestamp = try container.decode(String.self, forKey: .timestamp).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        amount = try container.decode(String.self, forKey: .amount).trytoDouble()
        recordableId = try container.decode(Int.self, forKey: .recordableId)
        recordableType = try container.decode(String.self, forKey: .recordableType)
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        bankAccount = try container.decodeIfPresent(String.self, forKey: .bankAccount)
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: FormConfig.DateFormat.datetimeISO)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(paymentMethod, forKey: .paymentMethod)
        try container.encode(note, forKey: .note)
        try container.encode(timestamp.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .timestamp)
        try container.encode(String(amount), forKey: .amount)
        try container.encode(recordableId, forKey: .recordableId)
        try container.encode(recordableType, forKey: .recordableType)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(bankAccount, forKey: .bankAccount)
        try container.encode(createdAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(FormConfig.DateFormat.datetimeISO), forKey: .updatedAt)
    }
}

extension FinancialRecord {
    enum CashFlowType: String {
        case income
        case expense
    }
    
    struct Method {
        var name: String
        var subMethods: [String]
    }

    
}

/*
 {
            "id": 440,
            "name": "PAYMENT",
            "payment_method": "Bank Transfer",
            "note": null,
            "timestamp": "2024-04-21T13:33:54.748+07:00",
            "amount": 2111,
            "recordable_id": 1067,
            "recordable_type": "Reservation",
            "created_at": "2024-04-21T13:33:54.756+07:00",
            "updated_at": "2024-04-21T13:33:54.756+07:00",
            "hotel_id": 105,
            "bank_account": null
        }
 */
