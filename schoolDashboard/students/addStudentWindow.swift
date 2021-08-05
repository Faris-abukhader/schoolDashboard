//
//  addStudentWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/3/3.
//

import SwiftUI

struct addStudentWindow: View {

    // student info
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
    
    //
    @State var showAlert = false
    
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: GradeSections.entity(), sortDescriptors: []) private var grades:FetchedResults<GradeSections>

    
    @State var g = ["First Grade Section A","Second Grade Section A","Third Grade Section A","Fourth Grade Section A","Fifth Grade Scetion A","Sixth Grade Section A","Seventh Grade Section A","Tenth Grade Section A","Ninth Grade Section A","Tenth Grade Section A","First Grade Section B","Second Grade Section B","Third Grade Section B","Fourth Grade Section B","Fifth Grade Scetion B","Sixth Grade Section B","Seventh Grade Section B","Tenth Grade Section B","Ninth Grade Section B","Tenth Grade Section B","First Grade Section C","Second Grade Section C","Third Grade Section C","Fourth Grade Section C","Fifth Grade Scetion C","Sixth Grade Section C","Seventh Grade Section C","Tenth Grade Section C","Ninth Grade Section C","Tenth Grade Section C"]
    
    var dataformat:DateFormatter{
    let format = DateFormatter()
        format.dateStyle = .medium
        format.timeStyle = .medium
        return format
    }

    var body: some View {
        ZStack{
            
        
            VStack(alignment: .leading){
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    
                    VStack(alignment: .leading) {
                        
                    Text("first name :").foregroundColor(.white)
                    TextField("frist name...", text: $Fname)
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
                            isFemale = false
                            isMale = true

                        }, label: {
                            ZStack{
                            Image(systemName: "square.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(isMale ? .red:.white)
                                .cornerRadius(10)
                                if isMale{
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(.white)
                                }
                            }
                            
                        })
                        Text("Male").foregroundColor(.white)
                        Button(action: {
                            isFemale = true
                            isMale = false
                        }, label: {
                            ZStack{
                            Image(systemName: "square.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(isFemale ? .red:.white)
                                .cornerRadius(10)
                                if isFemale{
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
                    
                    TextField("Religion...", text: $Religion)
                        .font(.footnote)
                        .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                        .padding(10)
                        .background(Color("darkBlue"))
                        .cornerRadius(10)
                        .padding(.bottom)
                        .foregroundColor(.white)

                    Text("id :").foregroundColor(.white)
                    
                    TextField("id...", text: $id)
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
                            Picker("", selection: $birthYear){
                                ForEach(1900..<2021){ i in
                                    Text("\(String(i))").foregroundColor(.white)
                                }
                            }
                            .frame(width:data.mainViewWidth/7)
                            .clipped()
                            }
                            VStack{
                                Text("Month:").foregroundColor(.white)
                            Picker("", selection: $birthMonth){
                                ForEach(1..<13){ i in
                                    Text("\(String(i))").foregroundColor(.white)
                                }
                            }
                            .frame(width:data.mainViewWidth/7)
                            .clipped()
                            }
                            VStack{
                                Text("Day:").foregroundColor(.white)
                            Picker("", selection: $birthDay) {
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
                        
                        TextField("E-mail...", text: $email)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)

                        Text("Address :").foregroundColor(.white)
                        
                        TextField("Address...", text: $address)
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
                        Picker("", selection: $classs, content: {
                            ForEach(0..<allGrades().count,id:\.self){
                                Text(allGrades()[$0]).foregroundColor(.white)
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
                        
                        TextField("Nationality...", text: $nationality)
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
                        
                        TextField("Father Name...", text: $fatherName)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)

                        Text("Father Nationality :").foregroundColor(.white)
                        
                        TextField("Father Nationality...", text: $fatherNationlity)
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
                        
                        TextField("Father Address...", text: $fatherAddress)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)
                        
                        Text("Father Occupation :").foregroundColor(.white)
                        
                        TextField("Father Occupation...", text: $fatherOccupation)
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
                        
                        TextField("Mother Name...", text: $motherName)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)

                        Text("Mother Nationality :").foregroundColor(.white)
                        
                        TextField("Mother Nationality...", text: $motherNationlity)
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
                        
                        TextField("Mother Address...", text: $motherAddress)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)
                        
                        Text("Mother Occupation :").foregroundColor(.white)
                        
                        TextField("Mother Occupation...", text: $motherOccupation)
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
                            if Fname.isEmpty || id.isEmpty   {
                                showAlert = true
                            }else{
                                let newStudent = Student(context: moc)
                                newStudent.name = Fname
                                newStudent.studentId = Int16(-UUID().debugDescription.hashValue%10000)
                                if newStudent.studentId < 0 {
                                    newStudent.studentId =  -newStudent.studentId
                                }
                                newStudent.id = id
                                newStudent.religion = Religion
                                newStudent.nationality = nationality
                                newStudent.garde = grades[classs].grade
                                newStudent.adderss = address
                                newStudent.phoneNo = Int64(phoneNo) ?? 0
                                newStudent.gender = isMale ? 1:0
                                newStudent.motherName = motherName
                                newStudent.motherPhone = Int64(motherPhone) ?? 0
                                newStudent.motherAddress = motherAddress
                                newStudent.motherNationality = motherNationlity
                                newStudent.motherOccupation = motherOccupation
                                newStudent.fatherName = fatherName
                                newStudent.fatherPhone = Int64(fatherPhone) ?? 0
                                newStudent.fatherAddress = fatherAddress
                                newStudent.fatherNationality = fatherNationlity
                                newStudent.fatherOccupation = fatherOccupation
                                newStudent.addmissionDate = Date()
                                newStudent.email = email
                                newStudent.birthday = "\(birthYear) - \(birthMonth) - \(birthDay)"
                                newStudent.birthYear = Int16(birthYear)
                                newStudent.birthMonth = Int16(birthMonth)
                                newStudent.brithDay = Int16(birthDay)
                                data.showAddStudentWindow = false
                                
                                
                                do{
                                    try moc.save()
                                }catch{
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
                                birthDay = 0
                                birthMonth = 0
                                birthYear = 1999
                                
                                
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
                            Alert(title: Text("Alert"), message: Text("Please to add a new student at least make sure that you filled Student Name , id , Grade"), dismissButton: .default(Text("Close")))
                        })
                        Button(action: {
                            Fname = ""
                            studentId = ""
                            id = ""
                            Religion = ""
                            nationality = ""
                            classs = 0
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
                            birthDay = 0
                            birthMonth = 0
                            birthYear = 1999

                        }, label: {
                            Text("reset")
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
    
    func allGrades()->[String]{
        var allGrades = Array<String>()
        for grade in grades {
            allGrades.append(grade.grade!)
        }
        return allGrades
    }
}

struct addStudentWindow_Previews: PreviewProvider {
    static var previews: some View {
        addStudentWindow()
    }
}
