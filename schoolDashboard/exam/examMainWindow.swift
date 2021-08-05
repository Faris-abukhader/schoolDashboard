//
//  examMainWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/7/30.
//

import SwiftUI
import CoreData

struct examMainWindow: View {
    @EnvironmentObject var data:data
    @FetchRequest(entity: Exam.entity(), sortDescriptors: []) var exams:FetchedResults<Exam>
    var body: some View {
        ZStack{
             if data.showPreviewPage {
                examPreivewWindow()
            } else if data.showStudentAnswerForTeacher {
                studentAnswerPreivew()
            } else {
            VStack{
                ScrollView(showsIndicators: false){
                        
                            if exams.count == 0 {
                                nullDataImage().padding(.top,40)
                            }else {
                                examListViewAdmin()
                                
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

struct examMainWindow_Previews: PreviewProvider {
    static var previews: some View {
        examMainWindow()
    }
}
struct examListViewAdmin:View{
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
            List{
                ForEach(exams.reversed()){exam in
                    
                    examListItemView(examName:exam.examName!, gradeName:exam.gradeName!,examId:exam.id)

                    
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
        .frame(height: data.mainViewHeight/2 + 80)

        
    }
    
    
}
