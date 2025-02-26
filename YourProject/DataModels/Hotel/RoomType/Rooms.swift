//
//  Rooms.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

typealias Rooms = Collection<Room>

// MARK: Computed properties
extension Rooms {

    var uniqueIDs: Set<Int> {
        Set(lists.map({ $0.id }))
    }
    
    var codes: [String] {
        lists.map({ $0.code })
    }
    
}

// MARK: - Functions
extension Rooms {

    func sorted() -> Rooms {
        let sorted = lists.sorted(by: { $0.code < $1.code })
        return .init(array: sorted)
    }
    
    func filter(unitIDs: Set<Int>) -> Rooms {
        let filtered = lists.filter({ unitIDs.contains($0.id) })
        return .init(array: filtered)
    }
    
    func filter(status: Room.Status) -> Rooms {
        let filtered = lists.filter({ $0.status == status })
        return .init(array: filtered)
    }
    
    func unit(matchID: Int) -> Room? {
        return lists.first(where: { $0.id == matchID })
    }

}
