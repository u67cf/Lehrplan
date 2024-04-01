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
        LessonRightNow(lessonData: ClassSchedule[0])
    }
}

#Preview {
    SummaryView()
}
