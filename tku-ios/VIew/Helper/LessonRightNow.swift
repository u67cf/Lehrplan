//
//  LessonRightNow.swift
//  tku-ios
//
//  Created by bochain on 3/27/24.
//

import SwiftUI

import SwiftUI

struct LessonRightNow: View {
    var lessonData: ClassData
    
    var body: some View {
        HStack (){
            VStack(alignment: .trailing, spacing: 6){
                Text(lessonData.startTime)
                Text(lessonData.EndTime)
            }
            .padding(3)
            Spacer()
            VStack{
                Text(lessonData.name)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .padding(15)
            VStack {
                Text(lessonData.location)
                Text(lessonData.number)
                    .font(.caption)
                Text(lessonData.teacher)
                    .font(.caption)
            }
            .padding(5)
        }
        .padding(5)
        .background(.blue.opacity(0.2).gradient)
        .cornerRadius(10)
    }
}


struct LessonRightNow_Previews: PreviewProvider {
    static var previews: some View {
        ClassScheduleView()
            .modelContainer(previewContainer)
    }
}
