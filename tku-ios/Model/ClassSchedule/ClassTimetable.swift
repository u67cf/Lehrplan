//
//  ClassTimetable.swift
//  tku-ios
//
//  Created by bochain on 3/24/24.
//

import SwiftUI

struct ClassTimetable: Identifiable {
    let id : UUID = .init()
    let UpdateTime: Date
    let ClassDatas: [ClassData]
}

struct ClassData: Identifiable{
    let id: UUID = .init()
    let time : String
    let name : String
    let number : String
    let location: String
    let teacher : String
    let weekday : String
}

/*
 id = UUID
 time = "8:50 - 9:00"
 name = "system and signal"
 number = "50"
 location = "E503"
 teacher = "Mr CHen"
 weekday = "(一)"
 */
