//
//  studentAnswerPreivew.swift
//  schoolDashboard
//
//  Created by admin on 2021/7/3.
//

import SwiftUI
import CoreData

struct studentAnswerPreivew: View {
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        ZStack{
            VStack{
                ScrollView(showsIndicators: false){
                    SexamHeader(examName: getTargetExam().examName!, startExamTime: getTargetExam().examStartTime!, endExamTime: getTargetExam().examEndTime!)
                    SstudentExamQuestions()
                }
            }
        }
    }
    func getTargetExam()->(examName:String?,examStartTime:Date?,examEndTime:Date?){
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Exam")
        fetch.predicate = NSPredicate.init(format: "id = %@", data.showStudentAnswerPreivewID as CVarArg)
        var resultExamName = ""
        var resultExamStartTime = Date()
        var resultExamEndTime = Date()
            do{
                if try moc.fetch(fetch).count > 0 {
            let fetchResult = try moc.fetch(fetch)
            let targetExam = fetchResult[0] as! Exam
                    resultExamName = targetExam.examName ?? "unkown"
                    resultExamStartTime = targetExam.examStartTime ?? Date()
                    resultExamEndTime = targetExam.examEndTime ?? Date()
             }
            }catch{
                print(error.localizedDescription)
            }
            return (resultExamName,resultExamStartTime,resultExamEndTime)
    }
}

struct studentAnswerPreivew_Previews: PreviewProvider {
    static var previews: some View {
        studentAnswerPreivew()
    }
}
struct SexamHeader:View{
    @State var examName = ""
    @State var startExamTime = Date()
    @State var endExamTime = Date()
    @State var examReminderHour = 0
    @State var examReminderMinute = 0
    @State var examReminderSecond = 0
    var time = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @EnvironmentObject var data:data
    @State var currentDate = Date()
    @FetchRequest(entity: Exam.entity(), sortDescriptors: []) var exams:FetchedResults<Exam>
    @FetchRequest(entity: ExamQuestion.entity(), sortDescriptors: []) var examQuestion:FetchedResults<ExamQuestion>
    var body: some View{
        VStack(alignment:.leading){
            Text(examName)
                .bold()
                .font(.title)
                .foregroundColor(Color.black)
                .padding()

            Button(action: {data.showStudentAnswerForTeacher = false}, label: {
                HStack{
                    Image(systemName: "arrow.left.circle.fill")
                        .foregroundColor(Color(.darkGray))
                    Text("Go back")
                        .font(.caption)
                        .foregroundColor(Color(.darkGray))
                }
            }).padding(.bottom)

            HStack{
                Spacer()
                if endExamTime < Date() {
                    Text("Finished").foregroundColor(Color(.darkGray)).font(.caption2).padding()
                } else {
                Text("\(examReminderHour)h \(examReminderMinute)min \(examReminderSecond)sec").foregroundColor(Color(.darkGray)).font(.caption2)
                    .onReceive(time, perform: { i in
                        if endExamTime > Date(){
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
            if endExamTime < Date() {
            HStack{
                Spacer()
                Text("\(String(format: "%.2f", getTheFinalMark())) mark")
                    .bold()
                    .foregroundColor(getTheFinalMark() > 50 ? Color.blue:.red)
                    .font(.title3).padding()
                Spacer()
            }
          }

        }.onAppear(perform: getTheTime)
    }
    func getTheTime(){
        let format = ISO8601DateFormatter()
        var f:DateFormatter{
            let format = DateFormatter()
            format.timeStyle = .short
            return format
        }
        let date1 = format.date(from:format.string(from:  currentDate))
        let date2 = format.date(from: format.string(from: endExamTime))
        let diff = Calendar.current.dateComponents([.second,.minute,.hour],from: date1! ,to: date2!)
        examReminderSecond = diff.second ?? 0
        examReminderMinute = diff.minute ?? 0
        examReminderHour = diff.hour ?? 0
    }
    func getTheFinalMark() ->Double{
        var result:Double = 0
        var totalQuestions = 0 , totalCorrectAnswer = 0
        for exam in exams {
            if exam.id == data.studentExamPreviewID {
                totalQuestions=exam.allQuestion.count
                for question in examQuestion {
                    if question.examId == exam.id {
                        if question.fromExamQuestionToStudentAnswer?.answer == 1 && data.showStudentAnswerPreivewStudentName ==  question.fromExamQuestionToStudentAnswer?.studentName!{
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

struct SstudentExamQuestions:View{
    @EnvironmentObject var data:data
    @FetchRequest(entity: Exam.entity(), sortDescriptors: []) var exams:FetchedResults<Exam>
    @Environment(\.managedObjectContext) var moc
    @State var randomAarray = Array<Int>()
    var body: some View{
        VStack(spacing: 10){
            ForEach(0..<getTheDataForQuestion().count,id:\.self){ index in
                SstudentExamQuestionView(question: getTheDataForQuestion()[index].question,correctAnswer: getTheDataForQuestion()[index].correctAnswer, firstAnswer: getTheDataForQuestion()[index].answers[0], secondAnswer: getTheDataForQuestion()[index].answers[1], thirdAnswer:  getTheDataForQuestion()[index].answers[2], fourthAnswer:  getTheDataForQuestion()[index].answers[3],mark: getTheQuestionMark(),questionNo: index+1,examEndTime: getTheDataForQuestion()[index].endExamTime,examDuration: getTheDataForQuestion()[index].examDuration,questionID: getTheDataForQuestion()[index].id,questionIndex: index)
            }
        }
    }
    func getRandomIntegerArray()->[Int]{
        var result = Array<Int>()
        while result.count < 4 {
            let randomNumber = Int.random(in: 0..<4)
            if !result.contains(randomNumber){
                result.append(randomNumber)
            }
        }
        return result
    }
    func getTheDataForQuestion()->[questionStructure]{
        var result = Array<questionStructure>()
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Exam")
        fetch.predicate = NSPredicate.init(format: "id = %@", data.showStudentAnswerPreivewID as CVarArg)
        do {
            if try moc.fetch(fetch).count > 0 {
                let fetchResult = try moc.fetch(fetch)
                let targetExam = fetchResult[0] as! Exam
                let targetQuestions = targetExam.allQuestion
                var temp = Array<String>()
                for question in targetQuestions {
                    var newQuestion = questionStructure()
                    newQuestion.question = question.question!
                    newQuestion.correctAnswer = question.correctAnswer!
                    for item in question.allQuestions {
                          temp.append(item.question!)
                    }

                    temp.append(question.correctAnswer!)

                    for index in getRandomIntegerArray() {
                        newQuestion.answers.append(temp[index])
                    }

                    newQuestion.endExamTime = targetExam.examEndTime ?? Date()
                    newQuestion.examDuration = targetExam.examDuration
                    newQuestion.id = question.qId
                    result.append(newQuestion)
                    temp.removeAll()
                }
            }
            print("sorry no data")
        }catch{
            print(error.localizedDescription)
        }
        return result
    }
    func getTheQuestionMark()->Int{
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Exam")
        fetch.predicate = NSPredicate.init(format: "id = %@", data.showStudentAnswerPreivewID as CVarArg)
        var result = 0
        do {
            if try moc.fetch(fetch).count > 0 {
                let fetchResult = try moc.fetch(fetch)
                let targetExam = fetchResult[0] as! Exam
                let targetQuestions = targetExam.allQuestion
                result = 100 /  targetQuestions.count
            }
        }catch{
            print(error.localizedDescription)
        }
        return result
    }
    struct questionStructure:Identifiable{
        var id = UUID()
        var question:String = ""
        var correctAnswer:String = ""
        var answers = Array<String>()
        var endExamTime = Date()
        var examDuration:Int16 = 0
    }
}
struct SstudentExamQuestionView:View{
    @State var question = ""
    @State var correctAnswer = ""
    @State var firstAnswer = ""
    @State var secondAnswer = ""
    @State var thirdAnswer = ""
    @State var fourthAnswer = ""
    @State var mark:Int = 0
    @State var questionNo = 0
    @State var examEndTime = Date()
    @State var examDuration:Int16 = 0
    @State var questionID = UUID()
    @State var questionIndex = 0
    @EnvironmentObject var data:data
    @State var index = 0
    @FetchRequest(entity: Exam.entity(), sortDescriptors: []) var exams:FetchedResults<Exam>
    @Environment(\.managedObjectContext) var moc
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("\(questionNo).")
                    .foregroundColor(Color(.lightGray))
                    .font(.custom("", size: 7))
                    .padding(.leading,10)
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
                    Button(action: {
                            index=1
                    }, label: {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(index==1 ? Color.black:Color(.lightGray))
                            .background(index==1 ? Color.white:Color(.lightGray))
                            .cornerRadius(50)
                            .padding(.leading)
                        Text("A. \(firstAnswer)")
                            .font(.caption)
                            .foregroundColor(Color(.darkGray))
                            .lineLimit(3)
                    }).padding(.bottom)
                    .disabled(isAvailable())
                    Button(action: {
                            index=2
                    }, label: {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(index==2 ? Color.black:Color(.lightGray))
                            .background(index==2 ? Color.white:Color(.lightGray))
                            .cornerRadius(50)
                            .padding(.leading)
                        Text("C. \(secondAnswer)")
                            .font(.caption)
                            .foregroundColor(Color(.darkGray))
                            .lineLimit(3)
                    }).disabled(isAvailable())

                }.frame(width: data.mainViewWidth/2 - 20)

                VStack(alignment: .leading){
                    Button(action: {
                            index=3
                    }, label: {
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
                    .disabled(isAvailable())
                    Button(action: {
                            index=4
                    }, label: {
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
                    .disabled(isAvailable())
                }.frame(width: data.mainViewWidth/2 - 20)

            }.padding(.bottom)
            .frame(width: data.mainViewWidth - 40)

            if Date() > examEndTime {
            VStack(alignment: .leading){
                Text("Correct Answer : \(correctAnswer)")
                    .font(.caption)
                    .foregroundColor(.black)

                Text("Student Answer : \(getStudentAnswer())")
                    .font(.caption)
                    .foregroundColor(.black)

            }.padding(.leading)
            .padding(.top)
         }


        }
        .frame(width: data.mainViewWidth - 40)
        .background(Color.white)
        .cornerRadius(10)
    }
    func isAvailable()->Bool{
        if Date() > examEndTime {
            return true
        } else if Date() > getTheStartingExam().addingTimeInterval(TimeInterval(Int(examDuration*60))) {
            return true
        } else if isTheExamDone() {
            return true
        } else {
            return false
        }
    }
    func getTheStartingExam() ->Date{
        var result = Date()
        if exams.count > 0 {
        for exam in exams {
            if exam.id == data.studentExamPreviewID {
                for item in exam.allAnswer {
                    if item.studentName! == data.showStudentAnswerPreivewStudentName {
                        result = item.startAnsweringDate ?? Date()

                    }
                }
            }
        }
     }
        return result
    }
    func isTheExamDone()->Bool{
        if exams.count > 0 {
        for exam in exams {
            if exam.id == data.studentExamPreviewID {
                for item in exam.allAnswer {
                    if item.studentName! == data.showStudentAnswerPreivewStudentName {
                        if item.answer == 1000 {
                            return true
                        }

                    }
                }
            }
        }
     }
    return false
    }

    func getStudentAnswer()->String{
        var result = ""
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "StudentAnswer")
        fetch.predicate = NSPredicate.init(format: "qId = %@", questionID as CVarArg)
        do {
            if try moc.fetch(fetch).count > 0 {
                let fetchResult = try moc.fetch(fetch)
                let targetAnswer = fetchResult[0] as! StudentAnswer
                if targetAnswer.studentName! == data.showStudentAnswerPreivewStudentName {
                result = targetAnswer.stringAnswer ?? "unkown"
              }
            }
        }catch{
            print(error.localizedDescription)
        }
        return result
    }
}
