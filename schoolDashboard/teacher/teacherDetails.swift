//
//  teacherDetails.swift
//  schoolDashboard
//
//  Created by admin on 2021/2/25.
//

import SwiftUI

struct teacherDetails: View {
    @State var teacher = Teacher()
    var items = ["Name :","Gender :","Religion :","id :","Worker id :","Date Of Birth :","Major :","Address :","E-mail :","Salary :","Phone :","Nationality :","Experience :","Admission Date :"]
    var data = ["Fares Abukhader","Male","P515794","Jordanian","Math","3000","2","1999-10-9","Muslim","faresraed2011@yahoo.com","2021-2-24","884947568","Jordan irbid","13845713525"]
    @EnvironmentObject var d:data
    var body: some View {
        ZStack{
        VStack (alignment: .leading){
            ScrollView(showsIndicators: false){
            HStack{
                Text("\(teacher.name!) Teacher's Details")
                    .padding(.leading)
                Spacer()
            }
            Path(CGPath(roundedRect: CGRect(x: 10, y: 0, width: d.width, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil))
            
                    HStack{
                        Button(action: {d.showTeacherDetail=false}, label: {
                        Image(systemName: "arrow.left.circle.fill").foregroundColor(Color("darkBlue"))
                        Text("Go back").bold().font(.title3).foregroundColor(Color("darkBlue")).padding(.trailing,40)
                        })
                        Spacer()
                        
                        Button(action: {d.showTeacherGradeEditWindow=true}, label: {
                            Text("Edit Teacher Grades")
                                .font(.custom("", size: 8))
                                .foregroundColor(.white)
                                .padding(5)
                                .padding(.horizontal,5)
                                .background(Color("darkBlue"))
                                .cornerRadius(10)

                        })
                    }


        HStack(alignment: .top) {

            Image(teacher.gender==Int16(1) ? "male":"female")
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

                VStack(alignment: .leading){
                    VStack(alignment:.leading){
                        Text(teacher.name ?? "not found")
                        .font(.caption2)
                        .padding()
                        
                        Text(teacher.gender == Int16(1) ? "Male":"Female")
                        .font(.caption2)
                        .padding()

                        
                        Text(teacher.religion ?? "not found")
                        .font(.caption2)
                        .padding()

                        Text("\(teacher.id)")
                        .font(.caption2)
                        .padding()

                        Text("\(teacher.workId)")
                        .font(.caption2)
                        .padding()
                        
                        
                        Text("\(teacher.birthYear)-\(teacher.birthMonth)-\(teacher.birthDay)")
                        .font(.caption2)
                        .padding()
                        
                        
                        Text(teacher.major ?? "not found")
                        .font(.caption2)
                        .padding()
                        
                        
                        Text(teacher.address ?? "not found")
                        .font(.caption2)
                        .padding()
                        
                        Text(teacher.email ?? "not found")
                        .font(.caption2)
                        .padding()
                        
                        
                        Text("\(teacher.salary)")
                        .font(.caption2)
                        .padding()

                    }
                    VStack(alignment: .leading){
                        Text("\(teacher.phoneNo)")
                        .font(.caption2)
                        .padding()

                        Text(teacher.nationality ?? "not found")
                        .font(.caption2)
                        .padding()
                        
                        
                        Text(teacher.experience ?? "not found")
                        .font(.caption2)
                        .padding()
                        
                        Text("\(teacher.addmissionDate!)")
                        .font(.caption2)
                        .padding()


                    }
                    
                }

                Spacer()

                HStack{
                    Button(action: {
                        d.showTeacherEdit = true
                        d.TeacherDetail = teacher
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
            if d.showTeacherGradeEditWindow{
                teacherGradeEditWindow(teacherName : teacher.name!)
            }
     }
    }
}

struct teacherDetails_Previews: PreviewProvider {
    static var previews: some View {
        teacherDetails()
    }
}
