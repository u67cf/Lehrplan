//
//  ClassTimetable.swift
//  tku-ios
//
//  Created by bochain on 3/24/24.
//

import SwiftUI
import SwiftData

@Model
class ClassData {
    var weekday: String
    var classNumber : String
    var startTime : String
    var EndTime: String
    var name : String
    var number : String
    var location: String
    var teacher : String
    
    init(weekday: String, classNumber: String, startTime: String, EndTime: String, name: String, number: String, location: String, teacher: String) {
        self.weekday = weekday
        self.classNumber = classNumber
        self.startTime = startTime
        self.EndTime = EndTime
        self.name = name
        self.number = number
        self.location = location
        self.teacher = teacher
    }
}

let SampleData : [ClassData] = [
    .init(weekday: "五", classNumber: "1", startTime: "8:10", EndTime: "9:00", name: "電子學", number: "069", location: "E503", teacher: "助教"),
    .init(weekday: "五", classNumber: "2", startTime: "9:10", EndTime: "9:00", name: "電子學", number: "069", location: "E503", teacher: "助教"),
    .init(weekday: "五", classNumber: "3", startTime: "10:10", EndTime: "9:00", name: "電子學", number: "069", location: "E503", teacher: "助教"),
    .init(weekday: "五", classNumber: "4", startTime: "11:10", EndTime: "9:00", name: "電子學", number: "069", location: "E503", teacher: "助教"),
    .init(weekday: "五", classNumber: "5", startTime: "13:10", EndTime: "14:00", name: "電子學", number: "069", location: "E503", teacher: "助教"),
]
