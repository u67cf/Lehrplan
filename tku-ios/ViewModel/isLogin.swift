//
//  isLogin.swift
//  tku-ios
//
//  Created by bochain on 3/24/24.
//

import Foundation
import Kanna

func isLogin(url: URL, cookies: [HTTPCookie], completion: @escaping (Bool) -> Void){
    var request = URLRequest(url: url)
    
    let cookieHeader = HTTPCookie.requestHeaderFields(with: cookies)["Cookie"]
    request.setValue(cookieHeader, forHTTPHeaderField: "Cookie")
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data, let html = String(data: data, encoding: .utf8) {
            // Use the getLoginInfo function to determine the login status based on the HTML content
            let isLoggedIn = getLoginInfo(html: html)
            DispatchQueue.main.async {
                completion(isLoggedIn)
            }
        } else if let error = error {
            print("HTTP Request Failed \(error)")
            DispatchQueue.main.async {
                completion(false) // Assuming failed request means not logged in
            }
        }
    }.resume()
}

func getLoginInfo(html: String) -> Bool {
    if let doc = try? Kanna.HTML(html: html, encoding: .utf8) {
        // Assuming you're interested in a specific message from the HTML body
        // Adjust the XPath as needed to target the correct element
        for message in doc.xpath("/html/body") {
            print(message.text!)
            if let messageText = message.text, messageText.count > 20 {
                print("no login")
                return false // Assuming that a message longer than 20 characters means not logged in
            }
        }
    }
    return true // If no message is found or all messages are shorter than 20 characters, assume logged in
}


// /html/body
// /html/body
// /html/body/div[1]/form/div[1]/h3
