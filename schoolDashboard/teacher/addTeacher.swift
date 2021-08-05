//
//  addTeacher.swift
//  schoolDashboard
//
//  Created by admin on 2021/2/25.
//

import SwiftUI

struct addTeacher: View {
    @EnvironmentObject var d:data
    @State var Fname = ""
    @State var Lname = ""
    @State var major = ""
    @State var isMale = false
    @State var isFemale = false
    @State var Religion = ""
    @State var birthday = ""
    @State var email = ""
    @State var phoneNo = ""
    @State var nationality = ""
    @State var id = ""
    @State var address = ""
    @State var salary = ""
    @State var experience = ""
    var body: some View {
        
        VStack(alignment: .leading){
            Text("Add Teacher/Worker Form").font(.title)
            Path(CGPath(roundedRect: CGRect(x: 10, y: 0, width: d.width, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil))
            
            Text("Teacher Information").bold().font(.title2).padding(.bottom).offset(y: -20)
                .padding(.bottom,30).offset( y: -350)
            
            HStack(alignment: .firstTextBaseline) {
                
                VStack(alignment: .leading){
                    Text("first name :")
                    TextField("frist name...", text: $Fname)
                        .font(.footnote)
                        .frame(width: d.mainViewWidth/3.5, height: 15)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom)


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
                    .padding(.bottom)
                    
                    Text("Religion :")
                    
                    TextField("Religion...", text: $Religion)
                        .font(.footnote)
                        .frame(width: d.mainViewWidth/3.5, height: 15)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom)

                    
                    Text("id :")
                    
                    TextField("id...", text: $id)
                        .font(.footnote)
                        .frame(width: d.mainViewWidth/3.5, height: 15)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom)



                    
                }
                
                VStack(alignment: .leading){
                    Text("Last name :")
                    TextField("Last name...", text: $Lname)
                        .font(.footnote)
                        .frame(width: d.mainViewWidth/3.5, height: 15)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom)

                    Text("Date Of Birth :")
                    TextField("dd/mm/yyyy", text: $birthday)
                        .font(.footnote)
                        .frame(width: d.mainViewWidth/3.5, height: 15)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom)
                        .padding(.bottom)

                    
                    Text("E-mail :")
                    
                    TextField("E-mail...", text: $email)
                        .font(.footnote)
                        .frame(width: d.mainViewWidth/3.5, height: 15)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom)

                    Text("Address :")
                    
                    TextField("Address...", text: $address)
                        .font(.footnote)
                        .frame(width: d.mainViewWidth/3.5, height: 15)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom)


                    
                }
                
                VStack(alignment: .leading){
                    Text("Salary :")
                    TextField("Salary...", text: $salary)
                        .font(.footnote)
                        .frame(width: d.mainViewWidth/3.5, height: 15)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom)

                    
                    Text("Phone number :")
                    
                    TextField("Phone number...", text: $phoneNo)
                        .font(.footnote)
                        .frame(width: d.mainViewWidth/3.5, height: 15)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom)
                        .padding(.bottom)
                    
                    Text("Nationality :")
                    
                    TextField("Nationality...", text: $nationality)
                        .font(.footnote)
                        .frame(width: d.mainViewWidth/3.5, height: 15)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom)

                    Text("year of Experience :")
                    
                    TextField("year of Experience...", text: $experience)
                        .font(.footnote)
                        .frame(width: d.mainViewWidth/3.5, height: 15)
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom)




                    
                }



            }.offset(y: -400)
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

struct addTeacher_Previews: PreviewProvider {
    static var previews: some View {
        addTeacher()
    }
}
