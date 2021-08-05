//
//  studentAttendanceAnalysis.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/21.
//

import SwiftUI

struct studentAttendanceAnalysis: View {
    @Binding var gradeName:String
    @EnvironmentObject var data:data
    @FetchRequest(entity: Attendance.entity(), sortDescriptors: []) var attendances:FetchedResults<Attendance>
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students:FetchedResults<Student>
    var body: some View {
        ZStack(alignment: .topTrailing){
            VStack{
                Text("Attendance analysis for \(gradeName) :")
                    .bold()
                    .font(.title2)
                    .padding(10)
                
                ScrollView{
                    List{
                        ForEach(students.filter{
                            gradeName.isEmpty ? true:$0.garde!.contains(gradeName)
                        }){student in
                            analysisListItem(studentName: student.name!, gradeName: gradeName)
                        }
                        
                    }.frame(width: data.mainViewWidth - 50, height: data.mainViewWidth/1.5 )
                    .background(Color("lightBlue"))
                    .cornerRadius(10)
                    
                }.frame(width: data.mainViewWidth - 50, height: data.mainViewWidth/1.5)
                
                
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {data.showStudentAnalysis = false}, label: {
                        Text("Close")
                        .font(.footnote)
                        .foregroundColor(Color.white)
                        .padding(.horizontal ,10)
                        .padding(.vertical ,5)
                        .background(Color("yellow"))
                        .cornerRadius(5)
                        .padding()

                    })
                    Spacer()
                }
                
            }
            
            Button(action: {data.showStudentAnalysis = false}, label: {
                ZStack{
                    Rectangle()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.red)
                        .cornerRadius(50)
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(40)
                }
            })
            .offset(x: -6, y: 6)

            
            
        }.frame(width: data.mainViewWidth - 40, height: data.mainViewWidth)
        .background(Color("lightBlue"))
        .cornerRadius(15)
    }
}

struct studentAttendanceAnalysis_Previews: PreviewProvider {
    static var previews: some View {
        studentAttendanceAnalysis(gradeName: Binding.constant(""))
    }
}
struct analysisListItem:View{
    @State var studentName:String = ""
    @State var gradeName:String = ""
    @FetchRequest(entity: Attendance.entity(), sortDescriptors: []) var attendances:FetchedResults<Attendance>
    @EnvironmentObject var data:data
    var body: some View {
        VStack(alignment:.leading){
            Text(studentName)
                .bold()
                .font(.caption)
                .foregroundColor(.black)
                .padding(.bottom,5)
            
            
            Text("Total attendnaces : \(attendanceAnalyse(studentName:studentName)[0]) , Total absents : \(attendanceAnalyse(studentName:studentName)[1]) , attendance Rate : \(attendanceAnalyse(studentName:studentName)[0] > 0 ? String(format: "%.2f", (Double.init( attendanceAnalyse(studentName:studentName)[0])/Double.init(attendanceAnalyse(studentName:studentName)[0]+attendanceAnalyse(studentName:studentName)[1]))*100)  : "0") %")
                .font(.custom("", size: 8))
                .foregroundColor(Color(.lightGray))

        }.onTapGesture {
            data.showStudentAttendanceDetail = true
            data.studentNameForAttendanceDetail = studentName
        }
    }
    
    func attendanceAnalyse(studentName:String)->[Int]{
        var result = Array<Int>()
        var attends = 0
        var absents = 0
        for attend in attendances {
            if attend.gradeName! == gradeName {
                for item  in attend.allAttend {
                    if item.studentName == studentName {
                        if item.doesAttend {
                            attends+=1
                        }else{
                            absents+=1
                        }
                    }
                }
            }
        }
        result.append(attends)
        result.append(absents)
        return result
    }
}
