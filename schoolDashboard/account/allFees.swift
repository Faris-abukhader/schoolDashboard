//
//  allFees.swift
//  schoolDashboard
//
//  Created by admin on 2021/2/26.
//

import SwiftUI

struct allFees: View {
    @EnvironmentObject var data:data
    @State var searchContent = ""
    @State var IsallStudentSelected = false
    @State var feesSort = true
    @State var statusSort = false
    @State var dateOfchargeSrot = false
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var student:FetchedResults<Student>
    
    
    var body: some View {
        ZStack{
        VStack{
            ScrollView( showsIndicators: false){
                allFeesHeader()

            Path(CGPath(roundedRect: CGRect(x: 0, y: 0, width: data.mainViewWidth, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil))
                
                
                feesTableHeader()

                
                List{
                    ForEach(student.filter{
                        data.feeSearchContent.isEmpty ? true : $0.name!.contains(data.feeSearchContent)
                        }.sorted{
                        if data.feeSortType==1 {
                            return
    eachGradeFees(grade: $0.garde ?? "") - Int($0.totalAmount) <  eachGradeFees(grade: $1.garde ?? "") - Int($1.totalAmount)
                        } else if data.feeSortType==2 {
                            return $0.garde ?? "" > $1.garde ?? ""
                        } else if data.feeSortType==3 {
                            return $0.totalAmount > $1.totalAmount
                        } else if data.feeSortType==4 {
                            return $0.firstFees > $1.firstFees
                        } else {
                            return true
                        }
                    },id:\.self){ std in
                        feesTable(student: std)

                    }

                }.cornerRadius(15)
                .frame(height: data.height/1.2)
            
            
            
            
            
            
            
            
            }
            
        }.alert(isPresented: $data.showAlert, content: {
            Alert(title: Text("Tuitoin Fees"), message: Text("Tuition Fees For This Student Closed"), dismissButton: Alert.Button.cancel())
        })
            
            if data.showStudentPayment {
                studentPayment().environmentObject(data)
            }
            if data.showAllPayment {
                showAllPayment()
            }
            

        }

    }
}

struct allFees_Previews: PreviewProvider {
    static var previews: some View {
        allFees()
    }
}
struct feesTableHeader:View{
    @State var IsallStudentSelected = false
    @State var numSort = true
    @State var nameSort = false
    @State var genderSort = false
    @State var gradeSort = false
    @State var dateOfBirthSrot = false
    @State var feesSort = true
    @State var selectionSort = false
    @State var dateOfchargeSrot = false
    @EnvironmentObject var data:data
    var body: some View{
        HStack(alignment: .firstTextBaseline){

        
            
            HStack{
                Text("StudentId")
                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/6 - 30)

            
            HStack{
                Text("Name")
                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/6 - 30)

            
            HStack{
                Button(action: {data.feeSortType=1}, label: {
                Text("Status")
                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ?  6 : 10)
                    .foregroundColor(data.feeSortType==1 ? Color("yellow") : Color(.darkGray))
                
            })
            }.frame(width: data.mainViewWidth/6 - 30)

            

            HStack{
            Button(action: {data.feeSortType=2}, label: {
                Text("Grade")
                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ?  6 : 10)
                    .foregroundColor(data.feeSortType==2 ? Color("yellow") : Color(.darkGray))
                
            })
            }.frame(width: data.mainViewWidth/6 - 30)

                        

            HStack{
            Button(action: {data.feeSortType=3}, label: {
                Text("Fees")
                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ?  6 : 10)
                    .foregroundColor(data.feeSortType==3 ? Color("yellow") : Color(.darkGray))
                
            })
            }.frame(width: data.mainViewWidth/6 - 30)

            

            HStack{
            Button(action: {data.feeSortType=4}, label: {
                Text("Date")
                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ?  6 : 10)
                    .foregroundColor(data.feeSortType==4 ? Color("yellow") : Color(.darkGray))
                
            })
            }.frame(width: data.mainViewWidth/6 - 30)



            HStack{
            Text("Action")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/6 - 30)

            


        }

    }
}
struct feesTable:View{
    @State var student = Student()
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var data:data
    @State var IsallStudentSelected = false
    @State var isPaid = false
    var body: some View{
        HStack(alignment: .firstTextBaseline){
            
            
            
            
            HStack{
                Text("\(student.studentId)")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/6 - 30)


            HStack{
                Text(student.name ?? "")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/6 - 30)



            
            HStack{
                Text(eachGradeFees(grade: student.garde ?? "") - Int(student.totalAmount) == 0 ? "Paid":"due")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.white)
                .padding(.vertical,5)
                .padding(.horizontal,15)
                .background(eachGradeFees(grade: student.garde ?? "") - Int(student.totalAmount) == 0 ? Color.green:Color.red)
                .cornerRadius(10)
            }.frame(width: data.mainViewWidth/6 - 30)

            
            
            HStack{
                Text(student.garde ?? "")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/6 - 30)

            
            


            HStack{
                Text("\(student.totalAmount)")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/6 - 30)

            
 
            
            HStack{
                Text(student.firstFees)
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/6 - 30)

            
            HStack{

                
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width:data.show ? 6 : 10, height: data.show ? 6 : 10)
                        .foregroundColor(Color(.green))
                        .onTapGesture {
                            if eachGradeFees(grade: student.garde ?? "") - Int(student.totalAmount) > 0 {
                                data.showStudentPayment = true
                                data.studentEdit = student
                                data.paymentId = student.id!
                            } else {
                                data.showAlert = true
                            }
                                                        
                            

                            
                        }
                

                    Image(systemName: "eye")
                        .resizable()
                        .frame(width:data.show ? 6 : 10, height: data.show ? 6 : 10)
                        .foregroundColor(Color(.lightGray))
                        .onTapGesture {
                            data.showAllPayment = true
                            data.studentEdit = student
                        }
            

            }.frame(width: data.mainViewWidth/6 - 30)


        }
    }
}

struct allFeesHeader:View{
    @EnvironmentObject var data:data
    var body: some View{
        HStack{
            Text("Students Collection Fees")
                .bold()
                .font(.title3)
            Spacer()
            TextField("Search Perent...", text: $data.feeSearchContent)
                .font(.footnote)
                .frame(width: 120, height: 20)
                .padding(5)
                .background(Color("lightGry"))
                .cornerRadius(15)
            
            Button(action: {}, label: {
                Text("Search")
                    .font(.custom("", size: 8))
                    .padding(5)
                    .padding(.horizontal,5)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(.trailing)
            })
        }

    }
}
func eachGradeFees(grade:String)->Int{
    if grade.contains("First"){
        return 1000
    } else if grade.contains("Second"){
        return 1100
    }
    else if grade.contains("Third"){
        return 1200
    }
    else if grade.contains("Fourth"){
        return 1300
    }
    else if grade.contains("Fifth"){
        return 1400
    }
    else if grade.contains("Sixth"){
        return 1500
    }
    else if grade.contains("Seventh"){
        return 1600
    }
    else if grade.contains("Eighth"){
        return 1700
    }
    else if grade.contains("Ninth"){
        return 1800
    }
    else if grade.contains("Tenth"){
        return 1900
    }
    
    return 0
}
