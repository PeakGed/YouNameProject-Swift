//
//  RoomTypeWithUnit.swift
//  YourProject
//
//  Created by IntrodexMini on 10/5/2568 BE.
//

struct RoomTypeWithUnit {
    let roomType: RoomType
    let rooms: Rooms
    
    init(roomType: RoomType,
         rooms: Rooms) {
        self.roomType = roomType
        self.rooms = rooms
    }
}
