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
            VStack {
                ForEach(ClassSchedule) { classInfo in
                    LessonRightNow(lessonData: classInfo)
                        .padding(.horizontal)
                }
            }
            .safeAreaInset(edge: .top, spacing: 0) {
                HeaderView()
            }
            .padding()
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

