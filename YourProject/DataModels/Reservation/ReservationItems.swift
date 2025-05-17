//
//  ReservationItems.swift
//  YourProject
//
//  Created by IntrodexMini on 12/5/2568 BE.
//
import Foundation

typealias ReservationItems = Collection<ReservationItem>

// MARK: Computed properties
extension ReservationItems {
    
    var grandTotal: Double {        
        lists.map({$0.totalPrice}).reduce(0, +)
    }
    
    var selectedRate: Double {            
        lists.map({$0.selectedRate}).reduce(0, +)
    }
    
    var extraAdultTotal: Double {        
        lists.map({$0.extraAdultTotal}).reduce(0, +)
    }

    var extraChildTotal: Double {
        lists.map({$0.extraChildTotal}).reduce(0, +)
    }
    
    var extraAdultMealTotal: Double {
        lists.map({$0.extraAdultMealTotal}).reduce(0, +)
    }
    
    var extraChildMealTotal: Double {
        lists.map({$0.extraChildMealTotal}).reduce(0, +)
    }
    
    var roomIDs: Set<Int> {
        let result = lists
            .filter { $0.reservableType == .room }
            .map { $0.reservableId }
        return Set(result)
    }
    
    var unitCount: Int {
        roomIDs.count
    }
}

// MARK: - Functions
extension ReservationItems {
        
    func sortedBy(
        by: ReservationItem.SortBy = .id,
        orderBy: SortOrderBy = .ascending
    ) -> ReservationItems {
        let sorted: [ReservationItem]
        switch by {
        case .id:
            sorted = lists.sorted { orderBy == .ascending ? $0.id < $1.id : $0.id > $1.id }
        case .reservableDate:
            sorted = lists.sorted { orderBy == .ascending ? $0.reservedDate < $1.reservedDate : $0.reservedDate > $1.reservedDate }
        case .createdAt:
            sorted = lists.sorted { orderBy == .ascending ? $0.createdAt < $1.createdAt : $0.createdAt > $1.createdAt }
        case .updatedAt:
            sorted = lists.sorted { orderBy == .ascending ? $0.updatedAt < $1.updatedAt : $0.updatedAt > $1.updatedAt }
        }
        return .init(array: sorted)
    }
    
    func filteredBy(
        by: ReservationItem.FilterBy
    ) -> ReservationItems {
        let filtered: [ReservationItem]
        switch by {
        case .id(let id):
            filtered = lists.filter { $0.id == id }
        case .reservableId(let id):
            filtered = lists.filter { $0.reservableId == id }
        case .reservableType(let type):
            filtered = lists.filter { $0.reservableType == type } // Adjust if you want to filter by type
        case .date(let date):
            filtered = lists.filter { $0.createdAt == date }
        case .beforeDate(let date):
            filtered = lists.filter { $0.createdAt < date }
        case .afterDate(let date):
            filtered = lists.filter { $0.createdAt > date }
        }
        return .init(array: filtered)
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        self.lists = try container.decode([ReservationItem].self)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encode(lists)
//    }
    
//    func filter(byID: Int) -> ReservationItem? {
//        return lists.filter { (item) -> Bool in
//            return item.id == byID
//        }.first
//    }
//    
//    func filter(byDate: Date) -> Self {
//        let items = lists.filter({ reservationItem in
//            reservationItem.reservedDate.isSameDate(byDate)
//        })
//        return .init(lists: items)
//    }
//    
//    //filter only item before input date
//    func filter(beforeDate: Date) -> Self {
//        let items = lists.filter({ reservationItem in
//            reservationItem.reservedDate.isLessThen(beforeDate)
//        })
//        return .init(lists: items)
//    }
//    
//    func filter(reservablType: ReservationItem.ReservableType) -> Self {
//        let items = self.lists.filter({ reservationItem in
//            reservationItem.reservableType == reservablType
//        })
//        return .init(lists: items)
//    }
    
//    func filter(reservableID: Int) -> Self {
//        let items = self.lists.filter({ reservationItem in
//            reservationItem.reservableID == reservableID
//        })
//        return .init(lists: items)
//    }
//    
//    func sortedByDateO2N() -> Self {
//        let items = self.lists.sorted { $0.reservedDate < $1.reservedDate }
//        return .init(lists: items)
//    }
//        
//    func sortedByDateN2O() -> Self {
//        let items = self.lists.sorted { $0.reservedDate > $1.reservedDate }
//        return .init(lists: items)
//    }
    
    func maxMealLimit() -> ReservationItem? {
        let result = lists.filter({ $0.data.mealIncluded == true }).max {
            $0.data.adultMealLimit > $1.data.adultMealLimit &&
            $0.data.childMealLimit > $1.data.childMealLimit
        }
        return result
    }
    
    func existMeal() -> Bool {
        return lists.contains(where: { $0.data.mealIncluded == true })
    }
}
