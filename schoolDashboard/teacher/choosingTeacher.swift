//
//  choosingTeacher.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/12.
//

import SwiftUI

struct choosingTeacher: View {
    @EnvironmentObject var data:data
    @FetchRequest(entity: Teacher.entity(), sortDescriptors: []) private var teachers:FetchedResults<Teacher>
    var body: some View {
        VStack{
            theHeader()
                .padding(.bottom,10)
            HStack{
                Text("Choose One Teacher :")
                    .bold()
                    .foregroundColor(Color("yellow"))
                    .font(.title2)
                    .padding(.leading)
                    Spacer()

            }
            ScrollView{
            ForEach(teachers){teacher in
                choosingTeacherListItem(teacher: teacher)
            }
            }.padding(.top)
        }
        .frame(width: data.mainViewWidth/1.7, height: data.mainViewHeight/1.7)
        .background(Color("lightBlue"))
        .cornerRadius(10)
        .shadow(radius: 2)

    }
}

struct choosingTeacher_Previews: PreviewProvider {
    static var previews: some View {
        choosingTeacher()
    }
}
struct choosingTeacherListItem:View{
    @State var teacher:Teacher
    @EnvironmentObject var data:data
    var body: some View{
        Button(action: {data.TeacherChosedForAddingGrade=teacher.name!}, label: {
            HStack{
                Text(teacher.name!)
                    .padding(.leading)
                    .foregroundColor(Color.black)
                    .font(.caption)
                Spacer()
                Image(systemName: "checkmark.square.fill")
                    .resizable()
                    .frame(width:data.show ? 10 : 15, height: data.show ? 10 : 15)
                    .foregroundColor(data.TeacherChosedForAddingGrade==teacher.name! ? .red:.gray)
                    .padding(.trailing)
            }
            .frame(width: data.mainViewWidth/1.7-20,height: 30)
            .background(Color.white)
            .cornerRadius(5)

        })
    }
}
struct theHeader:View{
    @EnvironmentObject var data:data
    var body: some View{
        HStack{
            Button(action: {data.showChoosingTeacherForAddingGrade=false}, label: {
                Text("Back")
                    .foregroundColor(Color("yellow"))
                    .padding(.leading)
                    .padding(.top,10)
            })
            Spacer()
            Button(action: {data.showChoosingTeacherForAddingGrade=false}, label: {
                Text("Done")
                    .foregroundColor(Color("yellow"))
                    .padding(.trailing)
                    .padding(.top,10)
            })
        }
    }
}
