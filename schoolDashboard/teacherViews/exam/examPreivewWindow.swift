//
//  examPreivewWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/26.
//

import SwiftUI
import CoreData

struct examPreivewWindow: View {
    @EnvironmentObject var data:data
    var body: some View {
        ZStack{
         VStack{
            ScrollView(showsIndicators: false){
                headerForExamPreview()
                examQuestions()
            }
        }
      }
    }
}

struct examPreivewWindow_Previews: PreviewProvider {
    static var previews: some View {
        examPreivewWindow()
    }
}
struct headerForExamPreview:View{
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    var format:DateFormatter{
        let format = DateFormatter()
        format.dateStyle = .short
        format.timeStyle = .short
        return format
    }
    var time  = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var examReminderHour = 0
    @State var examReminderMinute = 0
    @State var examReminderSecond = 0
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("\(getExamName().0)'s Preview :")
                    .bold()
                    .font(.title)
                    .padding(.vertical)
                Spacer()
            }.padding(.leading)
            HStack{
                Text(format.string(from: getExamDate().examDate))
                    .foregroundColor(Color(.lightGray))
                    .font(.caption2)
                Spacer()
            }.padding(.leading)
            HStack{
                Text("TeacherName : \(getExamName().1)")
                    .foregroundColor(Color(.lightGray))
                    .font(.caption2)
                Spacer()
            }.padding(.leading)
            HStack{
                Button(action: {data.showPreviewPage = false}, label: {
                    HStack{
                        Image(systemName: "arrow.left.circle.fill")
                            .foregroundColor(Color(.darkGray))
                        Text("Go back")
                            .font(.caption)
                            .foregroundColor(Color(.darkGray))
                    }
                }).padding(.bottom)
                Spacer()
            }.padding(.leading)
            .padding(.top)
            
            HStack{
                Spacer()
                if getExamDate().examEndTime < Date() {
                    Text("Finished").foregroundColor(Color(.darkGray)).font(.caption2).padding()
                } else {
                Text("\(examReminderHour)h \(examReminderMinute)min \(examReminderSecond)sec").foregroundColor(Color(.darkGray)).font(.caption2)
                    .onReceive(time, perform: { i in
                        if getExamDate().examEndTime > Date(){
                        if examReminderSecond > 0 {
                            examReminderSecond -= 1
                        } else {
                            examReminderSecond = 60
                            if examReminderMinute > 0 {
                                examReminderMinute -= 1
                                if examReminderMinute == 0 && examReminderHour > 0 {
                                    examReminderMinute = 60
                                    examReminderHour -= 1
                                }else {
                                    examReminderMinute = 0
                                    examReminderHour = 0
                                    examReminderSecond = 0
                                    time.upstream.connect().cancel()
                                }
                            }else {
                                examReminderMinute = 0
                                examReminderSecond = 0
                            }
                        }
                        }else {
                            examReminderSecond=0
                            examReminderMinute=0
                            examReminderHour=0
                        }

                    })
            }
                Spacer()
            }

            
        }
    }
    func getExamName()->(String,String){
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Exam")
        fetch.predicate = NSPredicate.init(format: "id = %@", data.previewExamId as CVarArg)
        var result1 = "" ,result2 = ""
        do {
            if try moc.fetch(fetch).count > 0 {
                let fetchResult = try moc.fetch(fetch)
                let targetExam = fetchResult[0] as! Exam
                result1 = targetExam.examName!
                result2 = targetExam.teacherName!
            }
        }catch{
            print(error.localizedDescription)
        }
       return (result1,result2)
    }
    
    func getExamDate()->(examDate:Date,examEndTime:Date){
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Exam")
        fetch.predicate = NSPredicate.init(format: "id = %@", data.previewExamId as CVarArg)
        var result1 = Date()
        var result2 = Date()
        do {
            if try moc.fetch(fetch).count > 0 {
                let fetchResult = try moc.fetch(fetch)
                let targetExam = fetchResult[0] as! Exam
                result1 = targetExam.examDate ?? Date()
                result2 = targetExam.examEndTime ?? Date()
            }
        }catch{
            print(error.localizedDescription)
        }
       return (result1,result2)
    }

}
struct ExamQuestionView:View{
    @State var question = ""
    @State var firstAnswer = ""
    @State var secondAnswer = ""
    @State var thirdAnswer = ""
    @State var fourthAnswer = ""
    @State var mark:Int = 0
    @State var questionNo = 0
    @EnvironmentObject var data:data
    @State var index = 0
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("\(questionNo).")
                    .foregroundColor(Color(.lightGray))
                    .font(.custom("", size: 7))
                    .padding(.leading,5)
                Spacer()
                Text("\(mark)' mark")
                    .foregroundColor(Color(.lightGray))
                    .font(.custom("", size: 7))
                    .padding(.trailing,5)
            }
            Text(question)
                .frame(width: data.mainViewWidth - 60,alignment:.leading)
                .font(.footnote)
                .foregroundColor(.black)
                .padding()
                .lineLimit(10)
            
            Path(CGPath(roundedRect: CGRect(x: 0, y: 0, width: data.mainViewWidth - 40, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil))

            HStack{
                VStack(alignment: .leading){
                    Button(action: {index=1}, label: {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(index==1 ? Color.black:Color(.lightGray))
                            .background(index==1 ? Color.white:Color(.lightGray))
                            .cornerRadius(50)
                            .padding(.leading)
                        Text("A. \(firstAnswer)")
                            .bold()
                            .font(.caption)
                            .foregroundColor(Color(.green))
                            .lineLimit(3)
                    }).padding(.bottom)
                    Button(action: {index=2}, label: {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(index==2 ? Color.black:Color(.lightGray))
                            .background(index==2 ? Color.white:Color(.lightGray))
                            .cornerRadius(50)
                            .padding(.leading)
                        Text("C. \(secondAnswer)")
                            .font(.caption)
                            .foregroundColor(Color(.darkGray))
                            .lineLimit(3)
                    })
                }.frame(width: data.mainViewWidth/2 - 20)
                
                VStack(alignment: .leading){
                    Button(action: {index=3}, label: {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(index==3 ? Color.black:Color(.lightGray))
                            .background(index==3 ? Color.white:Color(.lightGray))
                            .cornerRadius(50)
                            .padding(.leading)
                        Text("B. \(thirdAnswer)")
                            .font(.caption)
                            .foregroundColor(Color(.darkGray))
                            .lineLimit(3)
                    }).padding(.bottom)
                    Button(action: {index=4}, label: {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(index==4 ? Color.black:Color(.lightGray))
                            .background(index==4 ? Color.white:Color(.lightGray))
                            .cornerRadius(50)
                            .padding(.leading)
                        Text("D. \(fourthAnswer)")
                            .font(.caption)
                            .foregroundColor(Color(.darkGray))
                            .lineLimit(3)
                    })
                }.frame(width: data.mainViewWidth/2 - 20)

            }.padding(.bottom)
            .frame(width: data.mainViewWidth - 40)

                
        }
        .frame(width: data.mainViewWidth - 40)
        .background(Color.white)
        .cornerRadius(10)
        .onTapGesture {
            //Todo . . .
            data.showStudentExamMark = true
        }
    }
}
struct examQuestions:View{
    @EnvironmentObject var data:data
    @FetchRequest(entity: Exam.entity(), sortDescriptors: []) var exams:FetchedResults<Exam>
    @Environment(\.managedObjectContext) var moc
    var body: some View{
        VStack(spacing: 10){
            ForEach(0..<getTheDataForQuestion().count){ index in
                ExamQuestionView(question: getTheDataForQuestion()[index].question, firstAnswer: getTheDataForQuestion()[index].correctAnswer, secondAnswer: getTheDataForQuestion()[index].answers[0], thirdAnswer:  getTheDataForQuestion()[index].answers[1], fourthAnswer:  getTheDataForQuestion()[index].answers[2],mark: getTheQuestionMark(),questionNo: index+1)
            }
        }
    }
    func getTheDataForQuestion()->[questionStructure]{
        var result = Array<questionStructure>()
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Exam")
        fetch.predicate = NSPredicate.init(format: "id = %@", data.previewExamId as CVarArg)
        do {
            if try moc.fetch(fetch).count > 0 {
                let fetchResult = try moc.fetch(fetch)
                let targetExam = fetchResult[0] as! Exam
                let targetQuestions = targetExam.allQuestion
                for question in targetQuestions {
                    var newQuestion = questionStructure()
                    newQuestion.question = question.question!
                    newQuestion.correctAnswer = question.correctAnswer!
                    for item in question.allQuestions {
                        newQuestion.answers.append(item.question!)
                    }
                    result.append(newQuestion)
                }
            }
        }catch{
            print(error.localizedDescription)
        }
        return result
    }
    func getTheQuestionMark()->Int{
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Exam")
        fetch.predicate = NSPredicate.init(format: "id = %@", data.previewExamId as CVarArg)
        var result = 0
        do {
            if try moc.fetch(fetch).count > 0 {
                let fetchResult = try moc.fetch(fetch)
                let targetExam = fetchResult[0] as! Exam
                let targetQuestions = targetExam.allQuestion
                result = targetQuestions.count
            }
        }catch{
            print(error.localizedDescription)
        }
        return result
    }
    struct questionStructure:Identifiable{
        var id = 0
        var question:String = ""
        var correctAnswer:String = ""
        var answers = Array<String>()
    }
}
