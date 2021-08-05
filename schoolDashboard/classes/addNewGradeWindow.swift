//
//  addNewGradeWindow.swift
//  schoolDashboard
//
//  Created by admin on 2021/3/3.
//

import SwiftUI

struct addNewGradeWindow: View {
    @EnvironmentObject var data:data
    @State var grade = ""
    @State var name = ""
    @State var roomNo = ""
    @State var grades = ["First","Second","Third","Fourth","Fifth","Sixth","Seventh","Eighth","Ninth","Tenth"]
    @Environment(\.managedObjectContext) private var moc
    @State var showAlert = false
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                ScrollView(showsIndicators: false){
                Text("Grade :").foregroundColor(.white).padding(.top)
                Picker("", selection: $grade, content: {
                    ForEach(grades,id:\.self){ g in
                        Text("\(g) Grade").foregroundColor(.white)
                    }
                    
                })

                
                Text("Section Name :").foregroundColor(.white)
                TextField("Name..", text: $name)
                    .foregroundColor(.white)
                    .font(.footnote)
                    .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                    .padding(10)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(.bottom)
                
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
                        if grade=="" || name=="" || roomNo==""{
                            showAlert = true
                        }else{
                            let newGrade = GradeSections(context: moc)
                            newGrade.grade = "\(grade) Grade Section \(name.uppercased())"
                            newGrade.roomNo = Int16(roomNo) ?? 0
                            do{
                            try moc.save()
                                print("Data was added")
                            }catch{
                                print(error.localizedDescription)
                            }
                            grade = ""
                            name = ""
                            roomNo = ""
                            data.showAddGradeWindow = false
                            
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
                        Alert(title: Text("Alert"), message: Text("Fill the all info before you finish this is process"), dismissButton: .default(Text("Close")))
                    })

                    Spacer()
                }
            }

            }
            
        }.padding().frame(width: data.mainViewWidth/1.7, height: data.mainViewHeight/2)
        .background(Color("lightBlue"))
        .cornerRadius(10)
        .shadow(radius: 2)
        Button(action: {data.showAddGradeWindow = false}, label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color("darkBlue"))
        })
        .offset(x: data.mainViewWidth/3, y: -data.mainViewHeight/3.5)

    }
}

struct addNewGradeWindow_Previews: PreviewProvider {
    static var previews: some View {
        addNewGradeWindow()
    }
}
