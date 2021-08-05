//
//  studentExamWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/29.
//

import SwiftUI
import CoreData

struct studentExamWindow: View {
    @EnvironmentObject var data:data
    var body: some View {
        ZStack{
            if data.showStudentExamPreview {
                studentExamPreview()
            }else {
            VStack{
                ScrollView(showsIndicators: false){
                    examList()
                }
              }
            }
        }
    }
}

struct studentExamWindow_Previews: PreviewProvider {
    static var previews: some View {
        studentExamWindow()
    }
}
struct examList:View{
    @EnvironmentObject var data:data
    @FetchRequest(entity: Exam.entity(), sortDescriptors: []) var exams:FetchedResults<Exam>
    @Environment(\.managedObjectContext) var moc
    @State var currentDate = Date()
    var body: some View{
        VStack{
            HStack{
                Text("Exam Page")
                    .bold()
                    .font(.title)
                    .padding()
                    .foregroundColor(.black)
                    Spacer()
            }
            if examCounter() == 0 {
                Image("noAvailableData")
                    .resizable()
                    .frame(width:data.mainViewWidth/2,height:data.mainViewWidth/2)
            }else{
            List{
                ForEach(exams.filter{
                    getTheGrade().isEmpty ? true : $0.gradeName!.contains(getTheGrade())
                }){exam in
                    HStack{
                        VStack(alignment: .leading){
                            Text(exam.examName!)
                                .font(.caption)
                                .foregroundColor(.black)
                                .padding(.leading)
                            Text("teacher : \(exam.teacherName!)")
                                .foregroundColor(Color(.lightGray))
                                .font(.caption2)
                                .padding(.leading)
                        }
                        Spacer()
                        Text(exam.examEndTime ?? Date() > currentDate ? "processing":"finished")
                            .font(.footnote)
                            .foregroundColor(Color.white)
                            .padding(.vertical,5)
                            .padding(.horizontal,10)
                            .background(exam.examEndTime ?? Date() > currentDate ? Color.green:Color.red)
                            .cornerRadius(5)
                    }.onTapGesture {
                        data.studentExamPreviewID = exam.id
                        data.showStudentExamPreview = true
                    }
                    
                }
            }
            .frame(width: data.mainViewWidth - 40,height: data.mainViewWidth)
            .background(Color.white)
            .cornerRadius(10)
          }
        }
    }
    func getTheGrade() -> String {
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Student")
        fetch.predicate = NSPredicate.init(format: "name = %@", data.username)
        var result = ""
            do{
                if try moc.fetch(fetch).count > 0 {
            let fetchResult = try moc.fetch(fetch)
            let student = fetchResult[0] as! Student
                result = student.garde!
             }
            }catch{
                print(error.localizedDescription)
            }
        return result
        }
    
    func examCounter()->Int{
        var counter = 0
        if exams.count == 0 {
            return 0
        }else {
            for exam in exams {
                if exam.gradeName! == getTheGrade() {
                    counter+=1
                }
            }
            return counter
        }
    }
}

