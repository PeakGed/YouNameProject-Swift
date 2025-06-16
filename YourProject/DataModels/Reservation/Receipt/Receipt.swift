//
//  Receipt.swift
//  YourProject
//
//  Created by IntrodexMini on 16/6/2568 BE.
//

import Foundation

struct Receipt: Codable {
    let id: Int
    let status: Status
    let voidReason: String?
    let voidedAt: Date?
    let cancelledAt: Date?
    let cancelReason: String?
    let paidAt: Date?
    let number: String
    let vatIncluded: Bool
    let vatPercentage: String
    let withholdingTaxIncluded: Bool
    let withholdingTaxPercentage: String
    let occupiedTotalAmount: String
    let additionalTotalAmount: String
    let totalAmount: String
    let amountBeforeVat: String
    let vatAmount: String
    let holdingTaxAmount: String
    let totalReceiveAmount: String
    let paidBeforeAmount: String
    let paidDate: Date
    let currency: String
    let remark: String?
    let internalNote: String?
    let createdAt: Date
    let updatedAt: Date
    let hotelId: Int
    let userId: Int
    let folioFormId: Int?
    let payerContactId: Int
    let receiverContactId: Int
    let financialRecordIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id
        case status
        case voidReason = "void_reason"
        case voidedAt = "voided_at"
        case cancelledAt = "cancelled_at"
        case cancelReason = "cancel_reason"
        case paidAt = "paid_at"
        case number
        case vatIncluded = "vat_included"
        case vatPercentage = "vat_percentage"
        case withholdingTaxIncluded = "withholding_tax_included"
        case withholdingTaxPercentage = "withholding_tax_percentage"
        case occupiedTotalAmount = "occupied_total_amount"
        case additionalTotalAmount = "additional_total_amount"
        case totalAmount = "total_amount"
        case amountBeforeVat = "amount_before_vat"
        case vatAmount = "vat_amount"
        case holdingTaxAmount = "holding_tax_amount"
        case totalReceiveAmount = "total_receive_amount"
        case paidBeforeAmount = "paid_before_amount"
        case paidDate = "paid_date"
        case currency
        case remark
        case internalNote = "internal_note"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case hotelId = "hotel_id"
        case userId = "user_id"
        case folioFormId = "folio_form_id"
        case payerContactId = "payer_contact_id"
        case receiverContactId = "receiver_contact_id"
        case financialRecordIds = "financial_record_ids"
    }

    init(id: Int,
         status: Status,
         voidReason: String?,
         voidedAt: Date?,
         cancelledAt: Date?,
         cancelReason: String?,
         paidAt: Date?,
         number: String,
         vatIncluded: Bool,
         vatPercentage: String,
         withholdingTaxIncluded: Bool,
         withholdingTaxPercentage: String,
         occupiedTotalAmount: String,
         additionalTotalAmount: String,
         totalAmount: String,
         amountBeforeVat: String,
         vatAmount: String,
         holdingTaxAmount: String,
         totalReceiveAmount: String,
         paidBeforeAmount: String,
         paidDate: Date,
         currency: String,
         remark: String?,
         internalNote: String?,
         createdAt: Date,
         updatedAt: Date,
         hotelId: Int,
         userId: Int,
         folioFormId: Int?,
         payerContactId: Int,
         receiverContactId: Int,
         financialRecordIds: [Int]) {
        self.id = id
        self.status = status
        self.voidReason = voidReason
        self.voidedAt = voidedAt
        self.cancelledAt = cancelledAt
        self.cancelReason = cancelReason
        self.paidAt = paidAt
        self.number = number
        self.vatIncluded = vatIncluded
        self.vatPercentage = vatPercentage
        self.withholdingTaxIncluded = withholdingTaxIncluded
        self.withholdingTaxPercentage = withholdingTaxPercentage
        self.occupiedTotalAmount = occupiedTotalAmount
        self.additionalTotalAmount = additionalTotalAmount
        self.totalAmount = totalAmount
        self.amountBeforeVat = amountBeforeVat
        self.vatAmount = vatAmount
        self.holdingTaxAmount = holdingTaxAmount
        self.totalReceiveAmount = totalReceiveAmount
        self.paidBeforeAmount = paidBeforeAmount
        self.paidDate = paidDate
        self.currency = currency
        self.remark = remark
        self.internalNote = internalNote
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.hotelId = hotelId
        self.userId = userId
        self.folioFormId = folioFormId
        self.payerContactId = payerContactId
        self.receiverContactId = receiverContactId
        self.financialRecordIds = financialRecordIds
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        status = try container.decode(Status.self, forKey: .status)
        voidReason = try container.decodeIfPresent(String.self, forKey: .voidReason)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        voidedAt = try container.decodeIfPresent(String.self, forKey: .voidedAt)?.tryToDate(dateFormat: dateFormat)
        cancelledAt = try container.decodeIfPresent(String.self, forKey: .cancelledAt)?.tryToDate(dateFormat: dateFormat)
        cancelReason = try container.decodeIfPresent(String.self, forKey: .cancelReason)
        paidAt = try container.decodeIfPresent(String.self, forKey: .paidAt)?.tryToDate(dateFormat: dateFormat)
        
        number = try container.decode(String.self, forKey: .number)
        vatIncluded = try container.decode(Bool.self, forKey: .vatIncluded)
        vatPercentage = try container.decode(String.self, forKey: .vatPercentage)
        withholdingTaxIncluded = try container.decode(Bool.self, forKey: .withholdingTaxIncluded)
        withholdingTaxPercentage = try container.decode(String.self, forKey: .withholdingTaxPercentage)
        occupiedTotalAmount = try container.decode(String.self, forKey: .occupiedTotalAmount)
        additionalTotalAmount = try container.decode(String.self, forKey: .additionalTotalAmount)
        totalAmount = try container.decode(String.self, forKey: .totalAmount)
        amountBeforeVat = try container.decode(String.self, forKey: .amountBeforeVat)
        vatAmount = try container.decode(String.self, forKey: .vatAmount)
        holdingTaxAmount = try container.decode(String.self, forKey: .holdingTaxAmount)
        totalReceiveAmount = try container.decode(String.self, forKey: .totalReceiveAmount)
        paidBeforeAmount = try container.decode(String.self, forKey: .paidBeforeAmount)
        
        paidDate = try container.decode(String.self, forKey: .paidDate).tryToDate(dateFormat: FormConfig.DateFormat.yyyyMMdd)
        currency = try container.decode(String.self, forKey: .currency)
        remark = try container.decodeIfPresent(String.self, forKey: .remark)
        internalNote = try container.decodeIfPresent(String.self, forKey: .internalNote)
        
        createdAt = try container.decode(String.self, forKey: .createdAt).tryToDate(dateFormat: dateFormat)
        updatedAt = try container.decode(String.self, forKey: .updatedAt).tryToDate(dateFormat: dateFormat)
        
        hotelId = try container.decode(Int.self, forKey: .hotelId)
        userId = try container.decode(Int.self, forKey: .userId)
        folioFormId = try container.decodeIfPresent(Int.self, forKey: .folioFormId)
        payerContactId = try container.decode(Int.self, forKey: .payerContactId)
        receiverContactId = try container.decode(Int.self, forKey: .receiverContactId)
        financialRecordIds = try container.decode([Int].self, forKey: .financialRecordIds)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(status, forKey: .status)
        try container.encodeIfPresent(voidReason, forKey: .voidReason)
        
        let dateFormat = FormConfig.DateFormat.datetimeISO
        try container.encodeIfPresent(voidedAt?.toDateString(dateFormat), forKey: .voidedAt)
        try container.encodeIfPresent(cancelledAt?.toDateString(dateFormat), forKey: .cancelledAt)
        try container.encodeIfPresent(cancelReason, forKey: .cancelReason)
        try container.encodeIfPresent(paidAt?.toDateString(dateFormat), forKey: .paidAt)
        
        try container.encode(number, forKey: .number)
        try container.encode(vatIncluded, forKey: .vatIncluded)
        try container.encode(vatPercentage, forKey: .vatPercentage)
        try container.encode(withholdingTaxIncluded, forKey: .withholdingTaxIncluded)
        try container.encode(withholdingTaxPercentage, forKey: .withholdingTaxPercentage)
        try container.encode(occupiedTotalAmount, forKey: .occupiedTotalAmount)
        try container.encode(additionalTotalAmount, forKey: .additionalTotalAmount)
        try container.encode(totalAmount, forKey: .totalAmount)
        try container.encode(amountBeforeVat, forKey: .amountBeforeVat)
        try container.encode(vatAmount, forKey: .vatAmount)
        try container.encode(holdingTaxAmount, forKey: .holdingTaxAmount)
        try container.encode(totalReceiveAmount, forKey: .totalReceiveAmount)
        try container.encode(paidBeforeAmount, forKey: .paidBeforeAmount)
        
        try container.encode(paidDate.toDateString(FormConfig.DateFormat.yyyyMMdd), forKey: .paidDate)
        try container.encode(currency, forKey: .currency)
        try container.encodeIfPresent(remark, forKey: .remark)
        try container.encodeIfPresent(internalNote, forKey: .internalNote)
        
        try container.encode(createdAt.toDateString(dateFormat), forKey: .createdAt)
        try container.encode(updatedAt.toDateString(dateFormat), forKey: .updatedAt)
        
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(userId, forKey: .userId)
        try container.encodeIfPresent(folioFormId, forKey: .folioFormId)
        try container.encode(payerContactId, forKey: .payerContactId)
        try container.encode(receiverContactId, forKey: .receiverContactId)
        try container.encode(financialRecordIds, forKey: .financialRecordIds)
    }
    
}

extension Receipt {
    enum Status: String, Codable {
        case paid = "paid"
        case voided = "void"
        case cancelled = "cancelled"
        
        var description: String {
            switch self {
            case .paid:
                return "Paid"
            case .voided:
                return "Voided"
            case .cancelled:
                return "Cancelled"
            }
        }
        
    }
}

/*
 {
     "id": 3,
     "status": "paid",
     "void_reason": null,
     "voided_at": null,
     "cancelled_at": null,
     "cancel_reason": null,
     "paid_at": null,
     "number": "RI20221100001",
     "vat_included": true,
     "vat_percentage": "7.0",
     "withholding_tax_included": true,
     "withholding_tax_percentage": "3.0",
     "occupied_total_amount": "500.0",
     "additional_total_amount": "0.0",
     "total_amount": "500.0",
     "amount_before_vat": "467.29",
     "vat_amount": "32.71",
     "holding_tax_amount": "14.02",
     "total_receive_amount": "500.0",
     "paid_before_amount": "0.0",
     "paid_date": "2022-11-22",
     "currency": "THB",
     "remark": null,
     "internal_note": null,
     "created_at": "2022-11-23T00:32:36.664+07:00",
     "updated_at": "2023-07-31T12:29:27.040+07:00",
     "hotel_id": 105,
     "user_id": 38,
     "folio_form_id": null,
     "payer_contact_id": 4,
     "receiver_contact_id": 4,
     "financial_record_ids": [1,2,3]
 }
*/
