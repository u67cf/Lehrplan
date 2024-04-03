//
//  getClassSchedule.swift
//  tku-ios
//
//
import Foundation
import Kanna

func getClassSchedule(html: String){
    if let doc = try?  Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
        for num in stride(from: 0, to: 200, by: 1){
            for name in doc.xpath("/html/body/div[2]/div[2]/table/tbody/tr["+String(num)+"]/td[1]/p[1]") {
                print ("className", name.text!)
            }
            for timeString in doc.xpath("/html/body/div[2]/div[2]/table/tbody/tr["+String(num)+"]/td[1]/p[2]") {
                print ("classtime", timeString.text!)
            }
            for classID in doc.xpath("/html/body/div[2]/div[2]/table/tbody/tr["+String(num)+"]/td[2]/p[1]") {
                print ("classID", classID.text!)
            }
            for location in doc.xpath("/html/body/div[2]/div[2]/table/tbody/tr["+String(num)+"]/td[2]/p[2]/span[1]") {
                print ("location", location.text!)
            }
            for teacher in doc.xpath("/html/body/div[2]/div[2]/table/tbody/tr["+String(num)+"]/td[2]/p[2]/span[2]") {
                print ("teacher", teacher.text!)
            }
        }
    }
}
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
