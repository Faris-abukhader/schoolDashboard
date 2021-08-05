//
//  attendanceMainView.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/21.
//

import SwiftUI
class sharingData:ObservableObject {
    var chartData = Array<Pie>()
}

struct attendanceMainView: View {
    @EnvironmentObject var data:data
    @EnvironmentObject var chartData:sharingData
    @FetchRequest(entity: Attendance.entity(), sortDescriptors: []) var attendances:FetchedResults<Attendance>
    @FetchRequest(entity: GradeSections.entity(), sortDescriptors: []) var grades:FetchedResults<GradeSections>
    @State var attend:Double = 0
    @State var absent:Double = 0
    let currentDate = Date()
    @State var targetAttendanceId:Int16 = 0
    @State var targetAttendanceGrade:String = ""
    @State var gradeSort = ""
    @State var targetAttendanceDate = ""
    @State var sortTheResult = false
    var format:DateFormatter{
        let format = DateFormatter()
        format.dateStyle = .short
        format.timeStyle = .short
        format.locale = Locale.current
        return format
     }
    var body: some View {
        ZStack{
         VStack{
            ScrollView{
                
                HStack{
                    Text("Attendance :")
                        .bold()
                        .foregroundColor(Color.black)
                        .font(.title)
                        .padding()
                    Spacer()
                }
            
            
            Path(CGPath(roundedRect: CGRect(x: 0, y: 0, width: data.mainViewWidth, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil))
                
                
                // show all grades for teacher and from this list teacher cann realase the attendance
            ZStack(alignment: .trailing){
                List{
                        ForEach(grades){grade in
                            releaseAttendanceAdmin(gradeName: grade.grade!)
                        }
                    
                    
                }
                .cornerRadius(15)
                .frame(width:data.mainViewWidth-40,height: data.height/5)
                
                if data.showStudentList {
                    studentList(gradeSort: $gradeSort)
                    
             }
                
            }
            .frame(width:data.mainViewWidth-40,height: data.height/5)

                
                // from this list teacher can check all the attendance the previous one and under proccessing
                List{
                ForEach(attendances){ attend in
                        if !data.username.isEmpty{
                            showingAllSendingAttendance(subject: attend.subject!, grade: attend.gradeName!, teacher: attend.teacherName!, date: attend.date!, doesFinish: currentDate>attend.date!)
                                .onTapGesture {
                                    targetAttendanceId = attend.attendId
                                    targetAttendanceGrade = attend.gradeName!
                                    targetAttendanceDate = format.string(from:attend.date!)
                                }

                            }

                    }
                 }
                .cornerRadius(15)
                .frame(width:data.mainViewWidth-40,height: data.height/5)
            if targetAttendanceId == 0 {
                Text("click on any attendance in upper list to show up more info.")
                    .foregroundColor(Color(.lightGray))
                    .font(.caption2)
            }
                
                
                
                // here will show up the list after the teacher chosed the spacific attendance
                if targetAttendanceId != 0 {
                    HStack(alignment:.lastTextBaseline) {
                        Text(targetAttendanceGrade)
                            .bold()
                            .foregroundColor(Color.black)
                            .font(.title2)
                            .padding(.leading)
                        
                        Text(targetAttendanceDate)
                            .foregroundColor(Color(.lightGray))
                            .font(.caption2)
                            .padding(.leading)

                            
                        Spacer()
                    }
                    .padding(.top)
                    HStack {
                        Text("StudentName")
                            .foregroundColor(.black)
                            .font(.caption2)
                            .padding(.leading)
                        Spacer()
                        
                        Button(action:{sortTheResult.toggle()},label:{
                            Text("Attend")
                                .foregroundColor(.black)
                                .font(.caption2)
                            Image(systemName: "arrow.up.arrow.down.square.fill")
                                .resizable()
                                .frame(width:10, height: 10)
                                .padding(.trailing)
                                .foregroundColor(sortTheResult ? Color.green:Color(.lightGray))
                                .cornerRadius(5)
                        })
                    }
                List{
                    ForEach(Array(attendances.filter{
                        targetAttendanceId == 0 ? true:$0.attendId == (targetAttendanceId)
                    }.filter{
                        data.username.isEmpty ? true : $0.teacherName!.contains(data.username)
                    }).reversed()) {attend in
                        ForEach(attend.allAttend.sorted{
                            if sortTheResult {
                                
                                return $0.wrappedBool > $1.wrappedBool
                            }else {
                                return true
                            }
                        }){ listItem in
                         showStudentAttendanceListItem(studentName: listItem.studentName!, hasAttend: listItem.doesAttend)
                        }
                    }
                }
                .cornerRadius(15)
                .frame(width:data.mainViewWidth-40,height: data.height/2.5)
                
                }
                
                
              }
            }
            
            
            if data.showStudentAnalysis {
                studentAttendanceAnalysis(gradeName: $data.gradeForStudentForAttendanceDetail)
            }
            
            if data.showStudentAttendanceDetail {
                studentAttendanceDetailWindow()
            }
            
        }
    }
    func getTotalAttendance() -> [Double] {
        var result = Array<Double>()
        var attendCounter:Double = 0
        var absentCounter:Double = 0
        for attend in attendances {
            for item in attend.allAttend {
                if item.doesAttend {
                    attendCounter+=1
                }else {
                    absentCounter+=1
                }
            }
        }
        result.append(attendCounter)
        result.append(absentCounter)
        
        if attendCounter != 0 {
            attendCounter =   attendCounter / (attendCounter+absentCounter)
        }
        if absentCounter != 0 {
            absentCounter =  absentCounter / (absentCounter+attendCounter)
        }
        var newPie = Pie(id: 0, percent: CGFloat(attendCounter), name: "attend", color: .green)
        var newPie2 = Pie(id: 1, percent: CGFloat(absentCounter), name: "absent", color: .red)
        chartData.chartData.append(newPie)
        chartData.chartData.append(newPie2)
        return result
    }
    
}

struct attendanceMainView_Previews: PreviewProvider {
    static var previews: some View {
        attendanceMainView()
    }
}

struct drowShape:View{
    var center : CGPoint
    var index  : Int
    @EnvironmentObject var chartData:sharingData
    var body: some View {
        Path{path in
            path.move(to:center)
            
            path.addArc(center: center, radius: 100, startAngle: .init(degrees: from()), endAngle: .init(degrees: to()), clockwise: false)
            
        }
        .fill(chartData.chartData[index].color)
    }
    
    func from() -> Double {
        var temp:Double = 0
        if index == 0 {
            return 0
        } else {
            for i in 0...index-1 {
            temp += Double(chartData.chartData[i].percent) * 360
        }
        return temp
        }
        
    }

    func to() -> Double {
        var temp:Double = 0
        for i in 0...index {
            temp += Double(chartData.chartData[i].percent) * 360
        }
        return temp
    }
    

}

struct Pie : Identifiable {
    var id : Int = 0
    var percent : CGFloat = 0
    var name : String = ""
    var color : Color = .black
}



struct gradeItemList:View{
    @State var gradeName = ""
    @EnvironmentObject var data:data
    var body: some View {
        HStack{
            Text("\(gradeName)")
                .font(.caption)
                .foregroundColor(.black)
                .padding(.leading)
            Spacer()
        }.onTapGesture {
            data.showAttendanceForGrade = gradeName
        }
    }
}
struct gradeAttendanceListItem:View {
    @State var studentName = ""
    @State var date = Date()
    @State var doesAttend = false
    @State var grade = ""
    @EnvironmentObject var data:data
    var format:DateFormatter {
        let format = DateFormatter()
        format.dateStyle = .short
        format.timeStyle = .short
        return format
    }
    var body: some View{
        HStack{
            VStack(alignment: .leading){
                Text("\(studentName)")
                    .font(.custom("", size: 15))
                    .foregroundColor(.black)
                Text("\(format.string(from: date))")
                    .font(.caption2)
                    .foregroundColor(Color(.darkGray))
            }
            .padding(.leading)
            Spacer()
            
            Text(doesAttend ? "Attend":"Absent")
                .foregroundColor(.black)
                .padding(.horizontal,10)
                .background(doesAttend ? Color.green:.red)
                .cornerRadius(10)
                .padding(.trailing)
                .font(.caption)
        }.onTapGesture {
            data.showAttendanceDetailForSpacificStudent = true
            data.studentNameForShowingAttendance = studentName
            data.studentGradeForShowingAttendance = grade
        }
    }
}
struct releaseAttendanceAdmin:View{
    @State var gradeName = ""
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    @State var showAlert = false
    var body: some View{
        HStack{
            Text("\(gradeName)")
                .font(.caption)
                .foregroundColor(.black)
                .padding(.leading)
            Spacer()
            
            VStack{
                Image(systemName: "list.bullet")
                    .foregroundColor(.black)
                    .onTapGesture {
                        data.showStudentAnalysis.toggle()
                        data.gradeForStudentForAttendanceDetail = gradeName
                    }
                Text("show analysis")
                    .foregroundColor(Color(.lightGray))
                    .font(.custom("", size: 5))
                    .padding(.top,3)
            }.padding(.trailing,10)
            
            VStack{
                Image(systemName: "chevron.down.square")
                    .foregroundColor(.black)
                    .onTapGesture {
                        data.showStudentList.toggle()
                    }
                Text("show list")
                    .foregroundColor(Color(.lightGray))
                    .font(.custom("", size: 5))
                    .padding(.top,3)
            }.padding(.trailing,10)


        }
    }
}
