//
//  ClassTimetable.swift
//  tku-ios
//
//  Created by bochain on 3/24/24.
//

import SwiftUI


struct ClassData: Identifiable{
    let id: UUID = .init()
    let weekday: String
    let classNumber : String
    let startTime : String
    let EndTime: String
    let name : String
    let number : String
    let location: String
    let teacher : String
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
let SampleData : [ClassData] = [
    .init(weekday: "五", classNumber: "1", startTime: "8:10", EndTime: "9:00", name: "電子學", number: "069", location: "E503", teacher: "助教"),
    .init(weekday: "五", classNumber: "2", startTime: "9:10", EndTime: "9:00", name: "電子學", number: "069", location: "E503", teacher: "助教"),
    .init(weekday: "五", classNumber: "3", startTime: "10:00", EndTime: "9:00", name: "電子學", number: "069", location: "E503", teacher: "助教"),
    .init(weekday: "五", classNumber: "4", startTime: "11:00", EndTime: "9:00", name: "電子學", number: "069", location: "E503", teacher: "助教"),
]
