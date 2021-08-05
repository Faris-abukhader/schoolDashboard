//
//  editParentWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/5/26.
//

import SwiftUI
import CoreData

struct editParentWindow: View {
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    @State var showAlert = false
    var body: some View {
    ZStack{
            
        
    VStack(alignment: .leading){
        Text("Edit Father Imformations")
            .bold()
            .font(.title2)
            .foregroundColor(.white)
            .padding(.bottom)
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
            
            TextField("Father Phone...", text: Binding(get: {String(data.studentEdit.fatherPhone)}, set:{ data.studentEdit.fatherPhone = Int64($0) ?? 0}))
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
                    
                    
                    
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            if data.studentEdit.fatherName?.count==0 {
                                showAlert = true
                            }else{
                                let f:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Student")
                                f.predicate = NSPredicate(format: "name = %@", data.studentEdit.name!)
                                do {
                                let fetchReturn = try moc.fetch(f)
                                let newParent = fetchReturn[0] as! NSManagedObject
                                    newParent.setValue(data.studentEdit.fatherName ?? "", forKey: "fatherName" )
                                    newParent.setValue(data.studentEdit.fatherAddress ?? "", forKey: "fatherAddress")
                                    newParent.setValue(data.studentEdit.fatherOccupation ?? "", forKey: "fatherOccupation")
                                    newParent.setValue(data.studentEdit.fatherNationality ?? "", forKey: "fatherNationality")
                                    newParent.setValue(data.studentEdit.fatherPhone , forKey: "fatherPhone")
                                do{
                                    try moc.save()
                                    data.showEditFather = false
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
                            Alert(title: Text("Alert"), message: Text("Please make sure at least the the father name was filled "), dismissButton: .default(Text("Close")))
                        })

                        Spacer()
                    }

                

                
            }.padding()
            
            
        }.frame(width: data.mainViewWidth/1.7, height: data.mainViewHeight/1.7)
        .background(Color("lightBlue"))
        .cornerRadius(10)
        .shadow(radius: 2)
        
        Button(action: {data.showEditFather = false}, label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color("darkBlue"))
        })
        .offset(x: data.mainViewWidth/3, y: -data.mainViewHeight/3)


    }
}

struct editParentWindow_Previews: PreviewProvider {
    static var previews: some View {
        editParentWindow()
    }
}
