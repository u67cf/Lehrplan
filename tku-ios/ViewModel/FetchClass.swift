//
//  FetchClass.swift
//  tku-ios
//
//  Created by bochain on 3/22/24.
//

import Foundation
import Kanna

// Now we pass 'cookies' as a parameter to the function
func makeAuthenticatedRequest(url: URL, cookies: [HTTPCookie]) {
    var request = URLRequest(url: url)
    
    // Create a cookie header string from the retrieved cookies
    let cookieHeader = HTTPCookie.requestHeaderFields(with: cookies)["Cookie"]
    // Set the cookie header in your request
    request.setValue(cookieHeader, forHTTPHeaderField: "Cookie")

    // Now you can use this request for URLSession tasks, Alamofire requests, etc.
    URLSession.shared.dataTask(with: request) { data, response, error in
        // Handle the HTTP response here
        if let data = data {
            // Process the data
            print(String(data: data, encoding: .utf8) ?? "No data")
            getClasssInfo(html: String(data: data, encoding: .utf8) ?? "")
            print("finish")
        } else if let error = error {
            // Handle the error
            print("HTTP Request Failed \(error)")
        }
    }.resume()
}

func getClasssInfo(html: String){
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
