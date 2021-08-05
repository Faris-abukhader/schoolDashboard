//
//  allClasses.swift
//  schoolDashboard
//
//  Created by admin on 2021/3/2.
//

import SwiftUI
import CoreData

struct allClasses: View {
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: GradeSections.entity(), sortDescriptors: []) private var g:FetchedResults<GradeSections>
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) private var students:FetchedResults<Student>
    @State var showGradeStudent:String = ""
    @State var showGradeSection:String = ""
    @State var justfortest = "Second"
    var body: some View {
        ZStack{
        VStack{
            ScrollView( showsIndicators: false){
                allClassesHeader().frame(width:data.mainViewWidth-40)

            Path(CGPath(roundedRect: CGRect(x: 0, y: 0, width: data.mainViewWidth, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil))
                
                
                classesTableHeader()

                
                List{
                    ForEach(g.reversed().filter{
                        data.gradesSearchContent.isEmpty ? true:$0.grade!.contains(data.gradesSearchContent)
                    }){ gr in
    classTable(grade:gr.grade ?? "", roomNo: String(gr.roomNo),studentNum:getGradeStudentRecord(grade: gr.grade ?? "") )

                    }

                }
                .frame(width:data.mainViewWidth-40,height: data.height/3)
                .cornerRadius(15)
                
                
                ScrollView(.horizontal, showsIndicators: true){
                    HStack{

                    ForEach(g){grade in
                        Button(action: {
                            data.showGradeStudent = grade.grade ?? ""
                            showGradeSection = giveTheSectionOfGrade(SearchingForSection: grade.grade ?? "empty")
                        }, label: {
                            ZStack{
                                Rectangle()
                                    .frame(width: data.mainViewWidth/6, height: data.mainViewWidth/8)
                                    .cornerRadius(15)
                                    .foregroundColor(Color("yellow"))
                                Rectangle()
                                    .frame(width: data.mainViewWidth/6-5, height: data.mainViewWidth/8-5)
                                    .cornerRadius(15)
                                    .foregroundColor(Color("darkBlue"))


                                Text("\(grade.grade ?? "")")
                                    .frame(width: data.mainViewWidth/6-30)
                                    .lineLimit(5)
                                    .foregroundColor(.white)
                                    .font(.caption)


                            }

                        })
                    }



                 }
                }
                List{
                    ForEach(students.filter{
                        showGradeStudent.isEmpty ? true : $0.garde == data.showGradeStudent
                    }){ std in
                        sortedGrade(student: std)
                    }

                }.frame(width:data.mainViewWidth-40,height: data.height/2)
                .cornerRadius(15)

            
            
            
            
            
            
            
            
            }
            
            }

            if data.showEditGradeWindow {
                editGradeWindow(grade:data.className, roomNo:String(data.roomNo))
            }
            
            if data.showAddGradeWindow {

                addNewGradeWindow()
            }
            if data.showMoveToNewGradeWindow {
                MoveStudentToOtherClassWindow()
            }

        }
        .onAppear{
                showGradeStudent = firstGradeName()
        }



    }
    
    func getGradeStudentRecord(grade:String)->Int{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        fetchRequest.predicate = NSPredicate.init(format: "garde = %@", grade)
        var count:Int=0
        do {
            count = try moc.count(for: fetchRequest)
        }catch{
            print(error.localizedDescription)
        }
        return count
    }

    func firstGradeName()->String{
        if g.count > 0 {
            return g[0].grade!
        } else {
            return "empty"
        }
        
    }
}

struct allClasses_Previews: PreviewProvider {
    static var previews: some View {
        allClasses()
    }
}
struct classesTableHeader:View{
    @State var IsallStudentSelected = false
    @EnvironmentObject var data:data
    var body: some View{
        HStack{

            VStack{
            Text("Grade")
                .font(.custom("", size:data.show  ? 8:10))
            }.frame(width: data.mainViewWidth/4-20)


            VStack{
            Text("Room")
                .font(.custom("", size:data.show  ? 8:10))
            }.frame(width: data.mainViewWidth/4-20)

            VStack{
            Text("Student Number")
                .font(.custom("", size:data.show  ? 8:10))
            }.frame(width: data.mainViewWidth/4-20)

            VStack{
            Text("Action")
                .font(.custom("", size:data.show  ? 8:10))
            }.frame(width: data.mainViewWidth/4-20)

            

            

            
               




        }

    }
}
struct classTable:View{
    @State var grade = ""
    @State var section = ""
    @State var roomNo = ""
    @State var studentNum = 0
    @State var IsallStudentSelected = false
    @State var isPaid = false
    @EnvironmentObject var data:data
    @State var deleteGrade = false
    @Environment(\.managedObjectContext) var moc
    var body: some View{
        HStack{
            

            VStack{
            Text("\(grade)")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/4-20)
            
            

            
            VStack{
            Text("room no \(roomNo)")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/4-20)
            
            
            VStack{
            Text("\(studentNum)")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/4-20)
            
            
            HStack{
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width:data.show ? 6 : 10, height: data.show ? 6 : 10)
                        .foregroundColor(Color(.green))
                        .onTapGesture {
                            data.showEditGradeWindow.toggle()
                            data.roomNo = Int(roomNo) ?? 0
                            data.className = grade
                        }
                
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width:data.show ? 6 : 10, height: data.show ? 6 : 10)
                        .foregroundColor(Color(.red))
                        .onTapGesture {
                            deleteGrade.toggle()
                        }
                        .alert(isPresented: $deleteGrade, content: {
                            Alert(title: Text("Confirm the delection"), message: Text("Are you sure you want to delete \(grade) ?"), primaryButton: .destructive(Text("Delete")){
                                let f:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "GradeSections")
                                f.predicate = NSPredicate(format: "roomNo = %@",roomNo)
                                let fetchReturn = try? moc.fetch(f)
                                let fetchResult = fetchReturn as! [GradeSections]
                                for object in fetchResult {
                                    moc.delete(object)
                                }
                                do {
                                    try moc.save()
                                }catch{
                                    print(error.localizedDescription)
                                }
                            }, secondaryButton: .cancel())
                        })

                
            }.frame(width: data.mainViewWidth/5-20)

            

        }

    }

}
func giveTheFirstWordOfString(SearchingForSpace:String)->String{
    let index = SearchingForSpace.firstIndex(of: " ") ?? SearchingForSpace.endIndex
    let theResutltOfSearching = String(SearchingForSpace[..<index])
    return theResutltOfSearching
}
func giveTheSectionOfGrade(SearchingForSection:String)->String{
    let index = SearchingForSection.lastIndex(of: " ") ?? SearchingForSection.endIndex
    let theResutltOfSearching = SearchingForSection.substring(from: index)
    return theResutltOfSearching
}
struct sortedGrade:View{
    @State var student = Student()
    @EnvironmentObject var data:data
    var body: some View{
        HStack{
            VStack(alignment: .leading){
                Text("\(student.name!)")
                    .font(.caption)
                
            }.frame(width: data.mainViewWidth/3)

            VStack(alignment: .leading){
                Text("\(student.garde!)")
                    .font(.caption)

            }.frame(width: data.mainViewWidth/3)

            VStack(alignment: .leading){
                HStack{
                Image(systemName: "arrow.up.and.down.and.arrow.left.and.right")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ? 6 : 10)
                    .foregroundColor(Color(.green))

                Text("Move to").foregroundColor(Color.green).font(.caption2)
                }.padding(.trailing,5)
                .onTapGesture {
                    data.showMoveToNewGradeWindow = true
                    data.currentGrade = student.garde!
                    data.studentNameMoveToNewGrade = student.name!
                    
                }

            }.frame(width: data.mainViewWidth/3)


            
            
        }.frame(width: data.mainViewWidth-40)
    }
}
struct allClassesHeader:View{
    @EnvironmentObject var data:data
    @FetchRequest(entity: GradeSections.entity(), sortDescriptors: []) private var grades:FetchedResults<GradeSections>
    @State var showAlert = false
    var body: some View{
        HStack{
            Text("School Grades")
                .bold()
                .font(.title3)
            Spacer()
            TextField("Search grade...", text: $data.gradesSearchContent)
                .font(.footnote)
                .frame(width: 120, height: 20)
                .padding(5)
                .background(Color("lightGry"))
                .cornerRadius(15)
            
            Button(action: {
                withAnimation(.spring()){
                        data.showAddGradeWindow.toggle()
                    }
                
            }, label: {
                Text("Add Grade")
                    .font(.custom("", size: 8))
                    .foregroundColor(.white)
                    .padding(5)
                    .padding(.horizontal,5)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
            }).alert(isPresented: $showAlert, content: {
                Alert(title: Text("Alert"), message: Text("Make sure pefore add any student that school already has at least one grade"), dismissButton: .default(Text("Close")))
            })
        }

    }
}
