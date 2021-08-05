//
//  studentMain.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/15.
//

import SwiftUI
import CoreData

struct studentMain: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Attendance.entity(), sortDescriptors: []) private var attendances:FetchedResults<Attendance>
    var body: some View {
        VStack{
            
            Text("hello from student main page")
                .bold()
                .font(.title)
                .foregroundColor(.black)
        }
    }
    
    

}

struct studentMain_Previews: PreviewProvider {
    static var previews: some View {
        studentMain()
    }
}
