//
//  editQuestionWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/26.
//

import SwiftUI
import CoreData

struct editQuestionWindow: View {
    @State var question:String = ""
    @State var correctAnswer:String = ""
    @State var secondAnswer:String = ""
    @State var thirdAnswer:String = ""
    @State var fourthAnswer:String = ""
    @State var questionId = UUID()
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    @State var showAlert = false
    @FetchRequest(entity: Questions.entity(), sortDescriptors: []) var answers:FetchedResults<Questions>
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
                .frame(width:data.mainViewWidth/2 - 20,height: 20)
                .padding(5)
                .background(Color("lightGry"))
                .cornerRadius(5)
                .padding(.top)
                .padding(.horizontal,5)
        
            TextField("Correct answer...", text: $correctAnswer)
                    .font(.caption)
                    .frame(width:data.mainViewWidth/2 - 20,height: 20)
                    .padding(5)
                    .background(Color("lightGry"))
                    .cornerRadius(5)
                    .padding(.horizontal,5)
            
            
            TextField("Second answer...", text: $secondAnswer)
                    .font(.caption)
                    .frame(width:data.mainViewWidth/2 - 20,height: 20)
                    .padding(5)
                    .background(Color("lightGry"))
                    .cornerRadius(5)
                    .padding(.horizontal,5)

            
            
            TextField("Third answer...", text: $thirdAnswer)
                    .font(.caption)
                    .frame(width:data.mainViewWidth/2 - 20,height: 20)
                    .padding(5)
                    .background(Color("lightGry"))
                    .cornerRadius(5)
                    .padding(.horizontal,5)


            
            TextField("Fourth answer...", text: $fourthAnswer)
                    .font(.caption)
                    .frame(width:data.mainViewWidth/2 - 20,height: 20)
                    .padding(5)
                    .background(Color("lightGry"))
                    .cornerRadius(5)
                    .padding(.horizontal,5)


            HStack{
                Spacer()
                
                Button(action: {data.showEditQuestionWindow=false}, label: {
                    Text("Cancel")
                        .font(.caption)
                        .foregroundColor(Color.black)
                        .padding(.vertical,5)
                        .padding(.horizontal,10)
                        .background(Color("yellow"))
                        .cornerRadius(10)
                        .padding()
                })
                
                Button(action: {
                    if question.isEmpty || correctAnswer.isEmpty || secondAnswer.isEmpty || thirdAnswer.isEmpty || fourthAnswer.isEmpty {
                        showAlert = true
                    } else {
                        updateQuestion(question: question, questionId: questionId, correctAnswer: correctAnswer, secondAnswer: secondAnswer, thirdAnswer: thirdAnswer, fourthAnswer: fourthAnswer)
                        question = ""
                        correctAnswer = ""
                        secondAnswer = ""
                        thirdAnswer = ""
                        fourthAnswer = ""
                        data.showEditQuestionWindow=false
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
                    Alert(title: Text("Warning"), message: Text("make sure you filled all question info."), dismissButton: Alert.Button.cancel())
                })
                Spacer()
            }
                

                
                

            
        }.frame(width: data.mainViewWidth/2 + 30,height: data.mainViewHeight/3)
        .background(Color.white)
        .cornerRadius(10)

    }
    
    func updateQuestion(question:String,questionId:UUID,correctAnswer:String,secondAnswer:String,thirdAnswer:String,fourthAnswer:String){
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "ExamQuestion")
        fetch.predicate = NSPredicate.init(format: "qId = %@", questionId as CVarArg)
        let fetch1:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Questions")
        fetch1.predicate = NSPredicate.init(format: "id = %@", questionId as CVarArg)
        do {
            if try moc.fetch(fetch).count > 0  &&  moc.fetch(fetch1).count > 0 {
                let fetchResult = try moc.fetch(fetch)
                let targetExamQuestionForEdit = fetchResult[0] as! NSManagedObject
                targetExamQuestionForEdit.setValue(question, forKey: "question")
                targetExamQuestionForEdit.setValue(correctAnswer, forKey: "correctAnswer")
                
                
                let target = fetchResult[0] as! ExamQuestion
                let target1 = target.allQuestions
                
                for item in target1 {
                    moc.delete(item)
                    try! moc.save()
                }
                
                
                
                let targetExamQuestion = fetchResult[0] as! ExamQuestion

                let newAnswers2 = Questions(context: moc)
                newAnswers2.fromQuestionsToExamQuestion = targetExamQuestion
                newAnswers2.id = questionId
                newAnswers2.question = secondAnswer
                
                let newAnswers3 = Questions(context: moc)
                newAnswers3.fromQuestionsToExamQuestion = targetExamQuestion
                newAnswers3.id = questionId
                newAnswers3.question = thirdAnswer

                
                let newAnswers4 = Questions(context: moc)
                newAnswers4.fromQuestionsToExamQuestion = targetExamQuestion
                newAnswers4.id = questionId
                newAnswers4.question = fourthAnswer
                


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

struct editQuestionWindow_Previews: PreviewProvider {
    static var previews: some View {
        editQuestionWindow()
    }
}
