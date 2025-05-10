//
//  FolioRemoteServiceTests.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

import XCTest
import Mockable

final class FolioRemoteServiceTests: XCTestCase {
    lazy var localStorage = MockLocalStorageManagerProtocal()
    lazy var apiManager = MockAPIManagerProtocal()

    func testFetchFolios_WillGetValidResponse() async throws {
        // Given
        let expectedPaginator = Paginator<Folios>(
            items: Collection(array: []),
            totalItems: 0,
            totalPages: 0,
            perPage: 20,
            page: 1
        )
        // Stub the API manager to return the expected paginator
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedPaginator)

        let service = FolioRemoteService(localStorage: localStorage,
                                         apiManager: apiManager)
        let request = FolioServiceRequest.FetchFolios(
            hotelId: 1,
            page: 1,
            perPage: .twenty,
            sortedBy: .id,
            sortedOrder: .ascending
        )

        // When
        let result = try await service.fetchFolios(request: request)

        // Then
        XCTAssertEqual(result.totalItems,
                       expectedPaginator.totalItems)
    }

    func testFetchFolio_WillGetValidResponse() async throws {
        // Given
        let expectedFolio = Folio(
            id: 1,
            name: "Test Folio",
            amount: 100.0,
            amountBeforeVat: 93.46,
            vatAmount: 6.54,
            barcode: nil,
            code: nil,
            categoryId: 1,
            status: "created",
            description: "Test Description",
            vatIncluded: true,
            hotelId: 101,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedFolio)

        let service = FolioRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = FolioServiceRequest.FetchFolio(id: 1)

        // When
        let result = try await service.fetchFolio(request: request)

        // Then
        XCTAssertEqual(result.id, expectedFolio.id)
        XCTAssertEqual(result.name, expectedFolio.name)
    }

    func testCreateFolio_WillGetValidResponse() async throws {
        // Given
        let expectedFolio = Folio(
            id: 2,
            name: "Created Folio",
            amount: 200.0,
            amountBeforeVat: 186.92,
            vatAmount: 13.08,
            barcode: nil,
            code: nil,
            categoryId: 2,
            status: "created",
            description: "Created Description",
            vatIncluded: false,
            hotelId: 102,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedFolio)

        let service = FolioRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = FolioServiceRequest.CreateFolio(
            hotelId: 102,
            name: "Created Folio",
            amount: 200.0,
            description: "Created Description",
            categoryId: 2,
            amountVatOption: .includedVat
        )

        // When
        let result = try await service.createFolio(request: request)

        // Then
        XCTAssertEqual(result.id, expectedFolio.id)
        XCTAssertEqual(result.name, expectedFolio.name)
    }

    func testUpdateFolio_WillGetValidResponse() async throws {
        // Given
        let expectedFolio = Folio(
            id: 3,
            name: "Updated Folio",
            amount: 300.0,
            amountBeforeVat: 280.39,
            vatAmount: 19.61,
            barcode: nil,
            code: nil,
            categoryId: 3,
            status: "updated",
            description: "Updated Description",
            vatIncluded: true,
            hotelId: 103,
            createdAt: Date(),
            updatedAt: Date()
        )
        given(apiManager)
            .request(router: .any, requiredAuthorization: .any)
            .willReturn(expectedFolio)

        let service = FolioRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = FolioServiceRequest.UpdateFolio(
            id: 3,
            name: "Updated Folio",
            amount: 300.0,
            description: "Updated Description",
            categoryId: 3,
            amountVatOption: .includedVat
        )

        // When
        let result = try await service.updateFolio(request: request)

        // Then
        XCTAssertEqual(result.id, expectedFolio.id)
        XCTAssertEqual(result.name, expectedFolio.name)
    }

    func testDeleteFolio_WillSucceed() async throws {
        // Given
        given(apiManager)
            .requestACK(router: .any, requiredAuthorization: .any)
            .willReturn(())

        let service = FolioRemoteService(localStorage: localStorage, apiManager: apiManager)
        let request = FolioServiceRequest.DeleteFolio(id: 4)

        // When/Then
        do {
            try await service.deleteFolio(request: request)
            XCTAssertTrue(true)
        } catch {
            XCTFail("Delete should not throw error")
        }
    }
}
