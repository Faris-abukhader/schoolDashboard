//
//  choosingTeacherView.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/12.
//

import SwiftUI

struct choosingTeacherView: View {
    @EnvironmentObject var data:data
    var body: some View {
        VStack{
            Text("It is work")
            
        }
        .frame(width: data.mainViewWidth/1.7, height: data.mainViewHeight/1.7)
        .background(Color("lightBlue"))
        .cornerRadius(10)
        .shadow(radius: 2)
        
    }
}

struct choosingTeacherView_Previews: PreviewProvider {
    static var previews: some View {
        choosingTeacherView()
    }
}
