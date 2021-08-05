//
//  addWorkerWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/5.
//

import SwiftUI

struct addWorkerWindow: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var data:data
    @State var name = ""
    @State var gender = 0
    @State var age = 0
    @State var id = ""
    @State var workId = ""
    @State var BirthDay = ""
    @State var birthMonth = ""
    @State var birthYear = ""
    @State var address = ""
    @State var phoneNo = ""
    @State var nationality = ""
    @State var salary = ""
    @State var work = ""
    @State var contractDate = ""
    @State var showAlert = false
    @State var currentDate = Date()
    var format:DateFormatter{
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
                        
                    Text("full name :").foregroundColor(.white)
                    TextField("full name...", text: $name)
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
                            gender = 1
                        }, label: {
                            ZStack{
                            Image(systemName: "square.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(gender==1 ? .red:.white)
                                .cornerRadius(10)
                                if gender==1 {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(.white)
                                }
                            }
                            
                        })
                        Text("Male").foregroundColor(.white)
                        Button(action: {
                            gender = 0
                        }, label: {
                            ZStack{
                            Image(systemName: "square.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(gender==0 ? .red:.white)
                                .cornerRadius(10)
                                if gender == 0 {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(.white)
                                }

                            }
                            
                        })
                        Text("Female").foregroundColor(.white)

                        
                    }.padding()
                    

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
                        
                        Text("work id :").foregroundColor(.white)
                        
                        TextField("work id...", text: $workId)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)

                        
                        
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
                            Picker("", selection: $BirthDay) {
                                ForEach(1..<32){ i in
                                    Text("\(String(i))").foregroundColor(.white)
                                }
                            }
                            .frame(width:data.mainViewWidth/7)
                            .clipped()
                            }
                            Spacer()
                        }

                        
                        

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
                        
                        Text("Salary :").foregroundColor(.white)
                        
                        TextField("Salary...", text: $salary)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)
                        
                        
                        Text("Work :").foregroundColor(.white)
                        
                        TextField("Work...", text: $work)
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
                            if name=="" || id=="" {
                                showAlert = true
                            }else{
                                let newWorker = Worker(context: moc)
                                newWorker.name = name
                                newWorker.gender = Int16(gender)
                                newWorker.id = Int32(id) ?? 0
                                newWorker.workId = Int32(workId) ?? 0
                                newWorker.birthDay = Int16(BirthDay) ?? 0
                                newWorker.birthMonth = Int16(birthMonth) ?? 0
                                newWorker.birthYear = Int16(birthYear) ?? 0
                                newWorker.address = address
                                newWorker.phoneNo = Int64(phoneNo) ?? 0
                                newWorker.nationality = nationality
                                newWorker.salary = Int16(salary) ?? 0
                                newWorker.work = work
                                newWorker.dateOfWorking = format.string(from: currentDate)
                                
                                
                                do {
                                    try moc.save()
                                }catch{
                                    print(error.localizedDescription)
                                }
                                
                                name = ""
                                gender = 1
                                id = ""
                                workId = ""
                                BirthDay = ""
                                birthMonth = ""
                                birthYear = ""
                                address = ""
                                phoneNo = ""
                                nationality = ""
                                salary = ""
                                work = ""
                                
                                data.showAddWorkerWindow = false
                                
                                
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
                            Alert(title: Text("Alert"), message: Text("Please to add a new worker at least make sure that you filled Name , id and Salary."), dismissButton: .default(Text("Close")))
                        })
                        Button(action: {
                            name = ""
                            gender = 1
                            id = ""
                            workId = ""
                            BirthDay = ""
                            birthMonth = ""
                            birthYear = ""
                            address = ""
                            phoneNo = ""
                            nationality = ""
                            salary = ""
                            work = ""
                            
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
                data.showAddWorkerWindow = false
        }, label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color("darkBlue"))
        })
        .offset(x: data.mainViewWidth/3, y: -data.mainViewHeight/3)
    }
}

struct addWorkerWindow_Previews: PreviewProvider {
    static var previews: some View {
        addWorkerWindow()
    }
}
