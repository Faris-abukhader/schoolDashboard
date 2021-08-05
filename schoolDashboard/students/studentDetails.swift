//
//  studentDetails.swift
//  schoolDashboard
//
//  Created by admin on 2021/2/24.
//

import SwiftUI
import CoreData

class student {
    let name = ""
    let gender = ""
    let id = ""
    let nationality = ""
    let fatherName = ""
    let fatherOccupation = ""
    let motherName = ""
    let dateOfBirth = ""
    let addmissionDate = ""
    let religion = ""
    let email = ""
    let grade = ""
    let section = ""
    let studentId = ""
    let Address = ""
    let phoneNo = ""
    
}

struct studentDetails: View {
    @State var student = Student()
    var items = ["Name :","Gender :","Religion :","id :","student Id :","Date Of Birth :","E-mail :","Address :","Grade :","Phone :","Nationality :","Father Name :","Father Nationality :","Father Phone :","Father Address :","Father Occupation","Mother Name :","Mother Natiionlilty :","Mother Phone :","Mother Address :","mother Occupation :","Admission Date :"]
    var data = ["Fares Abukhader","Male","P515794","Jordanian","Raed Abukhaer","Kefah Abukalil","1999-10-9","Muslim","Businessman","faresraed2011@yahoo.com","2021-2-24","tenth","3","884947568","Jordan irbid","13845713525"]
    @EnvironmentObject var d:data
    var body: some View {
        VStack (alignment: .leading){
            ScrollView(showsIndicators: false){
                HStack{
                    Text("\(student.name!) Details")
                        .padding(.leading)
                    Spacer()
                }
            Path(CGPath(roundedRect: CGRect(x: 10, y: 0, width: d.width, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil))
            
            Button(action: {d.showStudentDetail=false
                d.showStudentInfoForTeacher = false
            }, label: {
                HStack{
                    Image(systemName: "arrow.left.circle.fill").foregroundColor(Color("darkBlue"))
                    Text("Go back").bold().font(.title3).foregroundColor(Color("darkBlue")).padding(.trailing,40)
                    Spacer()
                }
            })

        HStack(alignment: .top) {

            Image(student.gender == Int16(1) ? "male":"female")
                .resizable()
                .frame(width: 150, height: 150)
                .cornerRadius(5)
                .padding(.leading)
            Spacer()
            
            HStack(alignment: .firstTextBaseline ){
                Spacer()
                VStack(alignment: .leading){
                    ForEach(0..<items.count){i in
                        Text(items[i])
                            .font(.caption2)
                            .foregroundColor(Color("fontColor"))
                            .padding()
                    }
                }

                VStack(alignment:.leading){
                VStack(alignment: .leading){
                    Text(student.name!)
                    .font(.caption2)
                    .padding()
                    
                    Text(student.gender == Int16(1) ? "Male":"Female")
                    .font(.caption2)
                    .padding()
                    
                    Text(student.religion ?? "not found")
                    .font(.caption2)
                    .padding()

                    
                    Text(student.id ?? "not found")
                    .font(.caption2)
                    .padding()
                    
                    Text("\(student.studentId)")
                    .font(.caption2)
                    .padding()
                    
                    Text("\(student.birthday!)")
                    .font(.caption2)
                    .padding()
                    
                    Text(student.email ??  "not found")
                    .font(.caption2)
                    .padding()
                    
                    Text(student.adderss ??  "not found")
                    .font(.caption2)
                    .padding()
                    
                    
                    Text(student.garde ??  "not found")
                    .font(.caption2)
                    .padding()

                    
                    Text("\(student.phoneNo)")
                    .font(.caption2)
                    .padding()
                    
                    
                    }
                    VStack(alignment: .leading){
                        
                    Text(student.nationality ?? "not found")
                    .font(.caption2)
                    .padding()

                        
                     Text(student.fatherName ?? "not found")
                     .font(.caption2)
                     .padding()
                        
                        Text(student.fatherNationality ?? "not found")
                        .font(.caption2)
                        .padding()
                        
                        Text("\(student.fatherPhone)")
                        .font(.caption2)
                        .padding()
                        
                        Text(student.fatherAddress ?? "not found")
                        .font(.caption2)
                        .padding()
                        
                        Text(student.fatherOccupation ?? "not found")
                        .font(.caption2)
                        .padding()

                    }
                
                VStack(alignment: .leading){
                    
                 Text(student.motherName ?? "not found")
                 .font(.caption2)
                 .padding()
                    
                    
                       Text(student.motherNationality ?? "not found")
                       .font(.caption2)
                       .padding()
                       
                       Text("\(student.motherPhone)")
                       .font(.caption2)
                       .padding()
                       
                       Text(student.motherAddress ?? "not found")
                       .font(.caption2)
                       .padding()
                       
                       Text(student.motherOccupation ?? "not found")
                       .font(.caption2)
                       .padding()
                    
                    
                    Text("\(student.addmissionDate!)")
                    .font(.caption2)
                    .padding()
                    
                    

                }
                    

                
                }
            }

                Spacer()
                HStack{
                    Button(action: {
                        // todo
                        d.showStudentEdit = true
                        d.studentEdit = student
                    }, label: {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(10)
                            .foregroundColor(Color(.lightGray))
                    })
                    Button(action: {}, label: {
                        Image(systemName: "printer")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(10)
                            .foregroundColor(Color(.lightGray))


                    })
                    Button(action: {}, label: {
                        Image(systemName: "tray.and.arrow.down")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(10)
                            .foregroundColor(Color(.lightGray))

                    })

                }

            }.padding(.trailing)
        }
        }
      }
       
    }


struct studentDetails_Previews: PreviewProvider {
    @Binding var std:Student
    static var previews: some View {
        studentDetails()
    }
}
