//
//  addNewClass.swift
//  schoolDashboard
//
//  Created by admin on 2021/3/2.
//

import SwiftUI

struct addNewClass: View {
    @State var gradeName = ""
    @State var grade = ""
    var body: some View {
        VStack{
       
            HStack{
                VStack(alignment: .leading){
                    Text("Grade Name :")
                    TextField("grade name...", text: $gradeName)
                }
                VStack(alignment: .leading){
                    Text("Grade :")
                    TextField("grade", text: $grade)
                }
            }
            HStack{
                Spacer()
                Button(action: {}, label: {
                    Text("add")
                        .padding(5)
                        .padding(.horizontal,15)
                        .background(Color("yellow"))
                        .cornerRadius(15)
                })
                Spacer()
            }
            

        }
        
        
        

    }
}

struct addNewClass_Previews: PreviewProvider {
    static var previews: some View {
        addNewClass()
    }
}
