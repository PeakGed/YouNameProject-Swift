import XCTest
@testable import YourProject

final class FolioFormTests: XCTestCase {
    // MARK: - Initialization Tests
    func test_initWithAllProperties() throws {
        // Arrange
        let now = Date()
        let folio = FolioForm(
            id: 1,
            status: .active,
            number: "F20230600001",
            vatIncluded: false,
            vatPercentage: 7,
            occupiedTotalAmount: 1500.0,
            additionalTotalAmount: 0.0,
            totalAmount: 1500.0,
            amountBeforeVat: 0.0,
            vatAmount: 0.0,
            paidBeforeAmount: 0.0,
            remainAmount: 1500.0,
            remark: "testrrrsss",
            internalNote: "testrrrwww",
            paymentInfo: "2, 2 (111-1-11111-2)",
            groupRoomCharge: true,
            groupAdditionalItem: false,
            receiptIds: [],
            hotelId: 105,
            hotelContactId: 8,
            customerContactId: 6,
            canceledAt: nil,
            createdAt: now,
            updatedAt: now
        )
        // Assert
        XCTAssertEqual(folio.id, 1)
        XCTAssertEqual(folio.status, FolioForm.Status.active)
        XCTAssertNil(folio.canceledAt)
        XCTAssertEqual(folio.number, "F20230600001")
        XCTAssertEqual(folio.vatIncluded, false)
        XCTAssertEqual(folio.vatPercentage, 7)
        XCTAssertEqual(folio.occupiedTotalAmount, 1500.0)
        XCTAssertEqual(folio.additionalTotalAmount, 0.0)
        XCTAssertEqual(folio.totalAmount, 1500.0)
        XCTAssertEqual(folio.amountBeforeVat, 0.0)
        XCTAssertEqual(folio.vatAmount, 0.0)
        XCTAssertEqual(folio.paidBeforeAmount, 0.0)
        XCTAssertEqual(folio.remainAmount, 1500.0)
        XCTAssertEqual(folio.remark, "testrrrsss")
        XCTAssertEqual(folio.internalNote, "testrrrwww")
        XCTAssertEqual(folio.paymentInfo, "2, 2 (111-1-11111-2)")
        XCTAssertEqual(folio.groupRoomCharge, true)
        XCTAssertEqual(folio.groupAdditionalItem, false)
        XCTAssertEqual(folio.receiptIds, [])
        XCTAssertEqual(folio.hotelId, 105)
        XCTAssertEqual(folio.hotelContactId, 8)
        XCTAssertEqual(folio.customerContactId, 6)
        XCTAssertEqual(folio.createdAt, now)
        XCTAssertEqual(folio.updatedAt, now)
    }

    // MARK: - Codable Tests
    func test_decodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "id": 1,
            "status": "active",
            "cancelled_at": "2023-06-10T14:35:57.177+07:00",
            "number": "F20230600001",
            "vat_included": false,
            "vat_percentage": 7,
            "occupied_total_amount": "1500.0",
            "additional_total_amount": "0.0",
            "total_amount": "1500.0",
            "amount_before_vat": "0.0",
            "vat_amount": "0.0",
            "paid_before_amount": "0.0",
            "remain_amount": "1500.0",
            "remark": "testrrrsss",
            "internal_note": "testrrrwww",
            "payment_info": "2, 2 (111-1-11111-2)",
            "group_room_charge": true,
            "group_additional_item": false,
            "created_at": "2023-06-09T13:31:11.727+07:00",
            "updated_at": "2023-09-12T17:39:27.760+07:00",
            "receipt_ids": [],
            "hotel_id": 105,
            "hotel_contact_id": 8,
            "customer_contact_id": 6
        }
        """.data(using: .utf8)!
        // Act
        let folio = try JSONDecoder().decode(FolioForm.self, from: json)
        // Assert
        XCTAssertEqual(folio.id, 1)
        XCTAssertEqual(folio.status, FolioForm.Status.active)
        XCTAssertNotNil(folio.canceledAt)
        XCTAssertEqual(folio.number, "F20230600001")
        XCTAssertEqual(folio.vatIncluded, false)
        XCTAssertEqual(folio.vatPercentage, 7)
        XCTAssertEqual(folio.occupiedTotalAmount, 1500.0)
        XCTAssertEqual(folio.additionalTotalAmount, 0.0)
        XCTAssertEqual(folio.totalAmount, 1500.0)
        XCTAssertEqual(folio.amountBeforeVat, 0.0)
        XCTAssertEqual(folio.vatAmount, 0.0)
        XCTAssertEqual(folio.paidBeforeAmount, 0.0)
        XCTAssertEqual(folio.remainAmount, 1500.0)
        XCTAssertEqual(folio.remark, "testrrrsss")
        XCTAssertEqual(folio.internalNote, "testrrrwww")
        XCTAssertEqual(folio.paymentInfo, "2, 2 (111-1-11111-2)")
        XCTAssertEqual(folio.groupRoomCharge, true)
        XCTAssertEqual(folio.groupAdditionalItem, false)
        XCTAssertEqual(folio.receiptIds, [])
        XCTAssertEqual(folio.hotelId, 105)
        XCTAssertEqual(folio.hotelContactId, 8)
        XCTAssertEqual(folio.customerContactId, 6)
        // Date checks
        let dateFormat = FormConfig.DateFormat.datetimeISO
        let createdAt = try "2023-06-09T13:31:11.727+07:00".tryToDate(dateFormat: dateFormat)
        let updatedAt = try "2023-09-12T17:39:27.760+07:00".tryToDate(dateFormat: dateFormat)
        XCTAssertEqual(folio.createdAt, createdAt)
        XCTAssertEqual(folio.updatedAt, updatedAt)
    }

    func test_encodingToJSON() throws {
        // Arrange
        let dateFormat = FormConfig.DateFormat.datetimeISO
        let createdAt = try "2023-06-09T13:31:11.727+07:00".tryToDate(dateFormat: dateFormat)
        let updatedAt = try "2023-09-12T17:39:27.760+07:00".tryToDate(dateFormat: dateFormat)
        let folio = FolioForm(
            id: 1,
            status: .active,            
            number: "F20230600001",
            vatIncluded: false,
            vatPercentage: 7,
            occupiedTotalAmount: 1500.0,
            additionalTotalAmount: 0.0,
            totalAmount: 1500.0,
            amountBeforeVat: 0.0,
            vatAmount: 0.0,
            paidBeforeAmount: 0.0,
            remainAmount: 1500.0,
            remark: "testrrrsss",
            internalNote: "testrrrwww",
            paymentInfo: "2, 2 (111-1-11111-2)",
            groupRoomCharge: true,
            groupAdditionalItem: false,
            receiptIds: [1],
            hotelId: 105,
            hotelContactId: 8,
            customerContactId: 6,
            canceledAt: nil,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
        // Act
        let encoder = JSONEncoder()
        let data = try encoder.encode(folio)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        // Assert
        XCTAssertEqual(jsonObject?["id"] as? Int, 1)
        XCTAssertEqual(jsonObject?["status"] as? String, "active")
        XCTAssertEqual(jsonObject?["number"] as? String, "F20230600001")
        XCTAssertEqual(jsonObject?["vat_included"] as? Bool, false)
        XCTAssertEqual(jsonObject?["vat_percentage"] as? Int, 7)
        XCTAssertEqual(jsonObject?["occupied_total_amount"] as? String, "1500.0")
        XCTAssertEqual(jsonObject?["additional_total_amount"] as? String, "0.0")
        XCTAssertEqual(jsonObject?["total_amount"] as? String, "1500.0")
        XCTAssertEqual(jsonObject?["amount_before_vat"] as? String, "0.0")
        XCTAssertEqual(jsonObject?["vat_amount"] as? String, "0.0")
        XCTAssertEqual(jsonObject?["paid_before_amount"] as? String, "0.0")
        XCTAssertEqual(jsonObject?["remain_amount"] as? String, "1500.0")
        XCTAssertEqual(jsonObject?["remark"] as? String, "testrrrsss")
        XCTAssertEqual(jsonObject?["internal_note"] as? String, "testrrrwww")
        XCTAssertEqual(jsonObject?["payment_info"] as? String, "2, 2 (111-1-11111-2)")
        XCTAssertEqual(jsonObject?["group_room_charge"] as? Bool, true)
        XCTAssertEqual(jsonObject?["group_additional_item"] as? Bool, false)
        XCTAssertEqual(jsonObject?["receipt_ids"] as? [Int], [1])
        XCTAssertEqual(jsonObject?["hotel_id"] as? Int, 105)
        XCTAssertEqual(jsonObject?["hotel_contact_id"] as? Int, 8)
        XCTAssertEqual(jsonObject?["customer_contact_id"] as? Int, 6)
        XCTAssertEqual(jsonObject?["created_at"] as? String, "2023-06-09T13:31:11.727+07:00")
        XCTAssertEqual(jsonObject?["updated_at"] as? String, "2023-09-12T17:39:27.760+07:00")
    }
} 
