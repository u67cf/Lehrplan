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
        if horizontalSizeClass == .regular {
            // iPad and some iPhone models in landscape might have .regular horizontal size class
            // iPad-specific or large-screen interface here
            iPadView()
        } else {
            // iPhone and compact environments
            iPhoneView()
        }
    }

    @ViewBuilder
    private func iPadView() -> some View {
        // Example iPad view using a split view approach
        NavigationView {
            List {
                NavigationLink("Summary", destination: SummaryView())
                
                NavigationLink("Account", destination: AccountView())
            }
            .navigationTitle("Menu")
            
        }
    }

    @ViewBuilder
    private func iPhoneView() -> some View {
        // Example iPhone view using TabView
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .modelContainer(previewContainer)
    }
}
