//
//  editGradeWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/9.
//

import SwiftUI
import CoreData

struct editGradeWindow: View {
    @State var grade = ""
    @State var roomNo = ""
    @EnvironmentObject var data:data
    @State var showAlert = false
    @State var showWarning = false
    
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                Text("Grade :").foregroundColor(.white).padding(.top)
                Text("\(data.className)").foregroundColor(Color(.lightGray))

                                
                Text("Room No :").foregroundColor(.white)
                TextField("Room No..", text: $roomNo)
                    .foregroundColor(.white)
                    .keyboardType(.numberPad)
                    .font(.footnote)
                    .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                    .padding(10)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(.bottom)


                HStack{
                    Spacer()
                    Button(action: {
                        if !roomNo.isEmpty{
                            showAlert = true
                        } else {
                            showWarning = true
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
                    
                    .alert(isPresented: $showWarning, content: {
                        Alert(title: Text("Room No"), message: Text("Make sure that you wrote the room no ."), dismissButton: Alert.Button.cancel())
                    })

                    Spacer()
                }
                

            }
            
        }.padding().frame(width: data.mainViewWidth/1.7, height: data.mainViewHeight/4)
        .background(Color("lightBlue"))
        .cornerRadius(10)
        .shadow(radius: 2)
        Button(action: {data.showEditGradeWindow = false}, label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color("darkBlue"))
        })
        .offset(x: data.mainViewWidth/3, y: -data.mainViewHeight/3.5)
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Warning"), message: Text("Are you sure you want to save the changes ?"), primaryButton: Alert.Button.destructive(Text("Yes"), action: {
                
                let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "GradeSections")
                fetch.predicate = NSPredicate.init(format: "grade = %@", grade)
                do {
                    let fetchreturn = try moc.fetch(fetch)
                    let newGrade = fetchreturn[0] as! NSManagedObject
                    newGrade.setValue(Int16(roomNo),forKey:"roomNo")
                    do{
                        try moc.save()
                    }catch{
                        print(error.localizedDescription)
                    }
                    data.showEditGradeWindow = false
                }catch{
                    print(error.localizedDescription)
                }
                
            }), secondaryButton: Alert.Button.cancel())
        })

    }
}

struct editGradeWindow_Previews: PreviewProvider {
    static var previews: some View {
        editGradeWindow()
    }
}
