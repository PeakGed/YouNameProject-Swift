//
//  ReservationServiceRouterTests.swift
//  YourProject
//
//  Created by IntrodexMini on 6/6/2568 BE.
//

import XCTest
import Alamofire
import Mockable

final class ReservationServiceRouterTests: XCTestCase {
    
    var baseURL: String!
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()
    
    override func setUp() {
        super.setUp()
        baseURL = AppConfiguration.shared.baseURL
    }
    
    func testFetchReservationsRequest() throws {
        // Given
        let req = ReservationServiceRequest.FetchReservations(
            page: 1,
            perPage: 20,
            sortedBy: "ID",
            sortedOrder: "ASC",
            hotelId: 105
        )
        let router = ReservationServiceRouter.fetchReservations(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        // Check base path
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/reservations"))
        
        // Check individual parameters
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = urlComponents?.queryItems ?? []
        
        XCTAssertTrue(queryItems.contains { $0.name == "page" && $0.value == "1" })
        XCTAssertTrue(queryItems.contains { $0.name == "per_page" && $0.value == "20" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_by" && $0.value == "ID" })
        XCTAssertTrue(queryItems.contains { $0.name == "sorted_order" && $0.value == "ASC" })
        XCTAssertTrue(queryItems.contains { $0.name == "hotel_id" && $0.value == "105" })
        
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchReservationsByFlagsRequest() throws {
        // Given
        let req = ReservationServiceRequest.FetchReservationsByFlags(
            flags: ["checked_in", "confirmed"],
            hotelId: 105
        )
        let router = ReservationServiceRouter.fetchReservationsByFlags(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertTrue(urlRequest.url?.absoluteString.contains(baseURL + "/v4/reservations/flags") == true)
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchReservationByIdRequest() throws {
        // Given
        let req = ReservationServiceRequest.FetchById(id: 123)
        let router = ReservationServiceRouter.fetchReservation(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations/123")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testCreateReservationRequest() throws {
        // Given
        let req = ReservationServiceRequest.CreateReservation(
            roomTypeId: 10,
            checkInDate: "2024-06-15",
            checkOutDate: "2024-06-17",
            numberOfGuests: 2,
            firstName: "John",
            lastName: "Doe",
            nationality: "THA",
            email: "john.doe@example.com",
            phoneNumber: "+66123456789",
            hotelId: 105
        )
        let router = ReservationServiceRouter.createReservation(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
        
        // Test parameters
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any] {
                    XCTAssertEqual(json["room_type_id"] as? Int, 10)
                    XCTAssertEqual(json["check_in_date"] as? String, "2024-06-15")
                    XCTAssertEqual(json["check_out_date"] as? String, "2024-06-17")
                    XCTAssertEqual(json["number_of_guests"] as? Int, 2)
                    XCTAssertEqual(json["first_name"] as? String, "John")
                    XCTAssertEqual(json["last_name"] as? String, "Doe")
                    XCTAssertEqual(json["nationality"] as? String, "THA")
                    XCTAssertEqual(json["email"] as? String, "john.doe@example.com")
                    XCTAssertEqual(json["phone_number"] as? String, "+66123456789")
                    XCTAssertEqual(json["hotel_id"] as? Int, 105)
                } else {
                    XCTFail("JSON is not a dictionary")
                }
            } catch {
                XCTFail("Failed to parse JSON: \(error)")
            }
        } else {
            XCTFail("HTTP body is nil")
        }
    }
    
    func testUpdateReservationRequest() throws {
        // Given
        let req = ReservationServiceRequest.UpdateReservation(
            id: 123,
            roomTypeId: 11,
            checkInDate: "2024-06-16",
            checkOutDate: "2024-06-18",
            numberOfGuests: 3
        )
        let router = ReservationServiceRouter.updateReservation(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations/123")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.put.rawValue)
        
        // Test body
        if let body = urlRequest.httpBody {
            do {
                if let json = try JSONSerialization.jsonObject(with: body, options: []) as? [String: Any] {
                    XCTAssertEqual(json["room_type_id"] as? Int, 11)
                    XCTAssertEqual(json["check_in_date"] as? String, "2024-06-16")
                    XCTAssertEqual(json["check_out_date"] as? String, "2024-06-18")
                    XCTAssertEqual(json["number_of_guests"] as? Int, 3)
                    // id should not be in the JSON body
                    XCTAssertNil(json["id"])
                } else {
                    XCTFail("JSON is not a dictionary")
                }
            } catch {
                XCTFail("Failed to parse JSON: \(error)")
            }
        } else {
            XCTFail("HTTP body is nil")
        }
    }
    
    func testDeleteReservationRequest() throws {
        // Given
        let req = ReservationServiceRequest.DeleteReservation(id: 123)
        let router = ReservationServiceRouter.deleteReservation(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations/123")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.delete.rawValue)
        XCTAssertNil(urlRequest.httpBody)
    }
    
    func testCheckInRequest() throws {
        // Given
        let req = ReservationServiceRequest.CheckIn(id: 123)
        let router = ReservationServiceRouter.checkIn(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations/123/check-in")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
    }
    
    func testCheckOutRequest() throws {
        // Given
        let req = ReservationServiceRequest.CheckOut(id: 123)
        let router = ReservationServiceRouter.checkOut(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations/123/check-out")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
    }
    
    func testCancelRequest() throws {
        // Given
        let req = ReservationServiceRequest.Cancel(id: 123)
        let router = ReservationServiceRouter.cancel(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations/123/cancel")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
    }
    
    func testNoShowRequest() throws {
        // Given
        let req = ReservationServiceRequest.NoShow(id: 123)
        let router = ReservationServiceRouter.noShow(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations/123/no-show")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.post.rawValue)
    }
    
    func testGetFirstGuestRequest() throws {
        // Given
        let req = ReservationServiceRequest.GetFirstGuest(id: 123)
        let router = ReservationServiceRouter.getFirstGuest(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations/123/first-guest")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testGetConfirmationRequest() throws {
        // Given
        let req = ReservationServiceRequest.GetConfirmation(id: 123)
        let router = ReservationServiceRouter.getConfirmation(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations/123/confirmation")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testGetFolioRequest() throws {
        // Given
        let req = ReservationServiceRequest.GetFolio(id: 123)
        let router = ReservationServiceRouter.getFolio(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        XCTAssertEqual(urlRequest.url?.absoluteString, baseURL + "/v4/reservations/123/folio")
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func testFetchCMBookingsRequest() throws {
        // Given
        let req = ReservationServiceRequest.FetchReservationByCMBooking(
            page: 1,
            perPage: 10,
            hotelId: 105
        )
        let router = ReservationServiceRouter.fetchCMBookings(request: req)
        
        // When
        let urlRequest = try router.asURLRequest()
        
        // Then
        guard let url = urlRequest.url else {
            XCTFail("URL should not be nil")
            return
        }
        
        XCTAssertTrue(url.absoluteString.contains(baseURL + "/v4/reservations/cm-bookings"))
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
    }
} 
