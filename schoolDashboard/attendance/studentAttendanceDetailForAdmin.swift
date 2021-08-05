//
//  studentAttendanceDetailForAdmin.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/24.
//

import SwiftUI

struct studentAttendanceDetailForAdmin: View {
    @EnvironmentObject var data:data
    @FetchRequest(entity: Attendance.entity(), sortDescriptors: []) var attendances:FetchedResults<Attendance>
    var body: some View {
        ZStack(alignment:.topTrailing) {
            VStack(alignment:.leading) {
                Text("Attendance Detail for \(data.studentNameForAttendanceDetail) student :")
                    .bold()
                    .font(.custom("", size: data.show ? 15:20))
                    .padding(.leading,5)
                    .padding(.vertical)
                    .foregroundColor(.white)
                
                ScrollView(showsIndicators: false) {
                ForEach(allAttendanceForStudent(),id:\.self){attendance in
                    studentAttendanceListItem(attendDate: attendance.attendanceDate, doesAttend: attendance.doesAttend)
                    
                }
              }
            .frame(height: data.mainViewWidth/3-20)
            .background(Color("lightBlue"))
            .foregroundColor(Color("lightBlue"))

                
                    
                Text("Total attendnaces : \(attendanceAnalyse()[0]) , Total absents : \(attendanceAnalyse()[1]) , attendance Rate : \(attendanceAnalyse()[0] > 0 ? String(format: "%.2f", (Double.init( attendanceAnalyse()[0])/Double.init(attendanceAnalyse()[0]+attendanceAnalyse()[1]))*100)  : "0") %")
                    .font(.custom("", size: 10))
                    .foregroundColor(Color(.lightGray))
                    .padding(.leading,5)
                    Spacer()
                HStack{
                    Spacer()
                    Button(action: {data.showAttendanceDetailForSpacificStudent=false}, label: {
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
                .frame(width: data.mainViewWidth/2, height: data.mainViewWidth/2)

            
            
            
            
            
            Button(action: {data.showAttendanceDetailForSpacificStudent = false}, label: {
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
        }
       .frame(width: data.mainViewWidth/2, height: data.mainViewWidth/2)
       .background(Color("lightBlue"))
       .cornerRadius(15)
       .shadow(radius: 1)

    }
    
    struct attendanceData:Hashable,Identifiable {
        var id = 0
        var doesAttend:Bool
        var attendanceDate:Date
    }
    func allAttendanceForStudent()->[attendanceData]{
        var result = Array<attendanceData>()
        for attend in attendances {
            if attend.gradeName! == data.studentGradeForShowingAttendance {
                for item  in attend.allAttend {
                    if item.studentName == data.studentNameForShowingAttendance {
                        var tempData = attendanceData(doesAttend: item.doesAttend, attendanceDate: attend.date!)
                        result.append(tempData)
                    }
                }
            }
        }
        return result
    }
    func attendanceAnalyse()->[Int]{
        var result = Array<Int>()
        var attends = 0
        var absents = 0
        for attend in attendances {
            if attend.gradeName! == data.studentGradeForShowingAttendance {
                for item  in attend.allAttend {
                    if item.studentName == data.studentNameForShowingAttendance {
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

struct studentAttendanceDetailForAdmin_Previews: PreviewProvider {
    static var previews: some View {
        studentAttendanceDetailForAdmin()
    }
}
