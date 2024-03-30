//
//  ClassScheduleView.swift
//  tku-ios
//
//  Created by bochain on 3/30/24.
//

import SwiftUI

struct ClassScheduleView: View {
    @State private var currentDate : Date = .init()
    @State private var sampleData = SampleData
    var body: some View {
        VStack {
            HeaderView()
            ScrollView {
                ForEach(sampleData) { classInfo in
                    LessonRightNow(lessonData: classInfo)
                        .padding(.horizontal)
                    
                }
            }
        }
        .vSpacing(.top)
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        VStack(alignment: .leading, spacing: 6) {
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
        .padding(15)
        .hSpacing(.leading)
    }
}

#Preview {
    ClassScheduleView()
        
}
