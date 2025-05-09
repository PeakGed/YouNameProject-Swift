//
//  HotelShorts.swift
//  YourProject
//
//  Created by IntrodexMini on 9/5/2568 BE.
//

//
//  HotelShorts.swift
//  YourProject
//
//  Created by IntrodexMini on 26/2/2568 BE.
//

typealias HotelShorts = Collection<HotelShort>

//MARK: Computed properties
extension HotelShorts {
    
    enum SortBy: String {
        case id
        case name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
      
    var hotelNames: [String] {
        return lists.map { $0.name }
    }
          
}
