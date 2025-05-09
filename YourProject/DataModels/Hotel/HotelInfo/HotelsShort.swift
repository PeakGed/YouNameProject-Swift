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

typealias HotelsShort = Collection<HotelShort>

//MARK: Computed properties
extension HotelsShort {

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

//MARK: Additional functions
extension HotelsShort {
    
    func sortedBy(
        by: SortBy = .name,
        orderBy: SortOrderBy = .ascending
    ) -> HotelsShort {
        switch by {
        case .name:
            let result = lists.sorted(by: {
                switch orderBy {
                case .descending:
                    return $0.name < $1.name
                case .ascending:
                    return $0.name > $1.name
                }
            })
            return HotelsShort(array: result)

        case .id:
            let result = lists.sorted(by: {
                switch orderBy {
                case .descending:
                    return $0.id < $1.id
                case .ascending:
                    return $0.id > $1.id
                }
            })
            return HotelsShort(array: result)
        case .createdAt:
            let result = lists.sorted(by: {
                switch orderBy {
                case .descending:
                    return $0.createdAt < $1.createdAt
                case .ascending:
                    return $0.createdAt > $1.createdAt
                }
            })
            return HotelsShort(array: result)
        case .updatedAt:
            let result = lists.sorted(by: {
                switch orderBy {
                case .descending:
                    return $0.updatedAt < $1.updatedAt
                case .ascending:
                    return $0.updatedAt > $1.updatedAt
                }
            })
            return HotelsShort(array: result)

        }
    }
}
