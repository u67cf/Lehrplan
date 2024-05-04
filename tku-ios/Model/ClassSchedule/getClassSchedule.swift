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
                  let s_time = extractClassTimes(doc: doc, num: num),
                  let s_classid = extractClassID(doc: doc, num: num),
                  let s_location = extractLocation(doc: doc, num: num),
                  let s_weekday = extractWeekday(doc: doc, num: num),
                  let s_teacher = extractTeacher(doc: doc, num: num)else {
                continue // Skip this iteration if any data is missing
            }
            
            let newClassData = ClassData(weekday: s_weekday, classNumber: "", startTime: s_time.startTime, EndTime: s_time.endTime, name: s_name, number: s_classid, location: s_location, teacher: s_teacher)
            modelContext.insert(newClassData)
            print("Added to database")
        }
    }
}

func extractClassName(doc: HTMLDocument, num: Int) -> String? {
    let xpath = "/html/body/div[2]/div[2]/table/tbody/tr[\(num)]/td[1]/p[1]"
    return doc.at_xpath(xpath)?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
}

func extractClassTimes(doc: HTMLDocument, num: Int) -> (startTime: String, endTime: String)? {
    let xpath = "/html/body/div[2]/div[2]/table/tbody/tr[\(num)]/td[1]/p[2]"
    
    // Attempt to get the raw text from the specified XPath
    if let rawTime = doc.at_xpath(xpath)?.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
        // Regex for clean time format "04 (11:10 ~ 12:00)"
        let cleanTimeRegex = try? NSRegularExpression(pattern: "(\\d+) \\((\\d{2}:\\d{2}) ~ (\\d{2}:\\d{2})\\)")
        
        // Attempt to match the clean time format
        if let cleanTimeMatch = cleanTimeRegex?.firstMatch(in: rawTime, options: [], range: NSRange(location: 0, length: rawTime.utf16.count)),
           let startTimeRange = Range(cleanTimeMatch.range(at: 2), in: rawTime),
           let endTimeRange = Range(cleanTimeMatch.range(at: 3), in: rawTime) {
            
            let startTime = String(rawTime[startTimeRange])
            let endTime = String(rawTime[endTimeRange])
            return (startTime, endTime)
        }
        
        // Regex for the old time format where only minutes are given
        let timeRegex = try? NSRegularExpression(pattern: "\\(:([0-5]?\\d) ~ :([0-5]?\\d)\\)")
        let classRegex = try? NSRegularExpression(pattern: "(\\d+)(?:,(\\d+))?")
        
        // Attempt to match the old time format
        if let timeMatch = timeRegex?.firstMatch(in: rawTime, options: [], range: NSRange(location: 0, length: rawTime.utf16.count)),
           let startTimeRange = Range(timeMatch.range(at: 1), in: rawTime),
           let endTimeRange = Range(timeMatch.range(at: 2), in: rawTime),
           let classMatch = classRegex?.firstMatch(in: rawTime, options: [], range: NSRange(location: 0, length: rawTime.utf16.count)) {
           
            let startTimeMinute = String(rawTime[startTimeRange])
            let endTimeMinute = String(rawTime[endTimeRange])
            
            let firstClassNumber = Int((rawTime as NSString).substring(with: classMatch.range(at: 1)))!
            let startTime = "\(firstClassNumber + 7):\(startTimeMinute)"
            var endTime = "\(firstClassNumber + 8):\(endTimeMinute)"

            // Handle if there is a range of class numbers
            if classMatch.range(at: 2).location != NSNotFound {
                let lastClassNumber = Int((rawTime as NSString).substring(with: classMatch.range(at: 2)))!
                endTime = "\(lastClassNumber + 8):\(endTimeMinute)"
            }

            return (startTime, endTime)
        }
    }
    // Return nil if no formats match
    return nil
}
//("00:00", "00.00")


func extractClassEndTime(doc: HTMLDocument, num: Int) -> String? {
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
