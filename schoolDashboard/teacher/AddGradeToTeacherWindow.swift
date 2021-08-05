//
//  AddGradeToTeacherWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/12.
//

import SwiftUI

struct AddGradeToTeacherWindow: View {
    @EnvironmentObject var data:data
    @State var teachers = ["fares","obada","raed","kefah"]
    @State var selectedTeacher = ""
    @State var showTeacherList = false
    var body: some View {
        ZStack{
        VStack{

            HStack(){
                Text("Choose the teacher :")
                    .bold()
                    .font(.title2)
                    .foregroundColor(Color("yellow"))
                    .padding(.top)
                    .padding(.leading)
                Spacer()
            }
                    
            Button(action: {data.showChoosingTeacherForAddingGrade=true}, label: {
                HStack{
                Text("Teachers : \(data.TeacherChosedForAddingGrade)")
                    .foregroundColor(.white)
                    .padding(.leading)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 8, height: 6)
                        .foregroundColor(.white)
                        .padding(.trailing)
                }
                })
            .padding(.vertical,10)
            .background(Color(.darkGray))
            .cornerRadius(5)
            .padding(.horizontal,10)
            
            HStack(){
                Text("Choose the Grade(s) :")
                    .bold()
                    .font(.title2)
                    .foregroundColor(Color("yellow"))
                    .padding(.leading)
                Spacer()
                
            }
            
            
            
            
            Button(action: {data.showChoosingGrade=true}, label: {
                HStack{
                Text("Grade(s) : ")
                    .foregroundColor(.white)
                    .padding(.leading)
                    Spacer()
                    Image(systemName: !data.TeacherChosedForAddingGrade.isEmpty ?"chevron.right":"exclamationmark.circle")
                        .resizable()
                        .frame(width: 8, height:!data.TeacherChosedForAddingGrade.isEmpty ? 6:8)
                        .foregroundColor(.white)
                        .padding(.trailing)
                }
                })
            .padding(.vertical,10)
            .background(Color(.darkGray))
            .cornerRadius(5)
            .padding(.horizontal,10)
            .disabled(data.TeacherChosedForAddingGrade.isEmpty)



            Spacer()

            HStack{
                Spacer()
                Button(action: {
                    data.showAddGradeToTeacher=false
                    data.TeacherChosedForAddingGrade = ""
                }, label: {
                    Text("Done")
                        .foregroundColor(Color.white)
                        .font(.footnote)
                        .padding(5)
                        .padding(.horizontal,30)
                        .background(Color("yellow"))
                        .cornerRadius(10)
                        .padding(.bottom)

                })
                Spacer()

            }
            .padding(.bottom)
            
                }
            
            if data.showChoosingTeacherForAddingGrade {
            choosingTeacher()

            }
            
            if data.showChoosingGrade {
                choosingGrade()
            }

    }
        .frame(width: data.mainViewWidth/1.7, height: data.mainViewHeight/1.7)
        .background(Color("lightBlue"))
        .cornerRadius(10)
        .shadow(radius: 2)
        Button(action: {
                data.showAddGradeToTeacher = false
                data.showChoosingTeacherForAddingGrade=false
                data.showChoosingGrade=false
                data.TeacherChosedForAddingGrade = ""
        }, label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color("darkBlue"))
        })
        .offset(x: data.mainViewWidth/3, y: -data.mainViewHeight/3)

    }
}

struct AddGradeToTeacherWindow_Previews: PreviewProvider {
    static var previews: some View {
        AddGradeToTeacherWindow()
    }
}
