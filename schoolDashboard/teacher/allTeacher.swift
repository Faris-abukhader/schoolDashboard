//
//  allTeacher.swift
//  schoolDashboard
//
//  Created by admin on 2021/2/25.
//

import SwiftUI
import CoreData


struct allTeacher: View {
    @FetchRequest(entity: Teacher.entity(), sortDescriptors: []) private var teacher:FetchedResults<Teacher>
    @EnvironmentObject var data:data
    @State var searchContent = ""
    @State var IsallStudentSelected = false
    @State var numSort = true
    @State var nameSort = false
    @State var genderSort = false
    @State var dateOfBirthSrot = false
    var body: some View {
        ZStack{
            if data.showTeacherDetail {
                teacherDetails(teacher:data.TeacherDetail)
            } else {
        VStack{
            ScrollView( showsIndicators: false){
                
                allTeacherheader(label: "All Teachers", searchlabel: "Search Teacher...", buttonLabel:"Add Teacher").frame(width: data.mainViewWidth-40)

            Path(CGPath(roundedRect: CGRect(x: 0, y: 0, width: data.mainViewWidth, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil))
                
                teacherTableHeader()
                    
                List{
                    ForEach(teacher.reversed().filter{
                        data.teacherSearchContent.isEmpty ? true : $0.name!.contains(data.teacherSearchContent)
                    }.sorted{
                        if data.teacherSortType == 1 {
                            return $0.name! < $1.name!
                        } else if data.teacherSortType == 2 {
                            return $0.gender < $1.gender
                        } else if data.teacherSortType == 3 {
                            return $0.major! < $1.major!
                        } else {
                            return true
                        }
                    },id:\.self){ t in
                        teacherTable(teacher: t)

                    }

                }.cornerRadius(15)
                .frame(width:data.mainViewWidth-40,height: data.height/1.2)
            
            
            
            
            
            
            }
            
            
            }
        }
            if data.showAddTeacherWindow{
                addTeacherWindow()

            }
            if data.showTeacherEdit {
                editTeacherWindow()
            }
            if data.showAddGradeToTeacher {
                AddGradeToTeacherWindow()
            }
            
        }

    }
}

struct allTeacher_Previews: PreviewProvider {
    static var previews: some View {
        allTeacher()
    }
}
struct teacherTable:View{
    @State var teacher = Teacher()
    @EnvironmentObject var data:data
    @State var IsallStudentSelected = false
    @State var deleteTeacher = false
    @Environment(\.managedObjectContext) var moc
    var body: some View{
        HStack(alignment: .firstTextBaseline){

            HStack{
            Button(action: {IsallStudentSelected.toggle()}, label: {
                Image(systemName: "square.fill")
                    .resizable()
                    .frame(width:data.show ? 10 : 15, height: data.show ? 10 : 15)
                    .foregroundColor(IsallStudentSelected ? .red : Color("lightGry"))
            })
            }.frame(width: data.mainViewWidth/7-70)

            HStack{
                Text("\(teacher.workId)")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/7-30)
            
            HStack{
                Text(teacher.name ?? " ")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/7-30)
            
            HStack{
                Text((teacher.gender == 1 ? "Male":"Female"))
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/7-30)

            HStack{
                Text(teacher.major ?? " ")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/7-30)

            HStack{
                Text("\(teacher.phoneNo)")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
                .onTapGesture {
                        data.showToast = true
                        data.toastContent = "teacher phoneNo was copied successfully"
                        
                }
            }.frame(width: data.mainViewWidth/7-30)
            
            
            HStack{
                Text(teacher.address ?? " ")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/7)
            
            
            
            HStack{
                Button(action: {}, label: {
                    Image(systemName: "eye")
                        .resizable()
                        .frame(width:data.show ? 6 : 10, height: data.show ? 6 : 10)
                        .foregroundColor(Color(.lightGray))
                        .onTapGesture {
                            data.showTeacherDetail = true
                            data.showTeacherEdit = false
                            data.TeacherDetail = teacher
                        }
                })
                
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width:data.show ? 6 : 10, height: data.show ? 6 : 10)
                        .foregroundColor(Color(.green))
                        .onTapGesture {
                            data.showTeacherEdit = true
                            data.TeacherDetail = teacher
                            toastContent(Content:String(teacher.phoneNo))
                        }

                    Image(systemName: "trash")
                        .resizable()
                        .frame(width:data.show ? 6 : 10, height: data.show ? 6 : 10)
                        .foregroundColor(Color(.red))
                        .onTapGesture {
                            deleteTeacher = true
                        }
                        .alert(isPresented: $deleteTeacher, content: {
                            Alert(title: Text("Confirm the delection"), message: Text("Are you sure you want to delete \(teacher.name!) teacher ?"), primaryButton: .destructive(Text("Delete")){
                                let f:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Teacher")
                                f.predicate = NSPredicate(format: "id = %@", teacher.id)
                                let fetchReturn = try? moc.fetch(f)
                                let fetchResult = fetchReturn as! [Teacher]
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

                

            }.frame(width: data.mainViewWidth/7-30)


        }
    }
}
struct teacherTableHeader:View{
    @State var IsallStudentSelected = false
    @State var numSort = true
    @State var nameSort = false
    @State var genderSort = false
    @State var gradeSort = false
    @State var majorSort = false
    @State var dateOfBirthSrot = false
    @EnvironmentObject var data:data
    var body: some View{
        HStack(alignment: .firstTextBaseline){
           
            HStack{
            Button(action: {IsallStudentSelected.toggle()}, label: {
                Image(systemName: "square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ? 6 : 10)
                    .foregroundColor(.red)
            })
            }.frame(width: data.mainViewWidth/7-70)
            .padding(.leading,-30)

            
            
            HStack{
            Text("WorkId")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/7-30)
            
            
            HStack{
            Button(action: {numSort.toggle()
                nameSort = false
                genderSort = false
                data.teacherSortType = 1
            }, label: {
                Text("Name")
                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ?  6 : 10)
                    .foregroundColor(numSort ? Color("yellow") : Color(.darkGray))
            })
            }.frame(width: data.mainViewWidth/7-30)

            
            


            
            

            HStack{
            Button(action: {nameSort.toggle()
                    numSort = false
                    genderSort = false
                data.teacherSortType = 2
            }, label: {
                Text("Gender")
                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ?  6 : 10)
                    .foregroundColor(nameSort ? Color("yellow") : Color(.darkGray))
                
            })
            }.frame(width: data.mainViewWidth/7-30)

            HStack{
            Button(action: {genderSort.toggle()
                data.teacherSortType = 3
                numSort = false
                nameSort = false
            }, label: {
                Text("Major")
                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ?  6 : 10)
                    .foregroundColor(genderSort ? Color("yellow") : Color(.darkGray))
            })
            }.frame(width: data.mainViewWidth/7-30)

            

            
            HStack{
            Text("PhoneNo")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/7-30)
            
            HStack{
            Text("Address")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/7-30)


            HStack{
            Text("Action")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/7-30)



        }.padding(.leading,-20)

        
    }
}
struct allTeacherheader:View{
    @State var searchContent=""
    @State var label:String
    @State var searchlabel:String
    @State var buttonLabel:String
    @EnvironmentObject var data:data
    @FetchRequest(entity: GradeSections.entity(), sortDescriptors: []) private var grades:FetchedResults<GradeSections>
    @State var showAlert = false
    var body: some View{
        HStack{
            Text(label)
                .bold()
                .font(.title3)
            Spacer()
            TextField(searchlabel, text: $data.teacherSearchContent)
                .font(.footnote)
                .frame(width: 120, height: 20)
                .padding(5)
                .background(Color("lightGry"))
                .cornerRadius(15)
            
            Button(action: {
                withAnimation(.spring()){
                    if label == "All Students" {
                        data.showAddStudentWindow.toggle()
                    }
                    if label == "All Teachers" {
                        data.showAddTeacherWindow.toggle()
                    }
                    if label == "School Grade" {
                        data.showAddGradeWindow.toggle()
                    }
                }
            }, label: {
                Text(buttonLabel)
                    .font(.custom("", size: 8))
                    .foregroundColor(.white)
                    .padding(5)
                    .padding(.horizontal,5)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
            }).alert(isPresented: $showAlert, content: {
                Alert(title: Text("Alert"), message: Text("Make sure pefore add any student that school already has at least one grade"), dismissButton: .default(Text("Close")))
            })
            Button(action: {data.showAddGradeToTeacher=true}, label: {
                Text("Add grade to teacher")
                    .font(.custom("", size: 8))
                    .foregroundColor(.white)
                    .padding(5)
                    .padding(.horizontal,5)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(.trailing)

            })

        }

    }
}
func toastContent(Content:String){
    let pasteboard = UIPasteboard.general
    pasteboard.string = Content
}
