//
//  teacherAttendance.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/15.
//

import SwiftUI
import CoreData

struct teacherAttendance: View {
    @EnvironmentObject var data:data
    @FetchRequest(entity: Teacher.entity(), sortDescriptors: []) private var teachers:FetchedResults<Teacher>
    @FetchRequest(entity: Attendance.entity(), sortDescriptors: []) private var attendances:FetchedResults<Attendance>
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) private var students:FetchedResults<Student>
    @Environment(\.managedObjectContext) var moc
    let currentDate = Date()
    var format:DateFormatter{
        let format = DateFormatter()
        format.dateStyle = .short
        format.timeStyle = .short
        format.locale = Locale.current
        return format
     }
    @State var targetAttendanceId:Int16 = 0
    @State var targetAttendanceGrade:String = ""
    @State var targetAttendanceDate = ""
    @State var sortTheResult = false
    @State var gradeSort = ""
    var body: some View {
        ZStack{
         VStack{
            ScrollView{
            
            Text("Attendance :")
                .bold()
                .foregroundColor(Color.black)
                .font(.title)
                .padding()
            
            
            Path(CGPath(roundedRect: CGRect(x: 0, y: 0, width: data.mainViewWidth, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil))
                
                
                // show all grades for teacher and from this list teacher cann realase the attendance
            ZStack(alignment: .trailing){
                List{
                    if !data.username.isEmpty {
                        ForEach(0..<allTeacherGrad().count,id:\.self){
                            releaseAttendance(gradeName: allTeacherGrad()[$0])
                        }
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
                                    if attend.date! < currentDate {
                                        setAbsent(id: attend.attendId)
                                    }
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
                

//            Spacer()
                
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
    
    func settAttend(studentName:String,gradeName:String,doesAttend:Bool,id:Int16){
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Attendance")
        fetch.predicate = NSPredicate.init(format: "attendId = %i", id)
        do {
            if try moc.fetch(fetch).count > 0{
            let fetchReturn = try moc.fetch(fetch)
            let targetAttendance = fetchReturn[0] as! Attendance
            let theAttend = YesNoAttend(context: moc)
            theAttend.attendId = id
            theAttend.doesAttend = doesAttend
            theAttend.studentName = studentName
            theAttend.fromDoesAttendToAttendance = targetAttendance
            do {
                try moc.save()
            }catch{
                
            }
            
         }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    func setAbsent(id:Int16){
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Attendance")
        fetch.predicate = NSPredicate.init(format: "attendId = %i", id)
        do {
            if try moc.fetch(fetch).count > 0 {
                let fetchResult = try moc.fetch(fetch)
                let targetAttendance = fetchResult[0] as! Attendance
                let targetAttend = targetAttendance.allAttend
                let target = targetAttendance.fromAttendanceToDoesAttend
                if targetAttend.count == 0 {
                    for student in fetchAllTheStudentOfGrade(grade:targetAttendance.gradeName!) {
                      let newAttend = YesNoAttend(context: moc)
                        newAttend.attendId = id
                        newAttend.doesAttend = false
                        newAttend.studentName = student
                        newAttend.fromDoesAttendToAttendance = targetAttendance
                        target?.adding(newAttend)
                        do {
                            try moc.save()
                            print("adding new attend done successfully")
                        }catch{
                            
                        }
                        
                    }
                }else {
                for item in targetAttend {
                for student in fetchAllTheStudentOfGrade(grade:targetAttendance.gradeName!) {
                    if student != item.studentName! && item.attendId==id && fetchAllTheStudentOfGrade(grade: targetAttendance.gradeName!).count > targetAttend.count {
                            settAttend(studentName:student,gradeName: targetAttendance.gradeName! , doesAttend: false, id: item.attendId)
                    }
                  }
                }
              }
            }
        }catch{
            print(error.localizedDescription)
      }
    }
 
    func fetchAllTheStudentOfGrade(grade:String)->[String]{
        var result = Array<String>()
        for student in students {
            if student.garde == grade {
                result.append(student.name!)
            }
        }
        return result
    }
    func allTeacherGrad()->[String]{
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Teacher")
        fetch.predicate = NSPredicate.init(format: "name = %@", data.username)
        var result = Array<String>()
        do {
            if try moc.fetch(fetch).count > 0 {
            let fetchResult = try moc.fetch(fetch)
            let targetTeacher = fetchResult[0] as! Teacher
            let teacherGrades = targetTeacher.teacherGrades
            for grade in teacherGrades {
                result.append(grade.grade!)
            }
          }
        }catch{
            print(error.localizedDescription)
        }
        return result
    }
    func allAttendanceForGrade(grade:String) ->[YesNoAttend]{
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Teacher")
        fetch.predicate = NSPredicate.init(format: "name = %@", data.username)
        var result = Array<YesNoAttend>()
        do {
            if try moc.fetch(fetch).count > 0 {
            let fetchResult = try moc.fetch(fetch)
            if try moc.fetch(fetch).count > 0 {
                let targetTeacher = fetchResult[0] as! Teacher
                let targetAttendance = targetTeacher.teacherAttendances
                for item in targetAttendance {
                    for i in item.allAttend {
                        result.append(i)
                    }
                }
             }
            }else {
                
            }

        }catch{
            print(error.localizedDescription)
        }
        return result
    }
    
}

struct teacherAttendance_Previews: PreviewProvider {
    static var previews: some View {
        teacherAttendance()
    }
}
struct releaseAttendance:View{
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

            VStack{
                Image(systemName: "arrow.up.circle.fill")
                    .foregroundColor(.black)
                    .onTapGesture {
                        showAlert = true
                   }
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Release new attendance"), message: Text("Are you sure you want to release the attedance now ?"), primaryButton: Alert.Button.cancel(),secondaryButton: Alert.Button.destructive(Text("Release"), action: {releaseTheAttendance()}))
                    })
                Text("release attendance")
                    .foregroundColor(Color(.lightGray))
                    .font(.custom("", size: 5))
                    .padding(.top,3)
            }

        }
    }
    func getTeacherSubject()->String{
        var teacherSubject:String = ""
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Teacher")
        fetch.predicate = NSPredicate.init(format: "name = %@", data.username)
        do {
            if try moc.fetch(fetch).count > 0{
            let fetchReturn = try moc.fetch(fetch)
            let targetTeacher = fetchReturn[0] as! Teacher
            teacherSubject = targetTeacher.major!
         }
        }catch{
            print(error.localizedDescription)
        }
        return teacherSubject
    }
    func releaseTheAttendance(){
        var passoword:Int = UUID().hashValue % 10000
        if passoword < 0 {
            passoword = -passoword
        }
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Teacher")
        fetch.predicate = NSPredicate.init(format: "name = %@", data.username)
        do {
            if try moc.fetch(fetch).count > 0 {
            let fetchReturn = try moc.fetch(fetch)
            let targetTeacher = fetchReturn[0] as! Teacher
            
            // to count five minute 5*60sec = 300 sec
            let deadlineForAttendance = Date().addingTimeInterval(300)
            // her as a default the attendance deadline line would be after five minutes from released it
            let newAttendanceNotice = Attendance(context: moc)
            newAttendanceNotice.teacherName = data.username
            newAttendanceNotice.gradeName = gradeName
            newAttendanceNotice.subject = getTeacherSubject()
            newAttendanceNotice.date = deadlineForAttendance
            newAttendanceNotice.attendId = Int16(passoword)
            newAttendanceNotice.attendToTeacher = targetTeacher
        
            do {
                try moc.save()
            }catch{
                print(error.localizedDescription)
            }

         }
        }catch{
            print(error.localizedDescription)
        }
    }
    
}
struct showingAllSendingAttendance:View{
    @State var subject = ""
    @State var grade = ""
    @State var teacher = ""
    @State var date = Date()
    @State var doesFinish = true
    var format:DateFormatter{
        let format = DateFormatter()
        format.dateStyle = .short
        format.timeStyle = .short
        format.locale = Locale.current
        return format
    }
    var body: some View{
        HStack{
        Text("The attendance for \(subject) for \(grade) , Teacher in charge \(teacher) at \(format.string(from:date))")
                .foregroundColor(.black)
                .font(.caption)
                .padding(.leading)
            
            Spacer()
            
            Text(doesFinish ? "Passed":"Proccessing")
                .font(.caption2)
                .foregroundColor(Color.white)
                .padding(.horizontal ,10)
                .padding(.vertical ,5)
                .background(doesFinish ? Color.red :Color.green)
                .cornerRadius(10)
                

        }
    }
}
struct showStudentAttendanceListItem:View{
    @State var studentName = ""
    @State var hasAttend = true
    var body :some View {
        HStack{
            Text(studentName)
            Spacer()
            Text(hasAttend ? "Attend":"Absent")
                .foregroundColor(Color.white)
                .font(.caption2)
                .padding(.horizontal,5)
                .background(hasAttend ? Color.green:.red)
                .cornerRadius(10)
        }
    }
}

struct studentList:View{
    @Binding var gradeSort:String
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students:FetchedResults<Student>
    @EnvironmentObject var data:data
    var body: some View {
        VStack(alignment:.trailing){
        List{
            Section{
                HStack{
                    Spacer()
                        Image(systemName: "xmark")
                            .foregroundColor(Color(.darkGray))
                            .onTapGesture {
                                data.showStudentList = false
                            }
                }
            }
        ForEach(students.filter{
            gradeSort.isEmpty ? true : $0.garde!.contains(gradeSort)
        }){ student in
            Text(student.name!)
                .foregroundColor(.black)
                .font(.caption)
                .onTapGesture {
                    data.studentNameForAttendanceDetail = student.name!
                    data.gradeForStudentForAttendanceDetail = student.garde!
                    data.showStudentAttendanceDetail = true
                    data.showStudentList = false
                }
        }
     }
    .frame(width:(data.mainViewWidth-40)/2,height: data.height/5)
    .cornerRadius(15)
    .shadow(radius: 1)
    
    }
    .frame(width:(data.mainViewWidth-40)/2,height: data.height/5)

    }
}
