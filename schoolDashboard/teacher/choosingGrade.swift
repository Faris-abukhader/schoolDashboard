//
//  choosingGrade.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/13.
//

import SwiftUI
import CoreData

struct choosingGrade: View {
    @EnvironmentObject var data:data
    @FetchRequest(entity: GradeSections.entity(), sortDescriptors: []) private var grades:FetchedResults<GradeSections>
    @FetchRequest(entity: Teacher.entity(), sortDescriptors: []) private var teachers:FetchedResults<Teacher>
    @Environment(\.managedObjectContext) var moc
    @State var isChecked = false
    @State var comfirmed = false
    var body: some View {
        VStack{
            HStack{
                Button(action: {data.showChoosingGrade=false}, label: {
                    Text("Back")
                        .foregroundColor(Color("yellow"))
                        .padding(.leading)
                        .padding(.top,10)
                })
                Spacer()
                Button(action: {data.showChoosingGrade=false
                }, label: {
                    Text("Done")
                        .foregroundColor(Color("yellow"))
                        .padding(.trailing)
                        .padding(.top,10)
                })
            }
            
            ScrollView{
                ForEach(allAvailableGrade(),id:\.self){ item in
                    
                    chooseGradeItem(grade: item)
                    
                }
            }
        
       }
        .frame(width: data.mainViewWidth/1.7, height: data.mainViewHeight/1.7)
        .background(Color("lightBlue"))
        .cornerRadius(10)
        .shadow(radius: 2)
        
        
        

    }
    func allAvailableGrade()->[String]{
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Teacher")
        fetch.predicate = NSPredicate.init(format: "name = %@", data.TeacherChosedForAddingGrade)
        var teacherGrades = Array<String>()
        var availableGrade = Array<String>()
        do {
            if try moc.fetch(fetch).count > 0{
            let returnFromFetch = try moc.fetch(fetch)
            let theteacher = returnFromFetch[0] as! Teacher
            for grade in grades {
                availableGrade.append(grade.grade!)
            }
            for item in theteacher.teacherGrades  {
                teacherGrades.append(item.grade!)
            }
          }
        }catch{
            print(error.localizedDescription)
        }
        for Inavailable in teacherGrades {
            for available in availableGrade {
                if Inavailable == available {
                    if availableGrade.firstIndex(of: Inavailable) != nil {
                        availableGrade.remove(at: availableGrade.firstIndex{$0 == available}!)
                }
              }
            }
        }
        return availableGrade
        
    }


}
struct choosingGrade_Previews: PreviewProvider {
    static var previews: some View {
        choosingGrade()
    }
}
struct chooseGradeItem:View{
    @State var grade = ""
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    @State var isChecked = false
    @State var comfirmed = false
    var body: some View{
        HStack{
            Text(grade)
                .padding(.leading)
                .foregroundColor(Color.black)
                .font(.caption)
            Spacer()
            
            Button(action: {
                if !comfirmed{
                    isChecked.toggle()
                }
                
            }, label: {

                Image(systemName: "checkmark.square.fill")
                    .resizable()
                    .frame(width:data.show ? 10 : 15, height: data.show ? 10 : 15)
                    .foregroundColor(isChecked ? .red:.gray)
                    .padding(.trailing)
               })
            if isChecked {
                Button(action: {
                    comfirmed = true
                    let s:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Teacher")
                    s.predicate = NSPredicate(format: "name = %@", data.TeacherChosedForAddingGrade)
                    do {
                        if try moc.fetch(s).count > 0 {
                    let fetchReturn = try moc.fetch(s)
                    let selectedTeacher = fetchReturn[0] as! Teacher
                    let teacher = GradeForTeaceher(context: moc)
                        teacher.gradeToTeacher = selectedTeacher
                        teacher.grade = grade
                        
                        do {
                            try moc.save()
                        }catch{
                            print(error.localizedDescription)
                        }
                     }
                    }catch{
                        print(error.localizedDescription)
                    }

                    
                }, label: {
                    Text("comfirm")
                        .font(.caption2)
                        .foregroundColor(comfirmed ?.green:.blue)
                })
                .disabled(comfirmed)
            }
        }
        .frame(width: data.mainViewWidth/1.7-20)
        .padding(.vertical)
//        .background(Color.white)
        .background(LinearGradient(gradient: Gradient(colors: [.white,Color(.lightGray),.white,Color(.lightGray),.white,Color(.lightGray)]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(5)

    }
}
