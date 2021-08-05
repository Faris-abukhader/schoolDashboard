//
//  addTeacherWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/3/2.
//

import SwiftUI

struct addTeacherWindow: View {
    @FetchRequest(entity: Teacher.entity(), sortDescriptors: []) private var teacher:FetchedResults<Teacher>
    @Environment(\.managedObjectContext) private var moc
    @EnvironmentObject var d:data
    @State var Fname = ""
    @State var major = ""
    @State var isMale = false
    @State var isFemale = false
    @State var Religion = ""
    @State var birthday = ""
    @State var birthYear = 0
    @State var birthMonth = 0
    @State var birthDay = 0
    @State var email = ""
    @State var phoneNo = ""
    @State var nationality = ""
    @State var id = ""
    @State var workId = ""
    @State var address = ""
    @State var salary = ""
    @State var experience = ""
    @State var addmissionDate = Date()
    
    @State var showAlert = false
    var body: some View {
        ZStack{
        VStack(alignment:.leading){
            ScrollView(.vertical, showsIndicators: false){

                    VStack(alignment: .leading){
                    
                    Text("name :").foregroundColor(Color.white)
                        TextField("name...", text: $Fname)
                            .font(.footnote)
                            .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .padding(.bottom)
                    


                Text("Gender :").foregroundColor(Color.white)
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
                    Text("Male").foregroundColor(Color.white)
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
                    Text("Female").foregroundColor(Color.white)

                    
                }.padding()
                .padding(.bottom)
                
                Text("Religion :").foregroundColor(Color.white)
                
                TextField("Religion...", text: $Religion)
                    .font(.footnote)
                    .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                    .padding(10)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(.bottom)
                    .foregroundColor(Color.white)
                        

                
                Text("id :").foregroundColor(Color.white)
                
                TextField("id...", text: $id)
                    .font(.footnote)
                    .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                    .padding(10)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(.bottom)
                    .foregroundColor(Color.white)


                        
                        Text("work Id :").foregroundColor(Color.white)
                        
                        TextField("id...", text: $workId)
                            .font(.footnote)
                            .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(Color.white)



                }
                .padding(.top,20)

                VStack(alignment: .leading){
                    
                    Text("Date Of Birth :").foregroundColor(.white)
                    HStack{

                        Spacer()
                        VStack{
                            Text("Year:").foregroundColor(.white)
                        Picker("", selection: $birthYear){
                            ForEach(4..<16){ i in
                                Text("\(String(i))").foregroundColor(.white)
                            }
                        }
                        .frame(width:d.mainViewWidth/7)
                        .clipped()
                        }
                        VStack{
                            Text("Month:").foregroundColor(.white)
                        Picker("", selection: $birthMonth){
                            ForEach(1..<13){ i in
                                Text("\(String(i))").foregroundColor(.white)
                            }
                        }
                        .frame(width:d.mainViewWidth/7)
                        .clipped()
                        }
                        VStack{
                            Text("Day:").foregroundColor(.white)
                        Picker("", selection: $birthDay) {
                            ForEach(1..<32){ i in
                                Text("\(String(i))").foregroundColor(.white)
                            }
                        }
                        .frame(width:d.mainViewWidth/7)
                        .clipped()
                        }
                        Spacer()
                    }

                    
                    
                    Text("Major :").foregroundColor(Color.white)
                    
                    TextField("Major...", text: $major)
                        .font(.footnote)
                        .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                        .padding(10)
                        .background(Color("darkBlue"))
                        .cornerRadius(10)
                        .padding(.bottom)
                        .foregroundColor(Color.white)
                    
                    
                    Text("Address :").foregroundColor(Color.white)
                    
                    TextField("Address...", text: $address)
                        .font(.footnote)
                        .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                        .padding(10)
                        .background(Color("darkBlue"))
                        .cornerRadius(10)
                        .padding(.bottom)
                        .foregroundColor(Color.white)


                    Text("Email :").foregroundColor(Color.white)
                    
                    TextField("Email...", text: $email)
                        .font(.footnote)
                        .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                        .padding(10)
                        .background(Color("darkBlue"))
                        .cornerRadius(10)
                        .padding(.bottom)
                        .foregroundColor(Color.white)

                    
                    
                    
                    
                }
            VStack(alignment: .leading) {
                


                
                Text("Salary :").foregroundColor(Color.white)
                TextField("Salary...", text: $salary)
                    .font(.footnote)
                    .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                    .padding(10)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(.bottom)
                    .foregroundColor(Color.white)

                
                Text("Phone number :").foregroundColor(Color.white)
                
                TextField("Phone number...", text: $phoneNo)
                    .font(.footnote)
                    .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                    .padding(10)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(.bottom)
                    .padding(.bottom)
                    .foregroundColor(Color.white)
                



                
                
                
                Text("Nationality :").foregroundColor(Color.white)
                TextField("Nationality...", text: $nationality)
                    .font(.footnote)
                    .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                    .padding(10)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(.bottom)
                    .foregroundColor(Color.white)

                
                
                Text("year of Experience :").foregroundColor(Color.white)
                TextField("year of Experience...", text: $experience)
                    .font(.footnote)
                    .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                    .padding(10)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(.bottom)
                    .foregroundColor(Color.white)

                
                HStack{
                    Spacer()
                    Button(action: {
                        if Fname=="" || id=="" || major=="" || salary.count<1 {
                            showAlert = true
                        }else{
                            let newTeacher = Teacher(context: moc)
                            newTeacher.name = Fname
                            newTeacher.id = Int32(id) ?? 0
                            newTeacher.workId = Int32(workId) ?? 0
                            newTeacher.nationality = nationality
                            newTeacher.gender = isMale ? 1:0
                            newTeacher.salary = Int16(salary) ?? 0
                            newTeacher.experience = experience
                            newTeacher.phoneNo = Int64(phoneNo) ?? 0
                            newTeacher.address = address
                            newTeacher.birthday = "\(birthYear) - \(birthMonth) - \(birthDay)"
                            newTeacher.email = email
                            newTeacher.major = major
                            newTeacher.addmissionDate = Date()
                            newTeacher.religion = Religion
                            newTeacher.birthDay = Int16(birthDay)
                            newTeacher.birthMonth = Int16(birthMonth)
                            newTeacher.birthYear = Int16(birthYear)
                            d.showAddTeacherWindow = false
                            do{
                                try moc.save()
                            }catch{
                                print(error.localizedDescription)
                            }
                            Fname = ""
                            id = ""
                            workId = ""
                            nationality = ""
                            isMale = false
                            isFemale = false
                            salary = ""
                            experience = ""
                            phoneNo = ""
                            address = ""
                            birthday = ""
                            email = ""
                            major = ""
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
                        Alert(title: Text("Alert"), message: Text("To add teacher you have to be sure name and id major and salary is fulled"), dismissButton: .default(Text("Close")))
                    })
                    Button(action: {
                        Fname = ""
                        id = ""
                        workId = ""
                        nationality = ""
                        isMale = false
                        isFemale = false
                        salary = ""
                        experience = ""
                        phoneNo = ""
                        address = ""
                        birthday = ""
                        email = ""
                        major = ""

                    }, label: {
                        Text("Reset")
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

                    
            
            }
        }.padding(.horizontal)
        }.frame(width: d.mainViewWidth/1.7, height: d.mainViewHeight/1.7)
        .background(Color("lightBlue"))
        .cornerRadius(10)
        .shadow(radius: 2)
        Button(action: {d.showAddTeacherWindow = false}, label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color("darkBlue"))
        })
        .offset(x: d.mainViewWidth/3, y: -d.mainViewHeight/3)
  }
}

struct addTeacherWindow_Previews: PreviewProvider {
    static var previews: some View {
        addTeacherWindow()
    }
}
