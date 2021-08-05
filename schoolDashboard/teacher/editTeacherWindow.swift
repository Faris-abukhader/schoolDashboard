//
//  editTeacherWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/5/23.
//

import SwiftUI
import CoreData

struct editTeacherWindow: View {
    @EnvironmentObject var d:data
    @Environment(\.managedObjectContext) var moc
    @State var showAlert = false
    
    var body: some View {
        ZStack{
        VStack(alignment:.leading){
            ScrollView(.vertical, showsIndicators: false){

                    VStack(alignment: .leading){
                    
                    Text("name :").foregroundColor(Color.white)
                        TextField("name...", text: Binding($d.TeacherDetail.name)!)
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
                        d.TeacherDetail.gender = 1
                    }, label: {
                        ZStack{
                        Image(systemName: "square.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(d.TeacherDetail.gender==1 ? .red:.white)
                            .cornerRadius(10)
                            if d.TeacherDetail.gender==1{
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 5, height: 5)
                                .foregroundColor(.white)
                            }
                        }
                        
                    })
                    Text("Male").foregroundColor(Color.white)
                    Button(action: {
                        d.TeacherDetail.gender = 0
                    }, label: {
                        ZStack{
                        Image(systemName: "square.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(d.TeacherDetail.gender==0 ? .red:.white)
                            .cornerRadius(10)
                            if d.TeacherDetail.gender==0{
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
                
                TextField("Religion...", text: Binding($d.TeacherDetail.religion)!)
                    .font(.footnote)
                    .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                    .padding(10)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(.bottom)
                    .foregroundColor(Color.white)
                        

                
                Text("id :").foregroundColor(Color.white)
                
                        TextField("id...", text: Binding(
                        get :{String(d.TeacherDetail.id)}, set:{d.TeacherDetail.id = Int32($0) ?? 0}))
                    .font(.footnote)
                    .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                    .padding(10)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(.bottom)
                    .foregroundColor(Color.white)


                        
                        Text("work Id :").foregroundColor(Color.white)
                        
                        TextField("work Id...", text: Binding(
                            get : {String(d.TeacherDetail.workId)},set:{d.TeacherDetail.workId = Int32($0) ?? 0}))
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
                            Picker("", selection: $d.TeacherDetail.birthYear){
                            ForEach(4..<16){ i in
                                Text("\(String(i))").foregroundColor(.white)
                            }
                        }
                        .frame(width:d.mainViewWidth/7)
                        .clipped()
                        }
                        VStack{
                            Text("Month:").foregroundColor(.white)
                        Picker("", selection:$d.TeacherDetail.birthMonth){
                            ForEach(1..<13){ i in
                                Text("\(String(i))").foregroundColor(.white)
                            }
                        }
                        .frame(width:d.mainViewWidth/7)
                        .clipped()
                        }
                        VStack{
                            Text("Day:").foregroundColor(.white)
                        Picker("", selection: $d.TeacherDetail.birthDay) {
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
                    
                    TextField("Major...", text: Binding($d.TeacherDetail.major)!)
                        .font(.footnote)
                        .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                        .padding(10)
                        .background(Color("darkBlue"))
                        .cornerRadius(10)
                        .padding(.bottom)
                        .foregroundColor(Color.white)
                    
                    
                    Text("Address :").foregroundColor(Color.white)
                    
                    TextField("Address...", text: Binding($d.TeacherDetail.address)!)
                        .font(.footnote)
                        .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                        .padding(10)
                        .background(Color("darkBlue"))
                        .cornerRadius(10)
                        .padding(.bottom)
                        .foregroundColor(Color.white)


                    Text("Email :").foregroundColor(Color.white)
                    
                    TextField("Email...", text: Binding($d.TeacherDetail.email)!)
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
                TextField("Salary...", text: Binding(
                    get:{String(d.TeacherDetail.salary)},set:{d.TeacherDetail.salary = Int16($0) ?? 0}))
                    .font(.footnote)
                    .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                    .padding(10)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(.bottom)
                    .foregroundColor(Color.white)

                
                Text("Phone number :").foregroundColor(Color.white)
                
                TextField("Phone number...", text: Binding(
                get:{String(d.TeacherDetail.phoneNo)},set:{d.TeacherDetail.phoneNo = Int64($0) ?? 0}))
                    .font(.footnote)
                    .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                    .padding(10)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(.bottom)
                    .padding(.bottom)
                    .foregroundColor(Color.white)
                



                
                
                
                Text("Nationality :").foregroundColor(Color.white)
                TextField("Nationality...", text: Binding($d.TeacherDetail.nationality)!)
                    .font(.footnote)
                    .frame(width: d.mainViewWidth/1.7 - 40, height: 15)
                    .padding(10)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(.bottom)
                    .foregroundColor(Color.white)

                
                
                Text("year of Experience :").foregroundColor(Color.white)
                TextField("year of Experience...", text: Binding($d.TeacherDetail.experience)!)
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
                        if d.TeacherDetail.name=="" || d.TeacherDetail.id==0 || d.TeacherDetail.major=="" || d.TeacherDetail.salary==0 {
                            showAlert = true
                        }else{
                            let f:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Teacher")
                            f.predicate = NSPredicate(format: "name = %@", d.TeacherDetail.name!)
                            do {
                            let fetchReturn = try moc.fetch(f)
                            let newTeacher = fetchReturn[0] as! NSManagedObject
                            newTeacher.setValue(d.TeacherDetail.name!, forKey: "name" )
                            newTeacher.setValue(d.TeacherDetail.gender, forKey: "gender" )
                            newTeacher.setValue(d.TeacherDetail.religion, forKey: "religion" )
                            newTeacher.setValue(d.TeacherDetail.id, forKey: "id" )
                            newTeacher.setValue(d.TeacherDetail.workId, forKey: "workId" )
                            newTeacher.setValue(d.TeacherDetail.birthYear, forKey: "birthYear" )
                            newTeacher.setValue(d.TeacherDetail.birthMonth, forKey: "birthMonth" )
                            newTeacher.setValue(d.TeacherDetail.birthDay, forKey: "birthDay" )
                            newTeacher.setValue(d.TeacherDetail.major, forKey: "major" )
                            newTeacher.setValue(d.TeacherDetail.address, forKey: "address")
                            newTeacher.setValue(d.TeacherDetail.email, forKey: "email" )
                            newTeacher.setValue(d.TeacherDetail.salary, forKey: "salary" )
                                newTeacher.setValue(d.TeacherDetail.phoneNo, forKey: "phoneNo" )
                            newTeacher.setValue(d.TeacherDetail.nationality, forKey: "nationality" )
                            newTeacher.setValue(d.TeacherDetail.experience, forKey: "experience" )
                            d.showTeacherEdit = false
                            do{
                                try moc.save()
                            }catch{
                                print(error.localizedDescription)
                            }
                            }catch{
                                print(error.localizedDescription)
                            }
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
                        d.showTeacherEdit = false
                    }, label: {
                        Text("Cancel")
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
        Button(action: {d.showTeacherEdit = false}, label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color("darkBlue"))
        })
        .offset(x: d.mainViewWidth/3, y: -d.mainViewHeight/3)

    }
}

struct editTeacherWindow_Previews: PreviewProvider {
    static var previews: some View {
        editTeacherWindow()
    }
}
