//
//  SummaryView.swift
//  tku-ios
//
//  Created by bochain on 3/20/24.
//

import SwiftUI
import SwiftData

struct SummaryView: View {
    @Query(filter: predicate(), animation: .snappy) private var  ClassSchedule: [ClassData]
    @Environment(\.modelContext) private var modelContext
    
    static func predicate() -> Predicate<ClassData> {
        let today = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today)
        
        // Map weekday numbers to Chinese characters
        // Sunday (1) to Saturday (7)
        let chineseDaysOfWeek = [
            1: "日", // Sunday
            2: "一", // Monday
            3: "二", // Tuesday
            4: "三", // Wednesday
            5: "四", // Thursday
            6: "五", // Friday
            7: "六"  // Saturday
        ]
        return #Predicate<ClassData> { $0.weekday == chineseDaysOfWeek[weekday] ?? "" }
    }
    
    var body: some View {
        
        NavigationView{
            List {
                HeaderView()
                Section(header: Text("Today's Lesson")){
                    LessonTodayView(ClassSchedule: ClassSchedule)
                }
            }
            .navigationTitle("Summary")
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        VStack(alignment: .trailing, spacing: 0) {
            HStack(spacing: 0) {
                Text(UserDefaults.standard.string(forKey: "studentID") ?? "YOUR STUDENT ID")
                
            }
            .font(.title.bold())
            Text(UserDefaults.standard.string(forKey: "lastUpdateTime") ?? "LAST TIME LOGIN")
                .font(.callout)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.gray)
        }
        .padding(.init(top: 0, leading: 15, bottom: 15, trailing: 15))
        .hSpacing(.trailing)
    }
}

#Preview {
    SummaryView()
        .modelContainer(previewContainer)
}
