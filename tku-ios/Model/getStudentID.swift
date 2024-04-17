//
//  getStudentID.swift
//  tku-ios
//
//  Created by bochain on 4/3/24.
//

import Foundation
import Kanna

func getStudentID(html: String){
    if let doc = try?  Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
        for id in doc.xpath("/html/body") {
            if let extractedText = id.text {
                print("Extracted Text:", extractedText)
                // Save the extracted text to UserDefaults
                if let number = extractNumber(from: extractedText) {
                    UserDefaults.standard.set(number, forKey: "studentID")
                    print(UserDefaults.standard.object(forKey: "studentID") ?? "can't save id")
                    let currentTime = Date()
                    UserDefaults.standard.set(currentTime, forKey: "lastUpdateTime")
                } else {
                    print("No number found in the string.")
                }
            }
        }
    }
}

func extractNumber(from string: String) -> String? {
    let pattern = "\\d+"
    
    do {
        let regex = try NSRegularExpression(pattern: pattern)
        let results = regex.matches(in: string, range: NSRange(string.startIndex..., in: string))
        
        // Assuming you want the first match only.
        if let match = results.first {
            let range = Range(match.range, in: string)
            return String(string[range!])
        }
    } catch let error {
        print("Invalid regex: \(error.localizedDescription)")
    }
    
    return nil
}
