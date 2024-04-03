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
                UserDefaults.standard.set(extractedText, forKey: "studentID")
                
                let currentTime = Date()
                UserDefaults.standard.set(currentTime, forKey: "lastUpdateTime")
                            
                // Confirmation of save operation
                print(UserDefaults.standard.object(forKey: "studentID") ?? "can't save id")
            }
        }
    }
}
