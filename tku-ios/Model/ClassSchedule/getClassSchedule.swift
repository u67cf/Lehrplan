//
//  getClassSchedule.swift
//  tku-ios
//
//
import Foundation
import SwiftData
import Kanna

func getClassSchedule(html: String, modelContext: ModelContext){
    if let doc = try?  Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
        do {
            try modelContext.delete(model: ClassData.self)
        } catch {
            print("Failed to clear all Country and City data.")
        }
        for num in stride(from: 0, to: 200, by: 1){
            var s_name = ""
            var s_time_string = ""
            var s_classid = ""
            var s_location = ""
            var s_teacher = ""
            for name in doc.xpath("/html/body/div[2]/div[2]/table/tbody/tr["+String(num)+"]/td[1]/p[1]") {
                print ("className", name.text!)
                s_name = name.text!
            }
            for timeString in doc.xpath("/html/body/div[2]/div[2]/table/tbody/tr["+String(num)+"]/td[1]/p[2]") {
                print ("classtime", timeString.text!)
                s_time_string = timeString.text!
            }
            for classID in doc.xpath("/html/body/div[2]/div[2]/table/tbody/tr["+String(num)+"]/td[2]/p[1]") {
                print ("classID", classID.text!)
                s_classid = classID.text!
            }
            for location in doc.xpath("/html/body/div[2]/div[2]/table/tbody/tr["+String(num)+"]/td[2]/p[2]/span[1]") {
                print ("location", location.text!)
                s_location = location.text!
            }
            for teacher in doc.xpath("/html/body/div[2]/div[2]/table/tbody/tr["+String(num)+"]/td[2]/p[2]/span[2]") {
                print ("teacher", teacher.text!)
                s_teacher = teacher.text!
            }
            
            if (s_name != "") {
                let newclassdata = ClassData(weekday: "", classNumber: "", startTime: s_time_string, EndTime: "", name: s_name, number: s_classid, location: s_location, teacher: s_teacher)
                modelContext.insert(newclassdata)
                print("add to database")
            }
        }
    }
}

func splitClassInfo(_ info: String) -> (weekday: String, lessonNumbers: String, timeRange: String)? {
    // Define the regex pattern to match the specific parts of the string
    let pattern = "\\((.+)\\) \\(([^)]+)\\) \\(([^)]+)\\)"
    
    do {
        let regex = try NSRegularExpression(pattern: pattern)
        let nsRange = NSRange(info.startIndex..., in: info)
        
        if let match = regex.firstMatch(in: info, options: [], range: nsRange) {
            let weekdayRange = Range(match.range(at: 1), in: info)!
            let lessonsRange = Range(match.range(at: 2), in: info)!
            let timeRange = Range(match.range(at: 3), in: info)!
            
           
            // Create strings from the extracted ranges
            let weekday = String(info[weekdayRange]) // "五"
            let lessons = String(info[lessonsRange]) // "06,07"
            let lessonTime = String(info[timeRange]) // ":10 ~ :00"
            return (weekday, lessons, lessonTime)
        }
    } catch {
        print("Invalid regex: \(error.localizedDescription)")
    }
    
    return nil
}

/*
 var weekday: String
 var classNumber : String
 var startTime : String
 var EndTime: String
 var name : String
 var number : String
 var location: String
 var teacher : String
 */

/*
 name
 time
 number
 location
 teacher
 */

//                                         *
// /html/body/div[2]/div[2]/table/tbody/tr[1]/td[1]/p[1]
// /html/body/div[2]/div[2]/table/tbody/tr[1]/td[1]/p[2]
// /html/body/div[2]/div[2]/table/tbody/tr[1]/td[2]/p[1]
// /html/body/div[2]/div[2]/table/tbody/tr[1]/td[2]/p[2]/span[1]
// /html/body/div[2]/div[2]/table/tbody/tr[1]/td[2]/p[2]/span[2]
