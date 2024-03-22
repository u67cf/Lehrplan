//
//  getClassSchedule.swift
//  tku-ios
//
//

import Foundation
import SwiftDotenv

import SwiftDotenv

func getClassSchedle() {
    var request = URLRequest(url: URL(string: "https://sso.tku.edu.tw/ePortfolio/ilifeStuClass.cshtml")!,timeoutInterval: Double.infinity)
    request.addValue("", forHTTPHeaderField: "Cookie")

    request.httpMethod = "GET"

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        return
      }
      print(String(data: data, encoding: .utf8)!)
    }

    task.resume()

}
