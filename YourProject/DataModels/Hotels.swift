//
//  Hotels.swift
//  YourProject
//
//  Created by IntrodexMini on 26/2/2568 BE.
//

typealias Hotels = Collection<Hotel>

//MARK: Computed properties
extension Hotels {
    
    var activeHotels: [Hotel] {
        return lists.filter { $0.status == "active" }
    }
    
    var hotelNames: [String] {
        return lists.map { $0.name }
    }
    
  
}

//MARK: Additional functions
extension Hotels {
 
    // Static function example
    static func createEmpty() -> Hotels {
        return Hotels(array: [])
    }
    
    func findHotel(byId id: Int) -> Hotel? {
        return lists.first { $0.id == id }
    }
    
    func findHotels(byStatus status: String) -> [Hotel] {
        return lists.filter { $0.status == status }
    }
    
    // Function with multiple parameters
    func findHotels(withName nameContains: String,
                    andStatus status: String? = nil) -> [Hotel] {
        return lists.filter { hotel in
            let nameMatches = hotel.name.lowercased().contains(nameContains.lowercased())
            let statusMatches = status == nil ? true : hotel.status == status
            return nameMatches && statusMatches
        }
    }
    
    // Mutating function example (if needed)
    mutating func addHotel(_ hotel: Hotel) {
        lists.append(hotel)
    }

    // Sort hotels by name (A-Z)
    func sortedByName(ascending: Bool = true) -> Hotels {
        return Hotels(array: lists.sorted { ascending ? $0.name < $1.name : $0.name > $1.name })
    }
    
    // Sort hotels by creation date
    func sortedByCreatedDate(ascending: Bool = true) -> Hotels {
        return Hotels(array: lists.sorted { ascending ? $0.createdAt > $1.createdAt : $0.createdAt < $1.createdAt })
    }
    
}
