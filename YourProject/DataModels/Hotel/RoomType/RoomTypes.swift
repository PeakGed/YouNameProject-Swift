//
//  RoomTypes.swift
//  YourProject
//
//  Created by IntrodexMini on 27/2/2568 BE.
//

typealias RoomTypes = Collection<RoomType>

// MARK: Computed properties
extension RoomTypes {

}

// MARK: - Functions
extension RoomTypes {
    
    func filter(byID: Int) -> RoomType? {
        lists.filter({ $0.id == byID }).first
    }
    
    func sorted() -> RoomTypes {
        let sorted = lists.sorted(by: { $0.name < $1.name })
        return .init(array: sorted)
    }
    
    func roomType(matchUnitID: Int) -> RoomType? {
        let filtered = lists.filter({
            $0.rooms.filter(unitIDs: [matchUnitID]).count > 0
        })
        return filtered.first
    }
    
    func filter(unitIDs: Set<Int>) -> RoomTypes {
        let filtered = lists.filter({
            let existUnitIDs = $0.rooms.uniqueIDs
            return unitIDs.intersection(existUnitIDs).count > 0
        })
        return .init(array: filtered)
    }
    
    // return unitType contain units.count > 0
    func filter(status: Room.Status) -> RoomTypes {
        let filtered = lists.filter({
            let existUnits = $0.rooms.filter(status: status)
            return existUnits.count > 0
        })
        return .init(array: filtered)
    }
}

