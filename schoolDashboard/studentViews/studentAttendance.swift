//
//  studentAttendance.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/15.
//

import SwiftUI
import CoreData

struct studentAttendance: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Attendance.entity(), sortDescriptors: []) private var attendances:FetchedResults<Attendance>
    let currentDate = Date()
    @EnvironmentObject var data:data
    @State var showNoDataImage = true
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false) {
            
            ForEach(attendances.filter{
                data.username.isEmpty ? true : $0.gradeName!.contains(getTheGradeFor(student: data.username))
            }){ attend in
                    if !data.username.isEmpty{
                        
                        if attend.date! > currentDate {
                            
                            showAttendance(subjectName: attend.subject!, teacherName: attend.teacherName!,date: attend.date!,gradeName: attend.gradeName!,id: attend.attendId)
                                .padding(.bottom)
                                .onAppear{
                                    showNoDataImage = false
                                }
                        }
                        

                }
            }
            if showNoDataImage {
                
                Text("No attendance for now , check again later !")
                    .bold()
                    .foregroundColor(.black)
                    .font(.title)
                Image("noAvailableData")
                    .resizable()
                    .frame(width: data.mainViewWidth/2, height: data.mainViewWidth/2)
            }
            
        }
        }
    }
    func doesTheAddtendanceFinished(gradeName:String,id:Int16)->Bool{
        var result = false
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Attendance")
        fetch.predicate = NSPredicate.init(format: "gradeName = %@", gradeName )
        do {
            if try moc.fetch(fetch).count > 0 {
            let fetchReturn = try moc.fetch(fetch)
            let targetAttendance = fetchReturn[0] as! Attendance
            if targetAttendance.attendId == id {
                result = targetAttendance.date! > currentDate
            }
          }
        }catch{
            print(error.localizedDescription)
        }
        
        return result
    }

    
    func settAttend(gradeName:String,doesAttend:Bool,id:Int16){
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Attendance")
        fetch.predicate = NSPredicate.init(format: "gradeName = %@", gradeName)
        do {
            if try moc.fetch(fetch).count > 0 {
            let fetchReturn = try moc.fetch(fetch)
            let targetAttendance = fetchReturn[0] as! Attendance
            let taregtAttend = targetAttendance.fromAttendanceToDoesAttend
            let theAttend = YesNoAttend(context: moc)
            theAttend.attendId = id
            theAttend.doesAttend = doesAttend
            theAttend.studentName = data.username
            
            taregtAttend?.adding(theAttend)

            do {
                try moc.save()
            }catch{
                
            }
            
          }
        }catch{
            print(error.localizedDescription)
        }
    }
    func getTheGradeFor(student:String)->String{
        var result = ""
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Student")
        fetch.predicate = NSPredicate.init(format: "name = %@", student)
        do {
            if try moc.fetch(fetch).count > 0 {
            let fetchReturn = try moc.fetch(fetch)
            let targetStudent = fetchReturn[0] as! Student
            result = targetStudent.garde!
          }
        }catch{
            
            print(error.localizedDescription)
        }
        return result
        
    }

    
}

struct studentAttendance_Previews: PreviewProvider {
    static var previews: some View {
        studentAttendance()
    }
}
struct showAttendance:View{
    @State var subjectName = ""
    @State var teacherName = ""
    @State var date = Date()
    @State var gradeName = ""
    @State var id:Int16 = 0
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var data:data
    var time = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var currentDate = Date()
    var fomrat:DateFormatter{
        let format = DateFormatter()
        format.timeStyle = .full
        return format
    }
    @State var sec = 0
    @State var show = true
    var body: some View {
        if show {
        VStack{
            Text(gradeName)
                .bold()
                .foregroundColor(Color.black)
                .font(.title2)
                .padding(.bottom,10)
                
            Text("teacher : \(teacherName)")
                .font(.caption)
                .foregroundColor(Color(.lightGray))
            Text("Subject : \(subjectName)")
                .font(.caption2)
                .foregroundColor(Color(.lightGray))
                .padding(.bottom,30)
            
            
            Button(action: {
                settAttend(gradeName: gradeName, doesAttend: true, id: id)
                show.toggle()
            }, label: {
                Text("Attend")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal,10)
                    .background(Color.green)
                    .cornerRadius(10)
                    
            })
            Text("Click on Attend button to confirm your attendance for this close today.")
                .font(.caption2)
                .foregroundColor(Color(.lightGray))
            
            HStack{
                Spacer()
                Text("Sec \(sec)")
                    .foregroundColor(Color(.darkGray))
                    .font(.caption2)
                Spacer()
            }
            
        }.onReceive(time, perform: { i in
            if sec > 0 {
                sec -= 1
            }
            if sec == 1 && show {
                settAttend(gradeName: gradeName, doesAttend: false, id: id)
            }
            
        })
        .onAppear{
            
            let format = ISO8601DateFormatter()
            var f:DateFormatter{
                let format = DateFormatter()
                format.timeStyle = .short
                return format
            }
            let date1 = format.date(from:format.string(from:  currentDate))
            let date2 = format.date(from: format.string(from: date))
            let diff = Calendar.current.dateComponents([.second],from: date1! ,to: date2!)
            sec = diff.second ?? 0

        }
        .frame(width: data.mainViewWidth - 30, height: data.mainViewHeight/3)
        .background(Color.white)
        .cornerRadius(10)
     }
  }
    func settAttend(gradeName:String,doesAttend:Bool,id:Int16){
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Attendance")
        fetch.predicate = NSPredicate.init(format: "attendId = %i", id)
        do {
            if try moc.fetch(fetch).count > 0{
            let fetchReturn = try moc.fetch(fetch)
            let targetAttendance = fetchReturn[0] as! Attendance
            let theAttend = YesNoAttend(context: moc)
            theAttend.attendId = id
            theAttend.doesAttend = doesAttend
            theAttend.studentName = data.username
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

}
