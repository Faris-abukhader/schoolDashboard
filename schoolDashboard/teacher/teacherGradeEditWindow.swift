//
//  teacherGradeEditWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/13.
//

import SwiftUI
import CoreData

struct teacherGradeEditWindow: View {
    @State var teacherName = ""
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        ZStack{
            
            VStack{
                ScrollView{
                    ForEach(allTeacherGrades(),id:\.self){ grade in
                        showTeacherGrades(grade: grade,teacherName: teacherName)
                    }
                }.padding(.top)
            }
            
            
            
        }.frame(width: data.mainViewWidth/1.7, height: data.mainViewHeight/1.7)
        .background(Color("lightBlue"))
        .cornerRadius(10)
        .shadow(radius: 2)
        Button(action: {
                data.showTeacherGradeEditWindow = false
                data.TeacherChosedForAddingGrade = ""
        }, label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color("darkBlue"))
        })
        .offset(x: data.mainViewWidth/3, y: -data.mainViewHeight/3)

    }
    
    func allTeacherGrades()->[String]{
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Teacher")
        fetch.predicate = NSPredicate.init(format: "name = %@", teacherName)
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

struct teacherGradeEditWindow_Previews: PreviewProvider {
    static var previews: some View {
        teacherGradeEditWindow()
    }
}
struct showTeacherGrades:View{
    @State var grade = ""
    @State var teacherName = ""
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    var body: some View{
        HStack{
            Text("\(grade)")
                .font(.caption)
                .padding(.leading)
            Spacer()
            
            Button(action: {deleteThisGrade(grade: grade)}, label: {
                Image(systemName: "xmark.circle.fill")
                    .padding(.trailing)
                    .foregroundColor(Color.red)
            })
        
        }
        .padding(.vertical)
        .frame(width: data.mainViewWidth/1.7-20)
        .background(Color(.lightGray))
        .cornerRadius(5)
    }
    
    func deleteThisGrade(grade:String){
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Teacher")
        fetch.predicate = NSPredicate.init(format: "name = %@", teacherName)
        var result = Array<String>()
        do {
            let fetchResult = try moc.fetch(fetch)
            let teacher = fetchResult[0] as! Teacher
            let teacherGrades = teacher.teacherGrades
            for grade in teacherGrades {
                result.append(grade.grade!)
            }
            for grad in teacherGrades {
                if grad.grade == grade{
                    moc.delete(grad)
                    break
                }
            }
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
