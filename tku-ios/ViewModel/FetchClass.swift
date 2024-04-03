//
//  FetchClass.swift
//  tku-ios
//
//  Created by bochain on 3/22/24.
//

import Foundation

// Updated to include a completion handler that passes HTML data as a String
func makeAuthenticatedRequest(url: URL, cookies: [HTTPCookie], completion: @escaping (String) -> Void) {
    var request = URLRequest(url: url)
    
    // Create and set the cookie header
    let cookieHeader = HTTPCookie.requestHeaderFields(with: cookies)["Cookie"]
    request.setValue(cookieHeader, forHTTPHeaderField: "Cookie")
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        // Check for errors
        if let error = error {
            print("HTTP Request Failed \(error)")
            return
        }
        
        // Process and pass the data to the completion handler
        if let data = data, let htmlData = String(data: data, encoding: .utf8) {
            completion(htmlData)
        } else {
            print("No data received")
            completion("")
        }
    }.resume()
}

