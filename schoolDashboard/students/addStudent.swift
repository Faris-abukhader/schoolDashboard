//
//  addStudent.swift
//  schoolDashboard
//
//  Created by admin on 2021/2/25.
//

import SwiftUI

struct addStudent: View {
    @EnvironmentObject var d:data
    
    // student info
    @State var Fname = ""
    @State var Lname = ""
    @State var classs = ""
    @State var isMale = false
    @State var isFemale = false
    @State var Religion = ""
    @State var birthday = ""
    @State var email = ""
    @State var selection = ""
    @State var phoneNo = ""
    @State var nationality = ""
    @State var id = ""
    @State var address = ""
    
    // parent info
    @State var fatherName = ""
    @State var motherName = ""
    @State var fatherNationlity = ""
    @State var motherNationlity = ""
    @State var fatherPhone = ""
    @State var motherPhone = ""
    @State var fatherAddress = ""
    @State var motherAddress = ""

    var body: some View {
        VStack(alignment: .leading){
            Text("Add Student Form").font(.title)
            Path(CGPath(roundedRect: CGRect(x: 10, y: 0, width: d.width, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil))
            
            Text("Student Information").bold().font(.title2).padding(.bottom).offset(y: -20)
            
            HStack(alignment: .firstTextBaseline) {
                
                VStack(alignment: .leading){
                    Text("first name :")
                    TextField("frist name...", text: $Fname)
                        .textFieldStyle( RoundedBorderTextFieldStyle())

                    Text("Gender :")
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
                        Text("Male")
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
                        Text("Female")

                        
                    }.padding()
                    
                    Text("Religion :")
                    
                    TextField("Religion...", text: $Religion)
                        .textFieldStyle( RoundedBorderTextFieldStyle())
                    
                    Text("id :")
                    
                    TextField("id...", text: $id)
                        .textFieldStyle( RoundedBorderTextFieldStyle())


                    
                }
                
                VStack(alignment: .leading){
                    Text("Last name :")
                    TextField("Last name...", text: $Lname)
                        .textFieldStyle( RoundedBorderTextFieldStyle())

                    Text("Date Of Birth :")
                    TextField("dd/mm/yyyy", text: $birthday)
                        .textFieldStyle( RoundedBorderTextFieldStyle())
                        .padding(.bottom)

                    
                    Text("E-mail :")
                    
                    TextField("E-mail...", text: $email)
                        .textFieldStyle( RoundedBorderTextFieldStyle())
                    
                    Text("Address :")
                    
                    TextField("Address...", text: $address)
                        .textFieldStyle( RoundedBorderTextFieldStyle())


                    
                }
                
                VStack(alignment: .leading){
                    Text("Class :")
                    TextField("class...", text: $classs)
                        .textFieldStyle( RoundedBorderTextFieldStyle())

                    Text("Section :")
                    TextField("Section", text: $selection)
                        .textFieldStyle( RoundedBorderTextFieldStyle())
                        .padding(.bottom)
                    
                    Text("Phone number :")
                    
                    TextField("Phone number...", text: $phoneNo)
                        .textFieldStyle( RoundedBorderTextFieldStyle())
                    
                    Text("Nationality :")
                    
                    TextField("Nationality...", text: $nationality)
                        .textFieldStyle( RoundedBorderTextFieldStyle())



                    
                }


            }.offset(y: -40)
            
            Text("Parents Information").bold().font(.title2).padding(.bottom).padding(.top,40).offset(y: -20)
            
            HStack(alignment: .firstTextBaseline){
                
                VStack(alignment: .leading){
                    Text("Father Name :")
                    
                    TextField("Father Name...", text: $fatherName)
                        .textFieldStyle( RoundedBorderTextFieldStyle())
                        .foregroundColor(Color(.blue ))
                    
                    Text("Father Nationality :")
                    
                    TextField("Father Nationality...", text: $fatherNationlity)
                        .textFieldStyle( RoundedBorderTextFieldStyle())
                    
                    Text("Father Phone :")
                    
                    TextField("Father Phone...", text: $fatherPhone)
                        .textFieldStyle( RoundedBorderTextFieldStyle())

                    Text("Father Address :")
                    
                    TextField("Father Address...", text: $fatherAddress)
                        .textFieldStyle( RoundedBorderTextFieldStyle())

                }
                
                VStack(alignment: .leading){
                    Text("Mother Name :")
                    
                    TextField("Mother Name...", text: $motherName)
                        .textFieldStyle( RoundedBorderTextFieldStyle())
                    
                    Text("Mother Nationality :")
                    
                    TextField("Mother Nationality...", text: $motherNationlity)
                        .textFieldStyle( RoundedBorderTextFieldStyle())
                    
                    Text("Mother Phone :")
                    
                    TextField("Mother Phone...", text: $motherPhone)
                        .textFieldStyle( RoundedBorderTextFieldStyle())

                    Text("Mother Address :")
                    
                    TextField("Mother Address...", text: $motherAddress)
                        .textFieldStyle( RoundedBorderTextFieldStyle())
                    


                }

                
                
                
            }.offset(y: -40)
            HStack{
                Spacer()
                Button(action: {}, label: {
                    Text("Save")
                        .font(.footnote)
                        .padding(.horizontal,20)
                        .padding(.vertical,10)
                        .background(Color("yellow"))
                        .cornerRadius(10)
                })
                Button(action: {}, label: {
                    Text("Reset")
                        .font(.footnote)
                        .padding(.horizontal,20)
                        .padding(.vertical,10)
                        .background(Color("yellow"))
                        .cornerRadius(10)
                })
                Spacer()

            }
        }
    }
}

struct addStudent_Previews: PreviewProvider {
    static var previews: some View {
        addStudent()
    }
}
