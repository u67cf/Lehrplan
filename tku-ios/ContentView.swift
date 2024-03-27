//
//  ContentView.swift
//  tku-ios
//
//  Created by bochain on 3/20/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        Group {
            if horizontalSizeClass == .compact {
                // Use for smaller screens like iPhone
                iPhoneTabView()
            } else {
                // Use for larger screens like iPad
                iPadSidebarView()
            }
        }
    }

    @ViewBuilder
    private func iPhoneTabView() -> some View {
        TabView {
            SummaryView()
                .tabItem {
                    Label("Summary", systemImage: "heart.fill")
                }
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "folder")
                }
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
        }
    }

    @ViewBuilder
    private func iPadSidebarView() -> some View {
        // Implement a sidebar view suitable for iPad
        NavigationView {
            List {
                NavigationLink(destination: SummaryView()) {
                    Label("Summary", systemImage: "heart.fill")
                }
                NavigationLink(destination: BrowseView()) {
                    Label("Browse", systemImage: "folder")
                }
                NavigationLink(destination: AccountView()) {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Menu")
            
            // Default detail view
            SummaryView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
