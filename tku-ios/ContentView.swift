//
//  ContentView.swift
//  tku-ios
//
//  Created by bochain on 3/20/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SummaryView()
                .tabItem {
                    Label("Summary", systemImage: "heart.fill")
                }
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "folder")
                }
            SummaryView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
