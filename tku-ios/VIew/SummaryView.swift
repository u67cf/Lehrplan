//
//  SummaryView.swift
//  tku-ios
//
//  Created by bochain on 3/20/24.
//

import SwiftUI
import SwiftData

struct SummaryView: View {
    @Query private var  ClassSchedule: [ClassData]
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        ScrollView {
            LessonRightNow(lessonData: ClassSchedule[0])
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            HeaderView()
        }
        .vSpacing(.top)
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
