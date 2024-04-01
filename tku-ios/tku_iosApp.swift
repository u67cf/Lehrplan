//
//  tku_iosApp.swift
//  tku-ios
//
//  Created by bochain on 3/20/24.
//

import SwiftUI
import SwiftData

@main
struct tku_iosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(previewContainer)
        }
    }
}
