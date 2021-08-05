//  teacherMain.swift
//  schoolDashboard
//  Created by admin on 2021/6/12.
import SwiftUI
import CoreData

struct teacherMain: View {
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        ZStack{
            if data.showGradeInfoView{
                reviewGradeStudent(grade: $data.gradeToShowInfo)
            }  else {
        VStack{
            ScrollView(showsIndicators:false) {
            
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            if !data.username.isEmpty {
                                ForEach(0..<allTeacherGrade().count,id:\.self){
                                    teacherClass(grade: allTeacherGrade()[$0])

                                    
                                    
                                  }
                            }
                    }
                    
                    
                }.frame(width: data.mainViewWidth-20)
                    
            Spacer()
            
                calenderView()

            
            HStack{
                noticeView()
                Spacer()
                activiteView()
            }.padding(.horizontal)
            }
         }
        }
        }
    }
    func allTeacherGrade()->[String]{
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
}

struct teacherMain_Previews: PreviewProvider {
    static var previews: some View {
        teacherMain()
    }
}
struct teacherClass:View{
    @State var grade = ""
    @EnvironmentObject var data:data
    @State var showMenu = false
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: data.mainViewWidth/3.3, height: data.mainViewHeight/3.3)
                .foregroundColor(Color(.orange))
                .cornerRadius(10)
            VStack{
                Text("\(grade)")
                    .bold()
                    .font(.title2)
                
            }
            
            if showMenu {
                        ZStack{
                        Rectangle()
                            .frame(width: data.mainViewWidth/6, height: data.mainViewHeight/8)
                            .foregroundColor(Color("darkBlue"))
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            HStack{
                                Image(systemName: "eye")
                                    .foregroundColor(.white)
                             Text("show")
                                .font(.caption2)
                                .foregroundColor(.white)
                            }.offset(y: -30)
                    }.offset(y: data.mainViewHeight/6)
                        .onTapGesture {
                            data.gradeToShowInfo = grade
                            data.showGradeInfoView = true
                        }
                
            }
            
        }.frame(width: data.mainViewWidth/3.3, height: data.mainViewHeight/3.3)
        .onTapGesture {
            showMenu.toggle()
        }
    }
}
