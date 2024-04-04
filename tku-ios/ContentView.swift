//
//  ContentView.swift
//  tku-ios
//
//  Created by bochain on 3/20/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var isContainersSectionExpanded: Bool = true
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
                
                DisclosureGroup("Browse", isExpanded: $isContainersSectionExpanded) {
                    NavigationLink(destination: ClassScheduleView()) {
                        Label(
                            title: { Text("課表") },
                            icon: { Image(systemName: "calendar.day.timeline.left")}
                        )
                    }
                    NavigationLink(destination: CalendarView()) {
                        Label(
                            title: { Text("行事曆") },
                            icon: { Image(systemName: "calendar")}
                        )
                    }
                    NavigationLink(destination: PassView()) {
                        Label(
                            title: { Text("圖書館") },
                            icon: { Image(systemName: "books.vertical.fill") }
                        )
                    }
                    NavigationLink(destination: CalendarView()) {
                        Label(
                            title: { Text("無線網路") },
                            icon: { Image(systemName: "wifi")}
                        )
                    }
                    NavigationLink(destination: CalendarView()) {
                        Label(
                            title: { Text("動態資訊") },
                            icon: { Image(systemName: "info.circle.fill")}
                        )
                    }
                    NavigationLink(destination: CalendarView()) {
                        Label(
                            title: { Text("安全校園") },
                            icon: { Image(systemName: "shield.lefthalf.filled")}
                        )
                    }
                    NavigationLink(destination: CalendarView()) {
                        Label(
                            title: { Text("校園資訊") },
                            icon: { Image(systemName: "map.fill")}
                        )
                    }
                    NavigationLink(destination: CalendarView()) {
                        Label(
                            title: { Text("淡江時報") },
                            icon: { Image(systemName: "newspaper.fill")}
                        )
                    }
                }
                    
            }
            .navigationTitle("Menu")
            .listStyle(SidebarListStyle())
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
