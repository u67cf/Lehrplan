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
            getClassSchedule(html: String(data: data, encoding: .utf8) ?? "")
            print("finish")
        } else if let error = error {
            // Handle the error
            print("HTTP Request Failed \(error)")
        }
    }.resume()
}
