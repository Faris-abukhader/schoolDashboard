//
//  studentExamListWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/7/3.
//

import SwiftUI
import CoreData

struct studentExamListWindow: View {
    @State var gradeName = ""
    @State var examID = UUID()
    @EnvironmentObject var data:data
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students:FetchedResults<Student>
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Exam.entity(), sortDescriptors: []) var exams:FetchedResults<Exam>
    @FetchRequest(entity: ExamQuestion.entity(), sortDescriptors: []) var examQuestion:FetchedResults<ExamQuestion>
    var body: some View {
        ZStack(alignment:.topTrailing){
            VStack{
                ScrollView{
                    
                    ForEach(students.filter{
                        gradeName.isEmpty ? true: $0.garde!.contains(gradeName)
                    }){student in
                        MarkListItem(studentName: student.name!, studentMark: String(format: "%.2f", getStudentMark(studentName: student.name!))).onTapGesture {
                            data.showStudentAnswerForTeacher = true
                            data.showStudentAnswerPreivewID = examID
                            data.showStudentAnswerPreivewStudentName = student.name!
                        }
                    }
                  
                }
            }.padding(.top,50)
            
            
            Button(action: {data.showStudentExamMark = false}, label: {
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

        }.frame(width: data.mainViewWidth/1.5, height: data.mainViewHeight/2)
        .background(Color("darkBlue"))
        .cornerRadius(10)
    }
    func getStudentMark(studentName:String)->Double {
        var result:Double = 0 , totalQuestions = 0 , totalCorrectAnswer = 0
        for exam in exams {
            if exam.id == data.showStudentListExamID {
                totalQuestions=exam.allQuestion.count
                for question in examQuestion {
                    if question.examId == exam.id {
                        if question.fromExamQuestionToStudentAnswer?.answer == 1 && question.fromExamQuestionToStudentAnswer?.studentName! == studentName{
                            totalCorrectAnswer+=1
                       }
                    }
                }
            }
        }
        result = ( Double(totalCorrectAnswer) / Double(totalQuestions) ) * 100

        return result
    }
}

struct studentExamListWindow_Previews: PreviewProvider {
    static var previews: some View {
        studentExamListWindow()
    }
}
struct MarkListItem:View{
    @State var studentName = ""
    @State var studentMark = ""
    @EnvironmentObject var data:data
    var body: some View{
        VStack(alignment:.leading){
        HStack{
            Text(studentName)
                .font(.caption2)
                .foregroundColor(Color.white)
                .padding(.leading)
            Spacer()
            Text("\(studentMark)/100.00")
                .font(.caption2)
                .foregroundColor(Color.white)
                .padding(.trailing)
        }
            Path(CGPath(roundedRect: CGRect(x: 0, y: 0, width: data.mainViewWidth/1.5, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil))
      }
    }
  }
