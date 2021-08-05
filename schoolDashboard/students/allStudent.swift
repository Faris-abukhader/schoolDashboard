//
//  allStudent.swift
//  schoolDashboard
//
//  Created by admin on 2021/2/24.
//

import SwiftUI
import CoreData

struct allStudent: View {
    @EnvironmentObject var data:data
    @State var searchContent = ""
    @State var IsallStudentSelected = false
    @State var numSort = true
    @State var nameSort = false
    @State var genderSort = false
    @State var gradeSort = false
    @State var selectionSort = false
    @State var dateOfBirthSrot = false

    @FetchRequest(entity: Student.entity(), sortDescriptors: []) private var student:FetchedResults<Student>
    var body: some View {
        
        ZStack{
            if data.showStudentDetail {
                studentDetails(student: data.studentDetail)
            } else {
        VStack{
            ScrollView( showsIndicators: false){
                allStudentheader(label: "All Students", searchlabel: "Search Student...", buttonLabel: "Add Student").frame(width:data.mainViewWidth-40)
            Path(CGPath(roundedRect: CGRect(x: 0, y: 0, width: data.mainViewWidth, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil))
                tableHeader(field:"student")
                List{
                    ForEach(student.filter{
                        data.studentSearchContent.isEmpty ? true : $0.name!.contains(data.studentSearchContent)
                    }
                    .sorted{
                        if data.studentSortType == 1 {
                            return $0.name! < $1.name!
                        } else
                        if data.studentSortType == 2{
                           return  $0.gender < $1.gender
                        }else if data.studentSortType == 3 {
                            return $0.garde! < $1.garde!
                        } else {
                            return true
                        }
                    }
                    .reversed()){ std in
                        studentTable(student: std,isAdmin:true)
                    }
                }.cornerRadius(15)
                .onTapGesture {
                    
                }
                .frame(width:data.mainViewWidth-40,height: data.height/1.2)
            }
        }
        }
            if data.showAddStudentWindow {
                addStudentWindow()
            }
            if data.showStudentEdit {
                editStudentWindow()

            }
    }

    }
}

struct allStudent_Previews: PreviewProvider {
    static var previews: some View {
        allStudent()
    }
}
struct studentTable:View{
    @State var student:Student
    @State var isAdmin:Bool
    @State var IsallStudentSelected = false
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) private var moc
    @State var deleteStudent = false
    var body: some View{
        HStack(alignment: .center){
            HStack{
            Button(action: {IsallStudentSelected.toggle()}, label: {
                Image(systemName: "square.fill")
                    .resizable()
                    .frame(width:data.show ? 10 : 15, height: data.show ? 10 : 15)
                    .foregroundColor(IsallStudentSelected ? .red : Color("lightGry"))
            })
            }.frame(width: data.mainViewWidth/9-60)
            
            HStack{
                Text(String(student.studentId))
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/9-20)
            
            
            HStack{
                Text(student.name ?? " ")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/9)
            
            HStack{
                Text(student.gender == Int16(1) ? "Male":"Female")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/9-20)

            
            HStack{
                Text(student.fatherName ?? "")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/9)

            
            HStack{
                Text(student.garde ?? "")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/9-20)

            
            HStack{
                Text(student.adderss ?? "")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/9-20)

            
            HStack{
                Text(String(student.phoneNo) ?? "")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
                    .onTapGesture {
                        data.showToast = true
                        data.toastContent = "student phoneNo was copied successfully"
                        toastContent(Content:String(student.phoneNo))
                    }
            }.frame(width: data.mainViewWidth/9-20)

            
            
            
            HStack{
                    Image(systemName: "eye")
                        .resizable()
                        .frame(width:data.show ? 6 : 10, height: data.show ? 6 : 10)
                        .foregroundColor(Color(.lightGray))
                        .onTapGesture {
                            data.showStudentDetail = true
                            data.studentDetail = student
                            data.showStudentInfoForTeacher = true
                       }
                
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width:data.show ? 6 : 10, height: data.show ? 6 : 10)
                        .foregroundColor(Color(.green))
                        .onTapGesture {
                            data.studentDetail = student
                            data.showStudentEdit = true
                            data.studentEdit = student
                       }
                

                if isAdmin {
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width:data.show ? 6 : 10, height: data.show ? 6 : 10)
                        .foregroundColor(Color(.red))
                        .onTapGesture {
                            deleteStudent = true

                        }
                        .alert(isPresented: $deleteStudent, content: {
                            Alert(title: Text("Confirm the delection"), message: Text("Are you sure you want to delete \(student.name!) student ?"), primaryButton: .destructive(Text("Delete")){
                                let f:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Student")
                                f.predicate = NSPredicate(format: "id = %@", student.id!)
                                let fetchReturn = try? moc.fetch(f)
                                let fetchResult = fetchReturn as! [Student]
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

                 }

            }.frame(width: data.mainViewWidth/9-20)


        }
    }
}

struct header:View{
    @State var searchContent=""
    @State var label:String
    @State var searchlabel:String
    @EnvironmentObject var data:data
    var body: some View{
        HStack{
            Text(label)
                .bold()
                .font(.title3)
            Spacer()
            TextField(searchlabel, text: $searchContent)
                .font(.footnote)
                .frame(width: 120, height: 20)
                .padding(5)
                .background(Color("lightGry"))
                .cornerRadius(15)
            
            Button(action: {
                if label ==  "All Teacher" {
                    data.showAddTeacherWindow.toggle()
                }
                
            }, label: {
                Text("Search")
                    .font(.custom("", size: 8))
                    .padding(5)
                    .padding(.horizontal,5)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(.trailing)
            })
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image("reload")
                    .resizable()
                    .frame(width: 15, height: 15)
            })
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.red)
            })
        }

    }
}
struct tableHeader:View{
    @State var field = ""
    @State var IsallStudentSelected = false
    @State var numSort = true
    @State var nameSort = true
    @State var genderSort = false
    @State var gradeSort = false
    @State var selectionSort = false
    @State var dateOfBirthSrot = false
    @EnvironmentObject var data:data
    var body: some View{
        HStack(alignment: .center){

            HStack{
            Button(action: {IsallStudentSelected.toggle()}, label: {
                Image(systemName: "square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ? 6 : 10)
                    .foregroundColor(.red)
            })
            }.frame(width: data.mainViewWidth/9-60)
            
            
            HStack{
            Text("StudentId")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/9-20)

            
            HStack{
            Button(action: {
                nameSort = true
                genderSort = false
                gradeSort = false
                data.studentSortType = 1
            }, label: {
                Text("Name")
                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ?  6 : 10)
                    .foregroundColor(nameSort ? Color("yellow") : Color(.darkGray))
                
            })
            }.frame(width: data.mainViewWidth/9)
            
            
            HStack{
            Button(action: {
                nameSort = false
                genderSort = true
                gradeSort = false
                data.studentSortType = 2
            }, label: {
                Text("Gender")
                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ?  6 : 10)
                    .foregroundColor(genderSort ? Color("yellow") : Color(.darkGray))
            })
            }.frame(width: data.mainViewWidth/9-20)
            
            
            HStack{
            Text("Parents Name")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/9)
            
            
            HStack{
            Button(action: {
                nameSort = false
                genderSort = false
                gradeSort = true
                data.studentSortType = 3
            }, label: {
                Text("Grade")
                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ?  6 : 10)
                    .foregroundColor(gradeSort ? Color("yellow") : Color(.darkGray))
            })
            }.frame(width: data.mainViewWidth/9-20)
            
            
            
            
            
            HStack{
            Text("Address")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/9-20)
            
            
            
            HStack{
            Text("Phone No")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/9-20)

            
            
            
            HStack{
            Text("Action")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/9-20)
            


        }.padding(.leading,-35)

    }
}
struct allStudentheader:View{
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
            TextField(searchlabel, text: $data.studentSearchContent)
                .font(.footnote)
                .frame(width: 120, height: 20)
                .padding(5)
                .background(Color("lightGry"))
                .cornerRadius(15)
            
            Button(action: {
                if grades.count < 1 {
                    showAlert = true
                }else {
                withAnimation(.spring()){
                            data.showAddStudentWindow.toggle()
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
                    .padding(.trailing)
            })
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Warning"),message: Text("Your school doesn't has any class and one before you add any student."), primaryButton: Alert.Button.destructive(Text("Ok"), action: {
                    data.pageIndex = 10
                    data.showAddGradeWindow = true
                }), secondaryButton: Alert.Button.cancel())
            })
        }

    }
}
