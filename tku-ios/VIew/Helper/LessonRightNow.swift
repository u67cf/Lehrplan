//
//  LessonRightNow.swift
//  tku-ios
//
//  Created by bochain on 3/27/24.
//

import SwiftUI

import SwiftUI

struct LessonRightNow: View {
    var lessonData: ClassData  // Renamed for clarity
    
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
        // Create a sample instance of ClassData
        let sample = ClassData(
            weekday: "五",
            classNumber: "2",
            startTime: "8:10",
            EndTime: "9:00",
            name: "電子學",
            number: "053",
            location: "E503",
            teacher: "助教"
        )
        
        // Pass the sample instance to your LessonRightNow view
        LessonRightNow(lessonData: sample)
    }
}