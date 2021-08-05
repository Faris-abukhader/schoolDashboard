//
//  createExamWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/25.
//

import SwiftUI
import CoreData

struct createExamWindow: View {
    @State var examName = ""
    @State var gradeName = ""
    @FetchRequest(entity: Exam.entity(), sortDescriptors: []) var exams:FetchedResults<Exam>
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        ZStack{
            
            ScrollView(showsIndicators: false){
                VStack{
                    VStack(alignment: .leading){
                        backToView()
                        headerWithMainInfoForExam()
                        choosingTime()
                    }
                    addingQuestionsView()
                    HStack{
                        Text("Adding a new question should be with adding four answer.")
                            .foregroundColor(Color(.darkGray))
                            .font(.custom("", size: 7))
                            .padding(.leading)
                        Spacer()
                    }
                    if fetchExamQuestions().count != 0 {
                        HStack{
                            Text("Your Questions :")
                                .bold()
                                .foregroundColor(.black)
                                .font(.title)
                                .padding()
                            Spacer()
                        }
                        List{
                            ForEach(fetchExamQuestions().sorted{
                                return $0.question! > $1.question!
                            }){question in
                                questionListItem(question: question.question!, examQuestion: question)
                            }
                        }
                        .frame(width: data.mainViewWidth - 40, height: data.mainViewHeight / 3)
                        .cornerRadius(10)
                        HStack{
                            Text("at least you need to add five questions to be able to share the exam.")
                                .foregroundColor(Color(.darkGray))
                                .font(.custom("", size: 7))
                                .padding(.leading)
                            Spacer()
                        }
                        
                    }
                    
                    if fetchExamQuestions().count >= 5 {
                        shareExam()
                    }
                    
                }
            }
            
            if data.showEditQuestionWindow {
                editQuestionWindow(question: data.questionData[0], correctAnswer: data.questionData[1], secondAnswer: data.questionData[2], thirdAnswer: data.questionData[3], fourthAnswer: data.questionData[4], questionId: data.questionDataId)
            }
        }
    }
    struct box:Identifiable {
        let id = 0
        let name:String
        let isCorrect:Bool
        var item:[box]?
    }
    func fetchExamQuestions()->[ExamQuestion]{
        var result = Array<ExamQuestion>()
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Exam")
        fetch.predicate = NSPredicate.init(format: "id = %@", data.examId as CVarArg)
        do {
            if try moc.fetch(fetch).count > 0 {
                let fetchResult = try moc.fetch(fetch)
                let targetExam = fetchResult[0] as! Exam
                let questions = targetExam.allQuestion
                for question in questions {
                    result.append(question)
                }
            }
        }catch{
            
        }
        return result
    }
    
    func GetDataIntoBox()->[box]{
        var result = Array<box>()
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Exam")
        fetch.predicate = NSPredicate.init(format: "id = %i", data.examId as CVarArg)
        do {
            if try moc.fetch(fetch).count > 0 {
                let fetchResult = try moc.fetch(fetch)
                let targetExam = fetchResult[0] as! Exam
                
                 for answers in targetExam.allQuestion {
                    var subList = box(name: answers.question!, isCorrect: true)
                    for a in answers.allQuestions {
                        let subListItem = box(name: a.question!, isCorrect: false)
                        subList.item?.append(subListItem)
                        result.append(subList)
                        }
                    }
                
             }

            }catch{
                print(error.localizedDescription)
            }
        return result
    }
  
}

struct createExamWindow_Previews: PreviewProvider {
    static var previews: some View {
        createExamWindow()
    }
}
struct headerWithMainInfoForExam:View{
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    var body: some View{
        ZStack{
            Rectangle()
                .frame(width: data.mainViewWidth - 40, height: data.mainViewHeight / 9)
                .foregroundColor(.white)
                .cornerRadius(10)
            
            HStack{
                Text("Exam name :")
                    .foregroundColor(.black)
                    .font(.caption)
                    .padding(.leading)
                
                TextField("exam name...", text: $data.examName)
                    .font(.caption)
                    .frame(width:data.mainViewWidth/4 - 5,height: 20)
                    .padding(5)
                    .background(Color("lightGry"))
                    .cornerRadius(5)
                
                Text("Grade Name : ")
                    .foregroundColor(.black)
                    .font(.caption)
                    .padding(.leading)
                
                Button(action: {}, label: {
                    Button(action: {data.showGradeList.toggle()}, label: {
                        ZStack(alignment: .topLeading){
                            Rectangle()
                                .frame(width: data.mainViewWidth/4 + 5, height: 30)
                                .cornerRadius(5)
                                .foregroundColor(data.examGrade.isEmpty ? Color("lightGry"):Color(.lightGray))
                            HStack{
                                Text(data.examGrade.isEmpty ? "GradeName":data.examGrade)
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
                        }.frame(width: data.mainViewWidth/4,height: 25)
                    })

                })
                
                Button(action: {updateExamInfo()}, label: {
                    Text("save")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.vertical,5)
                        .padding(.horizontal,10)
                        .background(Color("yellow"))
                        .cornerRadius(5)
                        .padding(.trailing,10)
                })
                
            }.onTapGesture {
                data.showGradeList=false
            }
            
            if data.showGradeList {
                GradeList()
                    .offset(x: data.show ? data.mainViewWidth/4 - 5 : data.mainViewWidth/4 - 25, y: 20)
            }
        }
    }
    func updateExamInfo(){
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Exam")
        fetch.predicate = NSPredicate.init(format: "id = %@", data.examId as CVarArg)
        do {
            let fetchResult = try moc.fetch(fetch)
            let targetExeam = fetchResult[0] as! NSManagedObject
            targetExeam.setValue(data.examName, forKey: "examName")
            targetExeam.setValue(data.examGrade, forKey: "gradeName")
            do {
               try moc.save()
            }catch{
                print(error.localizedDescription)
            }

        }catch{
            print(error.localizedDescription)
        }
    }
}

struct GradeList:View{
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    var body: some View {
            ZStack{
            Rectangle()
                .frame(width: data.mainViewWidth/4 + 5, height: 100)
                .foregroundColor(Color(.lightGray))
                .cornerRadius(5)
                ScrollView{
                    ForEach(0..<allTeacherGrades().count) {index in
                        Button(action: {
                            data.examGrade = allTeacherGrades()[index]
                            data.showGradeList = false
                        }, label: {
                            VStack{
                                HStack{
                                    Text("\(allTeacherGrades()[index])")
                                        .padding(10)
                                        .font(.caption2)
                                        .foregroundColor(.white)

                                    Spacer()
                                }
                                Path(CGPath(roundedRect: CGRect(x: 0, y: 0, width: data.mainViewWidth/4 - 10, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil)).foregroundColor(.white)
                            }
                        })
                    }
                }.frame(width: data.mainViewWidth/4 + 5, height: 100)
          }
            .offset(x:5,y: 40)
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
}

struct addingQuestionsView:View{
    @EnvironmentObject var data:data
    @State var question = ""
    @State var correctAnswer = ""
    @State var secondAnswer = ""
    @State var thirdAnswer = ""
    @State var fourthAnswer = ""
    @State var showAlert = false
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack(alignment: .center){
            
            HStack{
                Text("Add new question :")
                    .bold()
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding()
                Spacer()
            }
            TextField("Question...", text: $question)
                .font(.caption)
                .frame(width:data.mainViewWidth/1.3,height: 20)
                .padding(5)
                .background(Color("lightGry"))
                .cornerRadius(5)
                .padding(.top)
        
            TextField("Correct answer...", text: $correctAnswer)
                    .font(.caption)
                    .frame(width:data.mainViewWidth/1.3,height: 20)
                    .padding(5)
                    .background(Color("lightGry"))
                    .cornerRadius(5)
            
            
            TextField("Second answer...", text: $secondAnswer)
                    .font(.caption)
                    .frame(width:data.mainViewWidth/1.3,height: 20)
                    .padding(5)
                    .background(Color("lightGry"))
                    .cornerRadius(5)

            
            
            TextField("Third answer...", text: $thirdAnswer)
                    .font(.caption)
                    .frame(width:data.mainViewWidth/1.3,height: 20)
                    .padding(5)
                    .background(Color("lightGry"))
                    .cornerRadius(5)

            
            TextField("Fourth answer...", text: $fourthAnswer)
                    .font(.caption)
                    .frame(width:data.mainViewWidth/1.3,height: 20)
                    .padding(5)
                    .background(Color("lightGry"))
                    .cornerRadius(5)

                
                Button(action: {
                    if question.isEmpty || correctAnswer.isEmpty || secondAnswer.isEmpty || thirdAnswer.isEmpty || fourthAnswer.isEmpty {
                        showAlert = true
                    } else {
                      addnewQuestion()
                        question = ""
                        correctAnswer = ""
                        secondAnswer = ""
                        thirdAnswer = ""
                        fourthAnswer = ""
                    }
                }, label: {
                    Text("Add")
                        .font(.caption)
                        .foregroundColor(Color.black)
                        .padding(.vertical,5)
                        .padding(.horizontal,10)
                        .background(Color("yellow"))
                        .cornerRadius(10)
                        .padding()

                })
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Warning"), message: Text("make sure that you entered the question and the all answers."), dismissButton: Alert.Button.cancel())
                })

                
                

            
        }.frame(width: data.mainViewWidth - 40)
        .background(Color.white)
        .cornerRadius(10)
    }
    func addnewQuestion(){
        let questionId =  UUID()
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Exam")
        fetch.predicate = NSPredicate.init(format: "id = %@", data.examId as CVarArg)
        do {
            if try moc.fetch(fetch).count > 0 {
                let fetchResult = try moc.fetch(fetch)
                let targetExam = fetchResult[0] as! Exam
                let theExam  = targetExam.fromExamToExamQuestion
                let newQuestion = ExamQuestion(context: moc)
                newQuestion.examId = data.examId
                newQuestion.correctAnswer = correctAnswer
                newQuestion.question = question
                newQuestion.qId = questionId
                newQuestion.fromExamQuestionToExam = targetExam
                theExam?.adding(newQuestion)
                do {
                    try moc.save()
                }catch{
                    print(error.localizedDescription)
                }
            }
        }catch{
            print(error.localizedDescription)
        }
        addSubAnswer(questionId: questionId)
    }
    
    func addSubAnswer(questionId:UUID){
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "ExamQuestion")
        fetch.predicate = NSPredicate.init(format: "qId = %@", questionId as CVarArg)
        do {
        if try moc.fetch(fetch).count > 0 {
            let fetchResult = try moc.fetch(fetch)
            let targetQuestion = fetchResult[0] as! ExamQuestion
            
            let subQuestions2 = Questions(context: moc)
            subQuestions2.id = questionId
            subQuestions2.question = secondAnswer
            subQuestions2.fromQuestionsToExamQuestion = targetQuestion
            
            let subQuestions3 = Questions(context: moc)
            subQuestions3.id = questionId
            subQuestions3.question = thirdAnswer
            subQuestions3.fromQuestionsToExamQuestion = targetQuestion
            
            let subQuestions4 = Questions(context: moc)
            subQuestions4.id = questionId
            subQuestions4.question = fourthAnswer
            subQuestions4.fromQuestionsToExamQuestion = targetQuestion
            
            do{
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
struct questionListItem:View{
    @State var question = ""
    @State var examQuestion = ExamQuestion()
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    @State var showSubList = false
    @State var showAlertForDeleting = false
    @State var answers = Array<String>()
    var body: some View {
        VStack{
        HStack{
            Text("\(question)")
                .foregroundColor(.black)
                .font(.caption)
                .padding(.leading,10)
            Spacer()
            Image(systemName: "pencil.circle.fill")
                .foregroundColor(.black)
                .padding(.trailing,10)
                .onTapGesture {
                    // Todo . . .
                    data.showEditQuestionWindow = true
                    var datafor = Array<String>()
                    datafor.append(question)
                    datafor.append(examQuestion.correctAnswer!)
                    datafor.append(examQuestion.allQuestions[0].question!)
                    datafor.append(examQuestion.allQuestions[1].question!)
                    datafor.append(examQuestion.allQuestions[2].question!)
                    data.questionData = datafor
                    data.questionDataId = examQuestion.qId

                }
            
            Image(systemName: "minus.circle.fill")
                .foregroundColor(.red)
                .padding(.trailing,10)
                .onTapGesture {
                    // Todo . . .
                    showAlertForDeleting=true

                }
                .alert(isPresented: $showAlertForDeleting, content: {
                    Alert(title: Text("Warning"), message: Text("Are you sure you want to delete this question?"), primaryButton: Alert.Button.default(Text("delete"), action: {
                        deleteQuestion()
                    }), secondaryButton: Alert.Button.cancel())
                })

            
            Image(systemName: showSubList ? "arrow.up.circle.fill":"arrow.down.circle.fill")
                .foregroundColor(.black)
                .padding(.trailing,10)
                .onTapGesture {
                    // Todo . . .
                    showSubList.toggle()
                    data.showAnswerListQuestion = question
                    for item in examQuestion.allQuestions {
                        answers.append(item.question!)
                    }
                    
                }
            
        }
            if showSubList {
                List {
                    HStack{
                        Text(examQuestion.correctAnswer ?? "Unfound")
                            .font(.caption)
                            .foregroundColor(.black)
                            .padding(.leading,30)
                        
                        Spacer()
                        Text("correct answer")
                            .foregroundColor(.green)
                            .font(.caption2)
                            .padding(.trailing)
                    }
                    ForEach(0..<answers.count) {index in
                        HStack{
                            Text(answers[index])
                                .font(.caption)
                                .foregroundColor(.black)
                                .padding(.leading,30)
                            Spacer()
                        }
                    }
                }
            }
            
        }.frame(height: showSubList ? 150 : 40)
    }
    
    func deleteQuestion(){
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "ExamQuestion")
        fetch.predicate = NSPredicate.init(format: "qId = %@", examQuestion.qId as CVarArg)
        do {
            if try moc.fetch(fetch).count > 0 {
                let fetchResult = try moc.fetch(fetch)
                let targetExamQuestion = fetchResult[0] as! ExamQuestion
                let targetQuestions = targetExamQuestion.allQuestions
                for item in targetQuestions {
                    moc.delete(item)
                }
                moc.delete(targetExamQuestion)
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
struct questionAnswerSublist:View{
    @State var answer = ""
    @State var isCorrrect = false
    var body: some View {
        HStack{
            
            Text("\(answer)")
                .font(.caption)
                .foregroundColor(Color(.darkGray))
                .padding(.leading,30)
            
            Spacer()
            
            Text(isCorrrect ? "correct answer":"")
                .foregroundColor(.green)
                .font(.caption2)
                .padding(.trailing,10)
            
        }
    }
}
struct shareExam:View {
    @EnvironmentObject var data:data
    @State var showAlert = false
    var body: some View {
        VStack{
            Button(action: {
                    data.showCreatingExamPage=false
                if data.showDateAlert {
                    showAlert = true
                }
            }, label: {
                Text("Save & Share")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.vertical,5)
                    .padding(.horizontal,10)
                    .background(Color("yellow"))
                    .cornerRadius(10)
                
            })
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Warning"), message: Text("Check again exam date again , then save it."), dismissButton: Alert.Button.cancel())
            })
        }.frame(width: data.mainViewWidth - 40, height: 100)
        .background(Color.white)
        .cornerRadius(10)
    }
}
struct backToView:View{
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    @State var showAlert = false
    var body: some View {
        VStack(alignment:.leading){
            Text("Create Exam Page ")
                .bold()
                .padding()
                .foregroundColor(.black)
                .font(.title)
            
            Button(action: {showAlert.toggle()}, label: {
                HStack{
                    Image(systemName: "arrow.left.circle.fill")
                        .foregroundColor(Color(.darkGray))
                    Text("Go back")
                        .font(.caption)
                        .foregroundColor(Color(.darkGray))
                }
            })
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Warning"), message: Text("You did share the exam doing this operation will delete this exam"), primaryButton: Alert.Button.cancel(), secondaryButton: Alert.Button.destructive(Text("delete"), action: {
                    data.showCreatingExamPage = false
                    deleteExam()
                }))
            })
            
            
        }
    }
    
    func deleteExam(){
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Exam")
        fetch.predicate = NSPredicate.init(format: "id = %@", data.examId as CVarArg)
        do {
            if try moc.fetch(fetch).count > 0 {
                let fetchResult = try moc.fetch(fetch)
                let targetExam = fetchResult[0] as! Exam
                let targetQuestions = targetExam.allQuestion
                for question in targetQuestions {
                    for answer in question.allQuestions {
                        moc.delete(answer)
                    }
                    moc.delete(question)
                }
                moc.delete(targetExam)
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
struct choosingTime:View{
    @State var startTime = Date()
    @State var endTime = Date()
    @State var examDuration:Int = 0
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    @State var showAlertForDates = false
    @State var showAlertForExamDuration = false
    @State var isAdded = false
    var body: some View{
        VStack{
            HStack{
                Text("Choose exam starting time:").font(.caption).foregroundColor(Color.black).padding(.leading)
                DatePicker("", selection: $startTime).padding(.vertical)
                Spacer()
            }.frame(width: data.mainViewWidth - 40)
            HStack{
                Text("Choose exam ending time:").font(.caption).foregroundColor(Color.black).padding(.leading)
                DatePicker("", selection: $endTime)
                Spacer()
            }.frame(width: data.mainViewWidth - 40)
            HStack{
                Text("Exam duration (minute) :").font(.caption).foregroundColor(Color.black).padding(.leading)
                Spacer()
                TextField("", text: Binding(get: {String(examDuration)}, set: {examDuration = Int($0) ?? 0}))
                    .font(.caption)
                    .frame(width:25,height: 20)
                    .padding(5)
                    .background(Color("lightGry"))
                    .cornerRadius(5)
                    .padding()
                    .keyboardType(.numberPad)
            }.frame(width: data.mainViewWidth - 40)
            .alert(isPresented: $showAlertForExamDuration, content: {
                Alert(title: Text("Warning"), message: Text("Make sure that exam duration is longer than zero and shorter than 120 min."), dismissButton: Alert.Button.cancel())
            })
            
            Button(action: {
                if startTime == endTime {
                    showAlertForDates = true
                    data.showDateAlert = true
                }else if examDuration <= 0 || examDuration > 120 {
                    showAlertForExamDuration = true
                    data.showDateAlert = true
                } else if isAdded {
                    updateTimeForExam()
                    data.showDateAlert = false
                }else {
                    addingTimeForExam()
                    isAdded=true
                    data.showDateAlert = false
                }
            }, label: {
                Text("save")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.vertical,5)
                    .padding(.horizontal,10)
                    .background(Color("yellow"))
                    .cornerRadius(10)
                    .padding(.bottom)
            })
            .alert(isPresented: $showAlertForDates, content: {
                Alert(title: Text("Warning"), message: Text("Make sure that is the date you choose is correct."), dismissButton: Alert.Button.cancel())
            })

            
        }.frame(width: data.mainViewWidth - 40)
        .background(Color.white)
        .cornerRadius(10)
    }
    func addingTimeForExam(){
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Exam")
        fetch.predicate = NSPredicate.init(format: "id = %@", data.examId as CVarArg)
        do {
            if try moc.fetch(fetch).count > 0 {
                let fetchResult = try moc.fetch(fetch)
                let targetExamQuestion = fetchResult[0] as! Exam
                targetExamQuestion.examStartTime = startTime
                targetExamQuestion.examEndTime = endTime
                targetExamQuestion.examDuration = Int16(examDuration)
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
    
    func updateTimeForExam(){
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Exam")
        fetch.predicate = NSPredicate.init(format: "id = %@", data.examId as CVarArg)
        do {
            if try moc.fetch(fetch).count > 0 {
                let fetchResult = try moc.fetch(fetch)
                let targetExamQuestion = fetchResult[0] as! NSManagedObject
                targetExamQuestion.setValue(startTime, forKey: "examStartTime")
                targetExamQuestion.setValue(endTime, forKey: "examEndTime")
                targetExamQuestion.setValue(examDuration, forKey: "examDuration")
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
