//
//  Reservations.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//


typealias Reservations = Collection<Reservation>

// MARK: Computed properties
extension Reservations {

}

// MARK: - Functions
extension Reservations {
    
    func filter(byID: Int) -> Reservation? {
        lists.filter({ $0.id == byID }).first
    }
//    
//    func sorted() -> Reservation {
//        let sorted = lists.sorted(by: { $0.name < $1.name })
//        return .init(array: sorted)
//    }
    
}

