//
//  editWorkerWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/5.
//

import SwiftUI
import CoreData

struct editWorkerWindow: View {
    @State var worker = Worker()
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    @State var showAlert = false

    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    
                    VStack(alignment: .leading) {
                        
                    Text("full name :").foregroundColor(.white)
                        TextField("full name...", text: Binding($data.workerDetail.name)!)
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
                            data.workerDetail.gender = 1
                        }, label: {
                            ZStack{
                            Image(systemName: "square.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(data.workerDetail.gender==1 ? .red:.white)
                                .cornerRadius(10)
                                if data.workerDetail.gender==1 {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(.white)
                                }
                            }
                            
                        })
                        Text("Male").foregroundColor(.white)
                        Button(action: {
                            data.workerDetail.gender = 0
                        }, label: {
                            ZStack{
                            Image(systemName: "square.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(data.workerDetail.gender==0 ? .red:.white)
                                .cornerRadius(10)
                                if data.workerDetail.gender == 0 {
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
                    
                        TextField("id...", text: Binding(
                            get :{String(data.workerDetail.id)}, set:{data.workerDetail.id = Int32($0) ?? 0}))
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
                        
                        TextField("work id...", text: Binding(
                                get :{String(data.workerDetail.workId)}, set:{data.workerDetail.workId = Int32($0) ?? 0}))
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
                                Picker("", selection: $data.workerDetail.birthYear){
                                ForEach(1900..<2021){ i in
                                    Text("\(String(i))").foregroundColor(.white)
                                }
                            }
                            .frame(width:data.mainViewWidth/7)
                            .clipped()
                            }
                            VStack{
                                Text("Month:").foregroundColor(.white)
                                Picker("", selection: $data.workerDetail.birthMonth){
                                ForEach(1..<13){ i in
                                    Text("\(String(i))").foregroundColor(.white)
                                }
                            }
                            .frame(width:data.mainViewWidth/7)
                            .clipped()
                            }
                            VStack{
                                Text("Day:").foregroundColor(.white)
                            Picker("", selection: $data.workerDetail.birthDay) {
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
                        
                        TextField("Address...", text: Binding($data.workerDetail.address)!)
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
                        
                        TextField("Phone number...", text: Binding(
                          get :{String(data.workerDetail.phoneNo)}, set:{data.workerDetail.phoneNo = Int64($0) ?? 0}))

                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)

                        Text("Nationality :").foregroundColor(.white)
                        
                        TextField("Nationality...", text: Binding($data.workerDetail.nationality)!)
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)
                        
                        Text("Salary :").foregroundColor(.white)
                        
                        TextField("Salary...", text: Binding(
                                    get :{String(data.workerDetail.salary)},set:{data.workerDetail.salary = Int16($0) ?? 0}))
                            .font(.footnote)
                            .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                            .padding(10)
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding(.bottom)
                            .foregroundColor(.white)
                        
                        
                        Text("Work :").foregroundColor(.white)
                        
                        TextField("Work...", text: Binding($data.workerDetail.work)!)
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
                            if data.workerDetail.name == "" || data.workerDetail.id  == Int32(0) {
                                showAlert = true
                            }else{
                                let f:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Worker")
                                f.predicate = NSPredicate(format: "name = %@", data.workerDetail.name!)
                                do {
                                let fetchReturn = try moc.fetch(f)
                                let newWorker = fetchReturn[0] as! NSManagedObject
                                    newWorker.setValue(data.workerDetail.name!, forKey: "name")
                                    newWorker.setValue(data.workerDetail.gender, forKey: "gender")
                                    newWorker.setValue(data.workerDetail.id, forKey: "id")
                                    newWorker.setValue(data.workerDetail.workId, forKey: "workId")
                                    newWorker.setValue(data.workerDetail.birthDay, forKey: "birthDay")
                                    newWorker.setValue(data.workerDetail.birthMonth, forKey: "birthMonth")
                                    newWorker.setValue(data.workerDetail.birthYear, forKey: "birthYear")
                                    newWorker.setValue(data.workerDetail.address, forKey: "address")
                                    newWorker.setValue(data.workerDetail.phoneNo, forKey: "phoneNo")
                                    newWorker.setValue(data.workerDetail.nationality, forKey: "nationality")
                                    newWorker.setValue(data.workerDetail.salary, forKey: "salary")
                                    newWorker.setValue(data.workerDetail.work, forKey: "work")

                                    do{
                                        try moc.save()
                                    }catch{
                                        print(error.localizedDescription)
                                    }

                                }catch{
                                    print(error.localizedDescription)
                                }
                                
                                data.showEditWorker = false
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
                            Alert(title: Text("Alert"), message: Text("Please after editing the worker info make sure the worker name and worker id is filled."), dismissButton: .default(Text("Close")))
                        })
                        Button(action: {
                            data.showEditWorker = false
                        }, label: {
                            Text("Close")
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

struct editWorkerWindow_Previews: PreviewProvider {
    static var previews: some View {
        editWorkerWindow()
    }
}
