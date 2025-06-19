//
//  ReservationServiceRequestTests.swift
//  YourProjectTests
//
//  Created by AI Assistant
//

import XCTest

class ReservationServiceRequestTests: XCTestCase {
    
    // MARK: - Test FetchReservations
    
    func test_fetchReservations_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservations(
            hotelId: 105,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            status: "CONFIRMED"
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "ID")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
        XCTAssertEqual(parameters?["status"] as? String, "CONFIRMED")
    }
    
    func test_fetchReservations_optionalFields_nil() throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservations(
            hotelId: 105,
            page: nil,
            perPage: nil,
            sortedBy: nil,
            sortedOrder: nil,
            status: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNil(parameters?["page"])
        XCTAssertNil(parameters?["per_page"])
        XCTAssertNil(parameters?["sorted_by"])
        XCTAssertNil(parameters?["sorted_order"])
        XCTAssertNil(parameters?["status"])
    }
    
    // MARK: - Test FetchReservationsByFlags
    
    func test_fetchReservationsByFlags_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationsByFlags(
            hotelId: 105,
            flags: "FLAG_RED,FLAG_BLUE",
            page: 2,
            perPage: .fifty,
            sortedBy: .checkInDate,
            sortedOrder: .descending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["flags"] as? String, "FLAG_RED,FLAG_BLUE")
        XCTAssertEqual(parameters?["page"] as? Int, 2)
        XCTAssertEqual(parameters?["per_page"] as? String, "50")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CHECK_IN_DATE")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    // MARK: - Test FetchReservationsByPeriod
    
    func test_fetchReservationsByPeriod_encodesCorrectly() throws {
        // Arrange
        let startDate = Date(timeIntervalSince1970: 1700000000) // 2023-11-15
        let endDate = Date(timeIntervalSince1970: 1700086400)   // 2023-11-16
        let period = PeriodDate(start: startDate, end: endDate)
        
        let request = ReservationServiceRequest.FetchReservationsByPeriod(
            hotelId: 105,
            period: period,
            status: "CHECKED_IN",
            page: 1,
            perPage: .hundred,
            sortedBy: .checkOutDate,
            sortedOrder: .ascending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["start_at"] as? String, "2023-11-15")
        XCTAssertEqual(parameters?["end_at"] as? String, "2023-11-16")
        XCTAssertEqual(parameters?["status"] as? String, "CHECKED_IN")
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "100")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CHECK_OUT_DATE")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    // MARK: - Test FetchReservationsByCreatedAt
    
    func test_fetchReservationsByCreatedAt_encodesCorrectly() throws {
        // Arrange
        let startAt = Date(timeIntervalSince1970: 1700000000)
        let endAt = Date(timeIntervalSince1970: 1700086400)
        
        let request = ReservationServiceRequest.FetchReservationsByCreatedAt(
            hotelId: 105,
            startAt: startAt,
            endAt: endAt,
            page: 1,
            perPage: .ten,
            sortedBy: .createdAt,
            sortedOrder: .descending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertNotNil(parameters?["start_at"] as? String)
        XCTAssertNotNil(parameters?["end_at"] as? String)
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "10")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CREATED_AT")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "DESC")
    }
    
    // MARK: - Test FetchReservationsByBatchIds
    
    func test_fetchReservationsByBatchIds_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationsByBatchIds(
            hotelId: 105,
            ids: [512, 513, 514]
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["ids"] as? String, "512,513,514")
    }
    
    // MARK: - Test FetchReservationsByKeyword
    
    func test_fetchReservationsByKeyword_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationsByKeyword(
            hotelId: 105,
            keyword: "สมชาย",
            page: 1,
            perPage: .twenty,
            sortedBy: .contactName,
            sortedOrder: .ascending
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["keyword"] as? String, "สมชาย")
        XCTAssertEqual(parameters?["page"] as? Int, 1)
        XCTAssertEqual(parameters?["per_page"] as? String, "20")
        XCTAssertEqual(parameters?["sorted_by"] as? String, "CONTACT_NAME")
        XCTAssertEqual(parameters?["sorted_order"] as? String, "ASC")
    }
    
    // MARK: - Test FetchReservationByUid
    
    func test_fetchReservationByUid_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservationByUid(
            hotelId: 105,
            uid: "rsvt_thai_booking_001"
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertEqual(parameters?["hotel_id"] as? Int, 105)
        XCTAssertEqual(parameters?["uid"] as? String, "rsvt_thai_booking_001")
    }
    
    // MARK: - Test CreateReservation
    
    func test_createReservation_encodesCorrectly() throws {
        // Arrange
        let checkInDate = Date(timeIntervalSince1970: 1700000000)
        let checkOutDate = Date(timeIntervalSince1970: 1700259200)
        let contacts = ReservationContacts(
            title: "คุณ",
            fullname: "สมชาย ใจดี",
            email: "somchai@example.com",
            tel: "0812345678"
        )
        
        let request = ReservationServiceRequest.CreateReservation(
            hotelId: 105,
            roomTypeId: 5,
            roomId: 101,
            checkInDate: checkInDate,
            checkOutDate: checkOutDate,
            adultNumber: 2,
            extraAdultNumber: 1,
            childNumber: 1,
            contacts: contacts,
            note: "ห้องติดกัน",
            otaBookingId: "BOOKING_12345",
            relatedReservationId: "RELATED_001",
            guestComment: "ต้องการห้องชั้นสูง",
            channelId: 1,
            subChannelId: 2
        )
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["hotel_id"] as? Int, 105)
        XCTAssertEqual(json?["room_type_id"] as? Int, 5)
        XCTAssertEqual(json?["room_id"] as? Int, 101)
        XCTAssertEqual(json?["check_in_date"] as? String, "2023-11-15")
        XCTAssertEqual(json?["check_out_date"] as? String, "2023-11-18")
        XCTAssertEqual(json?["adult_number"] as? Int, 2)
        XCTAssertEqual(json?["extra_adult_number"] as? Int, 1)
        XCTAssertEqual(json?["child_number"] as? Int, 1)
        XCTAssertEqual(json?["note"] as? String, "ห้องติดกัน")
        XCTAssertEqual(json?["ota_booking_id"] as? String, "BOOKING_12345")
        XCTAssertEqual(json?["related_reservation_id"] as? String, "RELATED_001")
        XCTAssertEqual(json?["guest_comment"] as? String, "ต้องการห้องชั้นสูง")
        XCTAssertEqual(json?["channel_id"] as? Int, 1)
        XCTAssertEqual(json?["sub_channel_id"] as? Int, 2)
        
        let contactsJson = json?["contacts"] as? [String: Any]
        XCTAssertNotNil(contactsJson)
        XCTAssertEqual(contactsJson?["title"] as? String, "คุณ")
        XCTAssertEqual(contactsJson?["fullname"] as? String, "สมชาย ใจดี")
        XCTAssertEqual(contactsJson?["email"] as? String, "somchai@example.com")
        XCTAssertEqual(contactsJson?["tel"] as? String, "0812345678")
    }
    
    // MARK: - Test UpdateReservation
    
    func test_updateReservation_encodesCorrectly() throws {
        // Arrange
        let checkInDate = Date(timeIntervalSince1970: 1700000000)
        let contacts = ReservationContacts(
            title: "คุณหญิง",
            fullname: "สมใส ใจดี",
            email: "somsai@example.com",
            tel: "0887654321"
        )
        
        let request = ReservationServiceRequest.UpdateReservation(
            id: 512,
            roomTypeId: 6,
            roomId: 102,
            checkInDate: checkInDate,
            checkOutDate: nil,
            adultNumber: 3,
            extraAdultNumber: nil,
            childNumber: 0,
            contacts: contacts,
            note: "เปลี่ยนเป็นห้องใหญ่",
            otaBookingId: nil,
            relatedReservationId: nil,
            guestComment: "ต้องการเตียงเสริม",
            status: "CONFIRMED"
        )
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["room_type_id"] as? Int, 6)
        XCTAssertEqual(json?["room_id"] as? Int, 102)
        XCTAssertEqual(json?["check_in_date"] as? String, "2023-11-15")
        XCTAssertEqual(json?["adult_number"] as? Int, 3)
        XCTAssertEqual(json?["child_number"] as? Int, 0)
        XCTAssertEqual(json?["note"] as? String, "เปลี่ยนเป็นห้องใหญ่")
        XCTAssertEqual(json?["guest_comment"] as? String, "ต้องการเตียงเสริม")
        XCTAssertEqual(json?["status"] as? String, "CONFIRMED")
        
        // Verify nil fields are not encoded
        XCTAssertNil(json?["check_out_date"])
        XCTAssertNil(json?["extra_adult_number"])
        XCTAssertNil(json?["ota_booking_id"])
        XCTAssertNil(json?["related_reservation_id"])
        
        let contactsJson = json?["contacts"] as? [String: Any]
        XCTAssertNotNil(contactsJson)
        XCTAssertEqual(contactsJson?["title"] as? String, "คุณหญิง")
        XCTAssertEqual(contactsJson?["fullname"] as? String, "สมใส ใจดี")
    }
    
    // MARK: - Test Customer Management
    
    func test_dropCustomer_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.DropCustomer(
            id: 512,
            customerId: 789
        )
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["customer_id"] as? Int, 789)
    }
    
    func test_appendCustomer_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.AppendCustomer(
            id: 512,
            customerId: 890
        )
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["customer_id"] as? Int, 890)
    }
    
    func test_replaceCustomers_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.ReplaceCustomers(
            id: 512,
            customerIds: [789, 890, 901]
        )
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        
        let customerIds = json?["customer_ids"] as? [Int]
        XCTAssertNotNil(customerIds)
        XCTAssertEqual(customerIds?.count, 3)
        XCTAssertTrue(customerIds?.contains(789) == true)
        XCTAssertTrue(customerIds?.contains(890) == true)
        XCTAssertTrue(customerIds?.contains(901) == true)
    }
    
    // MARK: - Test PostConfirmation
    
    func test_postConfirmation_encodesCorrectly() throws {
        // Arrange
        let request = ReservationServiceRequest.PostConfirmation(
            id: 512,
            remark: "การจองได้รับการยืนยันแล้ว",
            url: "https://hotel.example.com/confirmation/512"
        )
        
        // Act
        let bodyData = request.body
        
        // Assert
        XCTAssertNotNil(bodyData)
        
        let json = try JSONSerialization.jsonObject(with: bodyData!, options: []) as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["remark"] as? String, "การจองได้รับการยืนยันแล้ว")
        XCTAssertEqual(json?["url"] as? String, "https://hotel.example.com/confirmation/512")
    }
    
    // MARK: - Test ReservationContacts
    
    func test_reservationContacts_init() {
        // Test with all fields
        let contacts = ReservationContacts(
            title: "นาย",
            fullname: "วิชาญ เก่งดี",
            email: "wichan@example.com",
            tel: "0898765432"
        )
        
        XCTAssertEqual(contacts.title, "นาย")
        XCTAssertEqual(contacts.fullname, "วิชาญ เก่งดี")
        XCTAssertEqual(contacts.email, "wichan@example.com")
        XCTAssertEqual(contacts.tel, "0898765432")
        
        // Test with minimal fields
        let minimalContacts = ReservationContacts(fullname: "สมชาย")
        XCTAssertNil(minimalContacts.title)
        XCTAssertEqual(minimalContacts.fullname, "สมชาย")
        XCTAssertNil(minimalContacts.email)
        XCTAssertNil(minimalContacts.tel)
    }
    
    // MARK: - Test Edge Cases
    
    func test_fetchReservations_pageZero_notEncoded() throws {
        // Arrange
        let request = ReservationServiceRequest.FetchReservations(
            hotelId: 105,
            page: 0, // Should not be encoded as it's < 1
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending,
            status: nil
        )
        
        // Act
        let parameters = request.parameters
        
        // Assert
        XCTAssertNotNil(parameters)
        XCTAssertNil(parameters?["page"]) // Should be nil since page < 1
    }
    
    func test_sortedBy_allCases() {
        // Test all SortedBy enum cases
        XCTAssertEqual(ReservationServiceRequest.SortedBy.id.rawValue, "ID")
        XCTAssertEqual(ReservationServiceRequest.SortedBy.checkInDate.rawValue, "CHECK_IN_DATE")
        XCTAssertEqual(ReservationServiceRequest.SortedBy.checkOutDate.rawValue, "CHECK_OUT_DATE")
        XCTAssertEqual(ReservationServiceRequest.SortedBy.createdAt.rawValue, "CREATED_AT")
        XCTAssertEqual(ReservationServiceRequest.SortedBy.updatedAt.rawValue, "UPDATED_AT")
        XCTAssertEqual(ReservationServiceRequest.SortedBy.status.rawValue, "STATUS")
        XCTAssertEqual(ReservationServiceRequest.SortedBy.contactName.rawValue, "CONTACT_NAME")
        XCTAssertEqual(ReservationServiceRequest.SortedBy.totalCost.rawValue, "TOTAL_COST")
        XCTAssertEqual(ReservationServiceRequest.SortedBy.totalPaid.rawValue, "TOTAL_PAID")
        XCTAssertEqual(ReservationServiceRequest.SortedBy.remainCost.rawValue, "REMAIN_COST")
        XCTAssertEqual(ReservationServiceRequest.SortedBy.nightCount.rawValue, "NIGHT_COUNT")
    }
} 