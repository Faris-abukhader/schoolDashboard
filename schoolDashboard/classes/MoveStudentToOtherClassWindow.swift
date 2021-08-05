//
//  MoveStudentToOtherClassWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/10.
//

import SwiftUI
import CoreData

struct MoveStudentToOtherClassWindow: View {
    @EnvironmentObject var data:data
    @FetchRequest(entity: GradeSections.entity(), sortDescriptors: []) private var grades:FetchedResults<GradeSections>
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                
                Text("Student Name : \(data.studentNameMoveToNewGrade)")
                    .bold()
                    .padding(.leading)
                    .foregroundColor(.white)
                    .padding(.bottom,10)
                
                Text("Current Grade : \(data.currentGrade)")
                    .bold()
                    .padding(.leading)
                    .foregroundColor(.white)
                    .padding(.bottom,10)
                
                Text("Move to : \(data.newGrade)")
                    .bold()
                    .padding(.leading)
                    .foregroundColor(.white)
                    .padding(.bottom,10)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(grades.filter{
                            data.currentGrade.isEmpty ? true : $0.grade!.contains(giveTheFirstWordOfString(SearchingForSpace: data.currentGrade))
                        }.filter{
                            data.currentGrade.isEmpty ? true : !$0.grade!.contains(data.currentGrade)
                        }){grade in
                        availableGradeToMoveIn(grade: grade.grade!)
                    }
                    
                 }
                }.padding(.horizontal,10)

                
                
                

                Spacer()

        HStack{
            Spacer()
                Button(action: {
                let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Student")
                    fetch.predicate = NSPredicate.init(format: "name = %@", data.studentNameMoveToNewGrade)
                    do{
                        let returnFromFetching = try moc.fetch(fetch)
                        let studentWithNewGrade = returnFromFetching[0] as! NSManagedObject
                        studentWithNewGrade.setValue(data.newGrade, forKey: "garde")
                        do {
                            try moc.save()
                        }catch{
                            print(error.localizedDescription)
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                        
                        data.newGrade = ""
                        data.showMoveToNewGradeWindow = false
                    }, label: {
                        Text("comfirm")
                            .foregroundColor(Color.white)
                            .font(.footnote)
                            .padding(5)
                            .padding(.horizontal,30)
                            .background(Color("yellow"))
                            .cornerRadius(10)
                            .padding(.bottom)
                    })
                    

                    Spacer()
                    Button(action: {
                        data.showMoveToNewGradeWindow=false
                        data.newGrade = ""
                    }, label: {
                        Text("cancel")
                            .foregroundColor(Color.white)
                            .font(.footnote)
                            .padding(5)
                            .padding(.horizontal,30)
                            .background(Color("yellow"))
                            .cornerRadius(10)
                            .padding(.bottom)

                    })
                    Spacer()

                }.padding(.bottom)
                

            }
            
        }.padding().frame(width: data.mainViewWidth/1.5, height: data.mainViewHeight/3.5)
        .background(Color("lightBlue"))
        .cornerRadius(10)
        .shadow(radius: 2)
        Button(action: {
                data.showMoveToNewGradeWindow = false
                data.newGrade = ""
        }, label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color("darkBlue"))
        })
        .offset(x: data.mainViewWidth/2.5, y: -data.mainViewHeight/5.5)

    }
}

struct MoveStudentToOtherClassWindow_Previews: PreviewProvider {
    static var previews: some View {
        MoveStudentToOtherClassWindow()
    }
}

struct availableGradeToMoveIn:View{
    @State var grade = ""
    @EnvironmentObject var data:data
    var body: some View{
            HStack{
                Button(action: {data.newGrade = grade}, label: {
                    ZStack{
                        Rectangle()
                            .frame(width: data.mainViewWidth/8, height: data.mainViewWidth/10)
                            .cornerRadius(15)
                            .foregroundColor(Color("yellow"))
                        Rectangle()
                            .frame(width: data.mainViewWidth/8-5, height: data.mainViewWidth/10-5)
                            .cornerRadius(15)
                            .foregroundColor(Color("darkBlue"))
                        
                        
                        Text("\(grade)")
                            .frame(width: data.mainViewWidth/8-10)
                            .lineLimit(5)
                            .foregroundColor(.white)
                            .font(.caption2)
                    }
                })
        }
            
    }
}
