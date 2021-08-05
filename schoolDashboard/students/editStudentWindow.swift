//
//  editStudentWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/5/3.
//

import SwiftUI
import CoreData

struct editStudentWindow: View {
    @State var stu = Student()
    @State var Fname = ""
    @State var classs = 0

    @State var isMale = false
    @State var isFemale = false
    @State var Religion = ""
    @State var birthYear = 0
    @State var birthMonth = 0
    @State var birthDay = 0
    @State var email = ""
    @State var selection = ""
    @State var phoneNo = ""
    @State var nationality = ""
    @State var id = ""
    @State var address = ""
    @State var addmissionDate = Date()
    @State var studentId = ""
    
    // parent info
    @State var fatherName = ""
    @State var fatherOccupation = ""
    @State var motherOccupation = ""
    @State var motherName = ""
    @State var fatherNationlity = ""
    @State var motherNationlity = ""
    @State var fatherPhone = ""
    @State var motherPhone = ""
    @State var fatherAddress = ""
    @State var motherAddress = ""
    
    // coredata
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var fetch:FetchedResults<Student>
    
    
    @State var g = ["First Grade Section A","Second Grade Section A","Third Grade Section A","Fourth Grade Section A","Fifth Grade Scetion A","Sixth Grade Section A","Seventh Grade Section A","Tenth Grade Section A","Ninth Grade Section A","Tenth Grade Section A","First Grade Section B","Second Grade Section B","Third Grade Section B","Fourth Grade Section B","Fifth Grade Scetion B","Sixth Grade Section B","Seventh Grade Section B","Tenth Grade Section B","Ninth Grade Section B","Tenth Grade Section B","First Grade Section C","Second Grade Section C","Third Grade Section C","Fourth Grade Section C","Fifth Grade Scetion C","Sixth Grade Section C","Seventh Grade Section C","Tenth Grade Section C","Ninth Grade Section C","Tenth Grade Section C"]
    
    @State var showAlert = false
    var body: some View {
        ZStack{
            
        
            VStack(alignment: .leading){
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    
                    VStack(alignment: .leading) {
                        
                    Text("first name :").foregroundColor(.white)
                        TextField("frist name...", text: Binding($data.studentEdit.name)!)
                        .font(.footnote)
                        .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                        .padding(10)
                        .background(Color("darkBlue"))
                        .cornerRadius(10)
                        .padding(.bottom)
                        .foregroundColor(.white)

                    Text("Gender :").foregroundColor(.white)
                    HStack(alignment:.firstTextBaseline){
                        Button(action: {
                            data.studentEdit.gender=1
                            isFemale = false
                            isMale = true

                        }, label: {
                            ZStack{
                            Image(systemName: "square.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(data.studentEdit.gender==1 ? .red:.white)
                                .cornerRadius(10)
                                if data.studentEdit.gender==1{
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(.white)
                                }
                            }
                            
                        })
                        Text("Male").foregroundColor(.white)
                        Button(action: {
                            data.studentEdit.gender=0
                            isFemale = true
                            isMale = false
                        }, label: {
                            ZStack{
                            Image(systemName: "square.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(data.studentEdit.gender==0 ? .red:.white)
                                .cornerRadius(10)
                                if data.studentEdit.gender==0{
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(.white)
                                }

                            }
                            
                        })
                        Text("Female").foregroundColor(.white)

                        
                    }.padding()
                    
                    Text("Religion :").foregroundColor(.white)
                    
                        TextField("Religion...", text: Binding($data.studentEdit.religion)!)
                        .font(.footnote)
                        .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                        .padding(10)
                        .background(Color("darkBlue"))
                        .cornerRadius(10)
                        .padding(.bottom)
                        .foregroundColor(.white)

                    Text("id :").foregroundColor(.white)
                    
                    TextField("id...", text: Binding($data.studentEdit.id)!)
                        .font(.footnote)
                        .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                        .padding(10)
                        .background(Color("darkBlue"))
                        .cornerRadius(10)
                        .padding(.bottom)
                        .foregroundColor(.white)

                }
                    VStack(alignment: .leading){
                        

                        
                        
                        Text("Date Of Birth :").foregroundColor(.white)
                        HStack{

                            Spacer()
                            VStack{
                                Text("Year:").foregroundColor(.white)
                                Picker("", selection: $data.studentEdit.birthYear){
                                ForEach(1900..<2021){ i in
                                    Text("\(String(i))").foregroundColor(.white)
                                }
                            }
                            .frame(width:data.mainViewWidth/7)
                            .clipped()
                            }
                            VStack{
                                Text("Month:").foregroundColor(.white)
                            Picker("", selection: $data.studentEdit.birthMonth){
                                ForEach(1..<13){ i in
                                    Text("\(String(i))").foregroundColor(.white)
                                }
                            }
                            .frame(width:data.mainViewWidth/7)
                            .clipped()
                            }
                            VStack{
                                Text("Day:").foregroundColor(.white)
                            Picker("", selection: $data.studentEdit.brithDay) {
                                ForEach(1..<32){ i in
                                    Text("\(String(i))").foregroundColor(.white)
                                }
                            }
                            .frame(width:data.mainViewWidth/7)
                            .clipped()
                            }
                            Spacer()
                        }

                        
                        
                        Text("E-mail :").foregroundColor(.white)
                        
                        TextField("E-mail...", text: Binding($data.studentEdit.email)!)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)

                        Text("Address :").foregroundColor(.white)
                        
                        TextField("Address...", text: Binding($data.studentEdit.adderss)!)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)

                    }
                    
                    VStack(alignment: .leading){
                        Text("Class :").foregroundColor(.white)
                        Picker("", selection: $data.studentEdit.garde, content: {
                            ForEach(0..<g.count){
                                Text(g[$0]).tag($0)
                                
                            }
                        })

                        
                        
                        
                        Text("Phone number :").foregroundColor(.white)
                        
                        TextField("Phone number...", text: $phoneNo)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)

                        Text("Nationality :").foregroundColor(.white)
                        
                        TextField("Nationality...", text: Binding($data.studentEdit.nationality)!)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)



                        
                    }

                    
                    Text("Parents Information").bold().font(.title2).padding(.top,40).padding(.bottom,40).foregroundColor(.white)
                        
                        
                    VStack(alignment: .leading){
                        Text("Father Name :").foregroundColor(.white)
                        
                        TextField("Father Name...", text: Binding($data.studentEdit.fatherName)!)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)

                        Text("Father Nationality :").foregroundColor(.white)
                        
                        TextField("Father Nationality...", text: Binding($data.studentEdit.fatherNationality)!)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)

                        Text("Father Phone :").foregroundColor(.white)
                        
                        TextField("Father Phone...", text: $fatherPhone)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)

                        Text("Father Address :").foregroundColor(.white)
                        
                        TextField("Father Address...", text: Binding($data.studentEdit.fatherAddress)!)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)
                        
                        
                        Text("Father Occupation :").foregroundColor(.white)
                        
                        TextField("Father Occupation...", text: Binding($data.studentEdit.fatherOccupation)!)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)

                    }
                    
                    
                    VStack(alignment: .leading){
                        Text("Mother Name :").foregroundColor(.white)
                        
                        TextField("Mother Name...", text: Binding($data.studentEdit.motherName)!)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)

                        Text("Mother Nationality :").foregroundColor(.white)
                        
                        TextField("Mother Nationality...", text: Binding($data.studentEdit.motherNationality)!)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)

                        Text("Mother Phone :").foregroundColor(.white)
                        
                        TextField("Mother Phone...", text: $motherPhone)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)

                        Text("Mother Address :").foregroundColor(.white)
                        
                        TextField("Mother Address...", text: Binding($data.studentEdit.motherAddress)!)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)
                        
                        
                        Text("Mother Occupation :").foregroundColor(.white)
                        
                        TextField("Mother Occupation...", text: Binding($data.studentEdit.motherOccupation)!)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)



                    }
                    
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            if data.studentEdit.name?.count == 0 || data.studentEdit.id?.count == 0 {
                                showAlert = true
                            }else{
                                
                                    let f:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Student")
                                    f.predicate = NSPredicate(format: "id = %@", data.studentEdit.id!)
                                do {
                                    let fetchReturn = try moc.fetch(f)
                                    let newStudent = fetchReturn[0] as! NSManagedObject
                                    newStudent.setValue(data.studentEdit.name!, forKey: "name" )
                                    newStudent.setValue(data.studentEdit.gender, forKey: "gender")
                                    newStudent.setValue(data.studentEdit.religion, forKey: "religion")
                                    newStudent.setValue(data.studentEdit.birthYear, forKey: "birthYear")
                                    newStudent.setValue(data.studentEdit.birthMonth, forKey: "birthMonth")
                                    newStudent.setValue(data.studentEdit.brithDay, forKey: "brithDay")
                                    newStudent.setValue(data.studentEdit.email, forKey: "email")
                                    newStudent.setValue(data.studentEdit.adderss, forKey: "adderss")
                                    newStudent.setValue(data.studentEdit.garde, forKey: "garde")
                                    newStudent.setValue(Int64(phoneNo) , forKey: "phoneNo")
                                    newStudent.setValue(data.studentEdit.nationality, forKey: "nationality")
                                    newStudent.setValue(data.studentEdit.fatherName, forKey: "fatherName")
                                    newStudent.setValue(data.studentEdit.fatherNationality, forKey: "fatherNationality")
                                    newStudent.setValue(Int64(fatherPhone), forKey: "fatherPhone")
                                    newStudent.setValue(data.studentEdit.fatherAddress, forKey: "fatherAddress")
                                    newStudent.setValue(data.studentEdit.motherName, forKey: "motherName")
                                    newStudent.setValue(data.studentEdit.motherNationality, forKey: "motherNationality")
                                    newStudent.setValue(Int64(motherPhone), forKey: "motherPhone")
                                    newStudent.setValue(data.studentEdit.motherAddress, forKey: "motherAddress")
                                    data.showStudentEdit = false

                                    do {
                                        try moc.save()
                                    }catch {
                                        print(error.localizedDescription)
                                    }
                                } catch {
                                    print(error.localizedDescription)
                                }
                                
                                
                                
                                Fname = ""
                                studentId = ""
                                id = ""
                                Religion = ""
                                nationality = ""
                                classs =  0
                                address = ""
                                phoneNo = ""
                                isMale = false
                                isFemale = false
                                motherName = ""
                                motherNationlity = ""
                                motherOccupation = ""
                                motherPhone = ""
                                motherAddress = ""
                                fatherName = ""
                                fatherOccupation = ""
                                fatherNationlity = ""
                                fatherPhone = ""
                                fatherAddress = ""
                                
                                
                            }
                        }, label: {
                            Text("Add")
                                .foregroundColor(Color.white)
                                .font(.footnote)
                                .padding(5)
                                .padding(.horizontal,30)
                                .background(Color("yellow"))
                                .cornerRadius(10)
                                .padding(.bottom)
                        })
                        .alert(isPresented: $showAlert, content: {
                            Alert(title: Text("Alert"), message: Text("Please to add a new student at least make sure that you filled Student Name , id , Garde"), dismissButton: .default(Text("Close")))
                        })
                        Button(action: {
                            data.showAddStudentWindow = false

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
                    }

                }

                
            }.padding()
            
            
        }.frame(width: data.mainViewWidth/1.7, height: data.mainViewHeight/1.7)
        .background(Color("lightBlue"))
        .cornerRadius(10)
        .shadow(radius: 2)
        Button(action: {
                data.showAddStudentWindow = false
                data.showStudentEdit = false
        }, label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color("darkBlue"))
        })
        .offset(x: data.mainViewWidth/3, y: -data.mainViewHeight/3)

    }
    
}

struct editStudentWindow_Previews: PreviewProvider {
    static var previews: some View {
        editStudentWindow()
    }
}
