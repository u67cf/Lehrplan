//
//  ClassScheduleView.swift
//  tku-ios
//
//  Created by bochain on 3/30/24.
//

import SwiftUI
import SwiftData

struct ClassScheduleView: View {
    @Query private var  ClassSchedule: [ClassData]
    @State private var currentDate : Date = .init()
    @Environment(\.modelContext) private var modelContext
    //@State private var sampleData = SampleData
    var body: some View {
        VStack {
            HeaderView()
            ScrollView (.vertical, showsIndicators: false){
                ForEach(ClassSchedule) { classInfo in
                    LessonRightNow(lessonData: classInfo)
                        .padding(.horizontal)
                }
            }
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        VStack(alignment: .leading) {
            HStack(spacing: 5) {
                Text(currentDate.formatted(Date.FormatStyle().weekday(.wide)))
            }
            .font(.title.bold())
            Text(currentDate.formatted(date: .complete, time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .textScale(.secondary)
                .foregroundStyle(.gray)
        }
        .padding(.init(top: 0, leading: 15, bottom: 15, trailing: 15))
        .hSpacing(.leading)
    }
}

#Preview {
    ClassScheduleView()
        .modelContainer(previewContainer)
        
}
