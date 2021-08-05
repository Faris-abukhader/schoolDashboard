//
//  teacherExam.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/24.
//

import SwiftUI
import CoreData

struct teacherExam: View {
    @EnvironmentObject var data:data
    @FetchRequest(entity: Exam.entity(), sortDescriptors: []) var exams:FetchedResults<Exam>
    var body: some View {
        ZStack{
            if data.showCreatingExamPage {
                createExamWindow()
            } else if data.showPreviewPage {
                examPreivewWindow()
            } else if data.showStudentAnswerForTeacher {
                studentAnswerPreivew()
            } else {
            VStack{
                ScrollView(showsIndicators: false){
                        
                        createNewExam()
                            if exams.count == 0 {
                                nullDataImage().padding(.top,40)
                            }else {
                                examListView()
                                
                            }
                    
                }
                
            }
                if data.showStudentExamMark {
                    studentExamListWindow(examID:data.studentExamPreviewID)
                }
        }

            
        }
    }
}

struct teacherExam_Previews: PreviewProvider {
    static var previews: some View {
        teacherExam()
    }
}
struct createNewExam:View{
    @EnvironmentObject var data:data
    @State var examGrade = ""
    @State var examName = ""
    @State var showAlert = false
    @State var showInfoMissingAlert = false
    @FetchRequest(entity: Teacher.entity(), sortDescriptors: []) var teachers:FetchedResults<Teacher>
    @Environment(\.managedObjectContext) var moc
    @State var showList = false
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: data.mainViewWidth - 40, height: data.mainViewHeight/7)
                .foregroundColor(.white)
                .cornerRadius(15)
            
            VStack{
                HStack(alignment: .firstTextBaseline)  {
                    VStack(alignment: .leading){
                        Text("GradeName : ")
                            .foregroundColor(.black)
                            .font(.caption)
                            .padding(.bottom,10)
                        
                        Text("Exam Name : ")
                            .foregroundColor(.black)
                            .font(.caption)
                    }
                    VStack(alignment: .leading){
                        Button(action: {showList.toggle()}, label: {
                            ZStack(alignment: .topLeading){
                                Rectangle()
                                    .frame(width: data.mainViewWidth/2 + 5, height: 30)
                                    .cornerRadius(5)
                                    .foregroundColor(examGrade.isEmpty ? Color("lightGry"):Color(.lightGray))
                                HStack{
                                    Text(examGrade.isEmpty ? "GradeName":examGrade)
                                        .foregroundColor(.black)
                                        .font(.caption)
                                        .padding(.leading)
                                        .padding(.top,5)
                                    Spacer()
                                    Image(systemName: "arrow.down.circle")
                                        .foregroundColor(.black)
                                        .padding(.trailing)
                                        .padding(.top,5)

                                }
                            }.frame(width: data.mainViewWidth/2,height: 25)
                        })
                        
                        .alert(isPresented: $showAlert, content: {
                            Alert(title: Text("Create and share a new exam"), primaryButton: Alert.Button.destructive(Text("comfirm"), action: {
                                data.showCreatingExamPage = true
                                data.examName = examName
                                data.examGrade = examGrade
                                createNewExam()
                                
                            }), secondaryButton: Alert.Button.cancel())
                        })
                        
                        TextField("Exam Name...", text: $examName)
                            .font(.caption)
                            .frame(width:data.mainViewWidth/2 - 5,height: 20)
                            .padding(5)
                            .background(Color("lightGry"))
                            .cornerRadius(5)
                    }
                    VStack{
                        Button(action: {
                            if examName.isEmpty || examGrade.isEmpty {
                                showInfoMissingAlert.toggle()
                            }else{
                                showAlert.toggle()
                             }
                            }, label: {
                            Text("Confirm")
                                .font(.caption)
                                .foregroundColor(Color.black)
                                .padding(.vertical,5)
                                .padding(.horizontal,10)
                                .background(Color("yellow"))
                                .cornerRadius(10)
                        })
                        .alert(isPresented: $showInfoMissingAlert, content: {
                            Alert(title: Text("Warning"), message: Text("Make sure that exam name and grade name is filled."), dismissButton: Alert.Button.cancel())
                        })
                        
                        Button(action: {
                            examGrade=""
                            examName=""
                        }, label: {
                            Text("Reset")
                                .font(.caption)
                                .foregroundColor(Color.black)
                                .padding(.vertical,5)
                                .padding(.horizontal,10)
                                .background(Color("yellow"))
                                .cornerRadius(10)
                        })
                    }
                }
                
            }
            .frame(width: data.mainViewWidth - 40, height: data.mainViewHeight/3)
            
            if showList {
                ZStack{
                Rectangle()
                    .frame(width: data.mainViewWidth/2 + 5, height: 100)
                    .foregroundColor(Color(.lightGray))
                    .cornerRadius(5)
                    ScrollView{
                        ForEach(0..<allTeacherGrades().count) {index in
                            Button(action: {
                                examGrade = allTeacherGrades()[index]
                                showList = false
                            }, label: {
                                VStack{
                                    HStack{
                                        Text("\(allTeacherGrades()[index])")
                                            .padding()
                                            .font(.caption2)
                                            .foregroundColor(.white)

                                        Spacer()
                                    }
                                    Path(CGPath(roundedRect: CGRect(x: 0, y: 0, width: data.mainViewWidth/2 - 10, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil)).foregroundColor(.white)
                                }
                            })
                                
                        }
                        
                    }.frame(width: data.mainViewWidth/2 + 5, height: 100)

              }
                .offset(x:5,y: 40)

            }

        
      }
        .frame(width: data.mainViewWidth - 40, height: data.mainViewHeight/7)

    }
    
    func allTeacherGrades()->[String]{
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Teacher")
        fetch.predicate = NSPredicate.init(format: "name = %@", data.username)
        var result = Array<String>()
        do {
            let fetchResult = try moc.fetch(fetch)
            let teacher = fetchResult[0] as! Teacher
            let teacherGrades = teacher.teacherGrades
            for grade in teacherGrades {
                result.append(grade.grade!)
            }
        }catch{
            print(error.localizedDescription)
        }
        return result
    }
    
    func createNewExam(){
        let examId = UUID()
        data.examId = examId
        let newExam = Exam(context: moc)
        newExam.examDate = Date()
        newExam.examName = examName
        newExam.gradeName = examGrade
        newExam.teacherName = data.username
        newExam.id = examId
        do {
            try moc.save()
        }catch{
            print(error.localizedDescription)
        }
    }
}
struct nullDataImage:View{
    @EnvironmentObject var data:data
    var body: some View{
        VStack{
            Image("noAvailableData")
                .resizable()
                .frame(width: data.mainViewWidth/2, height: data.mainViewWidth/2)
            Text("No exams in your record ,  you can share your first exam from the box upon.")
                .foregroundColor(Color(.lightGray))
                .font(.caption2)

        }
    }
}
struct examListView:View{
    @EnvironmentObject var data:data
    @FetchRequest(entity: Exam.entity(), sortDescriptors: []) var exams:FetchedResults<Exam>
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students:FetchedResults<Student>
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        VStack{
            HStack{
                Text("List of exams :")
                    .padding()
                    .foregroundColor(.black)
                    .font(.title2)
                Spacer()
            }
            if allTeacherExam().count > 0 {
            List{
                ForEach(0..<allTeacherExam().count,id:\.self){exam in
                    
                    examListItemView(examName: allTeacherExam()[exam].examName!, gradeName: allTeacherExam()[exam].gradeName!,examId: allTeacherExam()[exam].id)

                    
                }
            }
            .frame(width: data.mainViewWidth-40, height: data.mainViewHeight/2)
            .cornerRadius(15)
            HStack{
                Text("click on any grade of list item to show up student marks")
                    .foregroundColor(Color(.lightGray))
                    .font(.caption2)
            }
        }
            
        }
        .frame(height: data.mainViewHeight/2 + 80)

        
    }
    
    func allTeacherExam()->[Exam] {
        var result = Array<Exam>()
        for exam in exams {
            if exam.teacherName == data.username {
                result.append(exam)
            }
        }
        return result.reversed()
    }
    
}
struct examListItem:View{
    @State var examName = ""
    @State var studentAttendedNum:Int = 0
    @State var studentInGradeNum:Int = 0
    var body: some View{
        HStack{
            Text("\(examName)")
                .foregroundColor(.black)
                .font(.caption)
                .padding(.leading)
            Spacer()
            
            Text("attended : \(studentAttendedNum)/\(studentInGradeNum)")
                .font(.caption2)
                .foregroundColor(Color(.lightGray))
                .padding(.trailing)
        }
    }
}
struct examListItemView:View{
    @State var examName = ""
    @State var gradeName = ""
    @State var examId = UUID()
    @State var examEndTime = Date()
    @EnvironmentObject var data:data
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students:FetchedResults<Student>
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(examName)
                    .font(.caption)
                    .foregroundColor(.black)
                    .padding(.bottom,10)
                Text(gradeName)
                    .font(.caption)
                    .foregroundColor(.black)
            }.padding(.leading)
            Spacer()
            VStack{
                Spacer()
                Image(systemName: "doc.text.fill.viewfinder")
                    .foregroundColor(.black)
                Text("preview")
                    .font(.custom("", size: 7))
                    .foregroundColor(Color(.lightGray))
                
                Spacer()
                
            }.onTapGesture {
                data.showPreviewPage = true
                data.previewExamId = examId
            }
        }.onAppear{
            if examEndTime < Date() {
                setZeroMarkForStudent()
            }
        }.onTapGesture {
            data.showStudentListGrade = gradeName
            data.showStudentListExamID = examId
            data.studentExamPreviewID = examId
            data.showStudentExamMark = true

        }
    }
    func setZeroMarkForStudent(){
        var result = Array<String>()
        for student in students {
            result.append(student.name!)
        }
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Exam")
        fetch.predicate = NSPredicate.init(format: "id = %@", examId as CVarArg)
        do {
            if try moc.fetch(fetch).count > 0 {
                let fetchResult = try moc.fetch(fetch)
                let targetExam = fetchResult[0] as? Exam
                for item in targetExam!.allAnswer {
                    if result.contains(item.studentName!) {
                        if let index = result.firstIndex(of: item.studentName!) {
                            result.remove(at: index)
                        }
                    }
                }
                for item in result {
                    let newZeroMark = StudentAnswer(context: moc)
                    newZeroMark.answer = 1000
                    newZeroMark.studentName = item
                    do {
                        try moc.save()
                    }catch{print(error.localizedDescription)}
                }
            }
        }catch{
            print(error.localizedDescription)
        }
    }

}
