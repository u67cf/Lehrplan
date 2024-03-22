//
//  BrowseView.swift
//  tku-ios
//
//  Created by bochain on 3/20/24.
//

import SwiftUI

struct BrowseView: View {
    var body: some View {
        NavigationView {
            List {
                
                NavigationLink(destination: CalendarView()) {
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
                NavigationLink(destination: CalendarView()) {
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
            .navigationTitle("Browse")
        }
    }
}

#Preview {
    BrowseView()
}
