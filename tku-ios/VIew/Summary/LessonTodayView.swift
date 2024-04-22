//
//  LessonTodayView.swift
//  tku-ios
//
//  Created by \u8b19 on 4/21/24.
//

import SwiftUI

import SwiftUI

struct LessonTodayView: View {
    var ClassSchedule: [ClassData]  // Assuming ClassData is your data model

    var body: some View {
        if ClassSchedule.count > 0 {
            VStack (spacing: 1){
                ForEach(ClassSchedule) { classInfo in
                    LessonRightNow(lessonData: classInfo)
                        .padding(.horizontal)
                }
            }
        } else {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("今天不用上課")
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
                Spacer()
            }
            .frame(height: 100)
        }
    }
}

