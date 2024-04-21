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
            print("Failed to clear data.")
        }
        for num in stride(from: 0, to: 200, by: 1){
            guard let s_name = extractClassName(doc: doc, num: num),
                  let s_time_string = extractClassTime(doc: doc, num: num),
                  let s_classid = extractClassID(doc: doc, num: num),
                  let s_location = extractLocation(doc: doc, num: num),
                  let s_weekday = extractWeekday(doc: doc, num: num),
                  let s_teacher = extractTeacher(doc: doc, num: num)else {
                continue // Skip this iteration if any data is missing
            }
            
            let newClassData = ClassData(weekday: s_weekday, classNumber: "", startTime: s_time_string, EndTime: "", name: s_name, number: s_classid, location: s_location, teacher: s_teacher)
            modelContext.insert(newClassData)
            print("Added to database")
        }
    }
}

func extractClassName(doc: HTMLDocument, num: Int) -> String? {
    let xpath = "/html/body/div[2]/div[2]/table/tbody/tr[\(num)]/td[1]/p[1]"
    return doc.at_xpath(xpath)?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
}

func extractClassTime(doc: HTMLDocument, num: Int) -> String? {
    let xpath = "/html/body/div[2]/div[2]/table/tbody/tr[\(num)]/td[1]/p[2]"
    return doc.at_xpath(xpath)?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
}

func extractWeekday(doc: HTMLDocument, num: Int) -> String? {
    let xpath = "/html/body/div[2]/div[2]/table/tbody/tr[\(num)]/td[1]/p[2]"
    if let rawTime = doc.at_xpath(xpath)?.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
        // Use a regular expression to extract characters inside the first parentheses
        let regex = try? NSRegularExpression(pattern: "\\(([^)]+)\\)")
        if let match = regex?.firstMatch(in: rawTime, options: [], range: NSRange(location: 0, length: rawTime.utf16.count)),
            let range = Range(match.range(at: 1), in: rawTime) {
            return String(rawTime[range])
        }
    }
    return nil
}

func extractClassID(doc: HTMLDocument, num: Int) -> String? {
    let xpath = "/html/body/div[2]/div[2]/table/tbody/tr[\(num)]/td[2]/p[1]"
    if let rawClassID = doc.at_xpath(xpath)?.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
        // Use a regular expression to remove non-numeric characters
        let regex = try? NSRegularExpression(pattern: "\\d+")
        if let match = regex?.firstMatch(in: rawClassID, options: [], range: NSRange(location: 0, length: rawClassID.utf16.count)),
           let range = Range(match.range, in: rawClassID) {
            return String(rawClassID[range])
        }
    }
    return nil
}

func extractLocation(doc: HTMLDocument, num: Int) -> String? {
    let xpath = "/html/body/div[2]/div[2]/table/tbody/tr[\(num)]/td[2]/p[2]/span[1]"
    return doc.at_xpath(xpath)?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
}

func extractTeacher(doc: HTMLDocument, num: Int) -> String? {
    let xpath = "/html/body/div[2]/div[2]/table/tbody/tr[\(num)]/td[2]/p[2]/span[2]"
    return doc.at_xpath(xpath)?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
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
