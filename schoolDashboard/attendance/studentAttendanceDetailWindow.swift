//
//  studentAttendanceDetailWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/24.
//

import SwiftUI

struct studentAttendanceDetailWindow: View {
    @EnvironmentObject var data:data
    var body: some View {
        ZStack(alignment:.topTrailing) {

            
            
            
        }
       .frame(width: data.mainViewWidth/2, height: data.mainViewWidth/2)
       .background(Color("lightBlue"))
       .cornerRadius(15)
       .shadow(radius: 1)

    }
}

struct studentAttendanceDetailWindow_Previews: PreviewProvider {
    static var previews: some View {
        studentAttendanceDetailWindow()
    }
}
