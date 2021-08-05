//
//  reviewGradeStudent.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/13.
//

import SwiftUI

struct reviewGradeStudent: View {
    @Binding var grade:String
    @EnvironmentObject var data:data
    @State var searchGradeStudent = ""
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students:FetchedResults<Student>
    var body: some View {
        ZStack{
            if data.showStudentInfoForTeacher{
                    studentDetails(student: data.studentDetail)
            } else {
        VStack{
            ScrollView(showsIndicators: false){
            HStack{
                Text("\(grade)")
                    .bold()
                    .font(.title)
                    .padding()
                Spacer()
                
            }
            Path(CGPath(roundedRect: CGRect(x: 0, y: 0, width: data.mainViewWidth, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil))
            
            
            HStack{
                Button(action: {data.showGradeInfoView=false}, label: {
                Image(systemName: "arrow.left.circle.fill").foregroundColor(Color("darkBlue"))
                Text("Go back").bold().font(.title3).foregroundColor(Color("darkBlue")).padding(.trailing,40)
                })
                Spacer()
                
                
                TextField("search student name...", text: $searchGradeStudent)
                    .font(.caption)
                    .frame(width: 150, height: 20)
                    .padding(5)
                    .background(Color("lightGry"))
                    .cornerRadius(15)


            }.padding(.top)
            
            
                tableHeader(field:"student")
            List{
                ForEach(students.filter{
                    grade.isEmpty ? true:$0.garde!.contains(grade)
                }.filter{
                    searchGradeStudent.isEmpty ? true : $0.name!.contains(searchGradeStudent)
                }){student in
                    studentTable(student: student,isAdmin: false)

                }
            }
            .cornerRadius(15)
            .frame(width:data.mainViewWidth-40,height: data.height/1.2)


        }
       }
        }
            if data.showStudentEdit {
                editStudentWindow()
            }
    }
    }
}

struct reviewGradeStudent_Previews: PreviewProvider {
    static var previews: some View {
        reviewGradeStudent(grade: Binding.constant(""))
    }
}
