//
//  ReservationWithItems.swift
//  YourProject
//
//  Created by IntrodexMini on 17/5/2568 BE.
//

struct ReservationWithItems: Decodable {
    let reservation: Reservation
    let items: ReservationItems
}
