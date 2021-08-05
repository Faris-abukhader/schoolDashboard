//
//  allParents.swift
//  schoolDashboard
//
//  Created by admin on 2021/2/26.
//

import SwiftUI
import CoreData

struct allParents: View {
    @EnvironmentObject var data:data
    @State var searchContent = ""
    @State var IsallStudentSelected = false
    @State var numSort = true
    @State var nameSort = false
    @State var genderSort = false
    @State var dateOfBirthSrot = false
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var parents:FetchedResults<Student>
    var body: some View {
        ZStack{
        VStack{
            ScrollView( showsIndicators: false){
            parentHeader()

            Path(CGPath(roundedRect: CGRect(x: 0, y: 0, width: data.mainViewWidth, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil))
                
                
                parentsTableHeader()
            
                List{

                    ForEach(parents.reversed().filter{
                        data.parentSearchContent.isEmpty ? true : $0.fatherName!.contains(data.parentSearchContent)
                    }){ parent  in
                        if parent.fatherName?.count ?? 0 > 0 {
                            parentsTable(index: 0, name: parent.fatherName ?? " ", gender: 1, ocuupation: parent.fatherOccupation ?? " ", address: parent.fatherAddress ?? " ", phoneNo: parent.fatherPhone,sonName:parent.name ?? "")
                        }
                        if parent.motherName?.count ?? 0 > 0 {
                            parentsTable(index: 0, name: parent.motherName ?? " ", gender: 1, ocuupation: parent.motherOccupation ?? " ", address: parent.motherAddress ?? " ", phoneNo: parent.motherPhone,sonName:parent.name ?? "")

                        }

                    }

                }.cornerRadius(15)
                .frame(width:data.mainViewWidth-40,height: data.height/1.2)
            
            }
        }
            
            if data.showEditFather {
                editParentWindow()
                
            }
      }
    }
}

struct allParents_Previews: PreviewProvider {
    static var previews: some View {
        allParents()
    }
}
struct parentsTableHeader:View{
    @State var IsallStudentSelected = false
    @State var numSort = true
    @State var nameSort = false
    @State var genderSort = false
    @State var occupationSort = false
    @EnvironmentObject var data:data
    var body: some View{
        HStack(alignment: .firstTextBaseline){
            
            // num sort
            HStack{
            Button(action: {numSort.toggle()}, label: {
                Text("Num")
                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ?  6 : 10)
                    .foregroundColor(numSort ? Color("yellow") : Color(.darkGray))
            })
            }.frame(width: data.mainViewWidth/7-30)

            
            // name sort
            HStack{
            Button(action: {nameSort.toggle()}, label: {
                Text("Name")

                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ?  6 : 10)
                    .foregroundColor(nameSort ? Color("yellow") : Color(.darkGray))
                
            })
            }.frame(width: data.mainViewWidth/7-30)

            
            // gender sort
            HStack{
            Button(action: {genderSort.toggle()}, label: {
                Text("Gender")
                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ?  6 : 10)
                    .foregroundColor(genderSort ? Color("yellow") : Color(.darkGray))
            })
            }.frame(width: data.mainViewWidth/7-30)

            
            // occupation sort
            HStack{
            Button(action: {occupationSort.toggle()}, label: {
                Text("Occupation")
                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ?  6 : 10)
                    .foregroundColor(occupationSort ? Color("yellow") : Color(.darkGray))
                
            })
            }.frame(width: data.mainViewWidth/7-30)


            
            
            // address
            HStack{
            Text("Address")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/7-30)


            
            // parents phone no
            HStack{
            Text("Phone No")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/7-30)

            
            HStack{
            Text("Son Name")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/7-30)



            // action
            HStack{
            Text("Action")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/7-40)



        }

    }
}
struct parentsTable:View{
    @State var index:Int
    @State var name:String
    @State var gender:Int
    @State var ocuupation:String
    @State var address:String
    @State var phoneNo:Int64
    @State var sonName:String
    
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    @State var IsallStudentSelected = false
    var body: some View{
        HStack(alignment: .firstTextBaseline){
        HStack{
            
                HStack{
            Text("\(index)")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
                .padding(.horizontal,data.show ? 15:20)
                }.frame(width: data.mainViewWidth/7-30)


            HStack{
            Text(name)
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
                .padding(.horizontal,data.show ? 15:20)
             }.frame(width: data.mainViewWidth/7-30)

            HStack{
            Text(gender == 1 ? "Male" : "Female")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
                .padding(.horizontal,data.show ? 15:20)
            }.frame(width: data.mainViewWidth/7-30)


            HStack{
            Text(ocuupation)
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
                .padding(.horizontal,data.show ? 15:20)
            }.frame(width: data.mainViewWidth/7-30)


            HStack{
            Text(address)
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
                .padding(.horizontal,data.show ? 15:20)
            }.frame(width: data.mainViewWidth/7-30)

            HStack{
            Text("\(phoneNo)")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
                .padding(.horizontal,data.show ? 15:20)
                .onTapGesture {
                    data.showToast = true
                    data.toastContent = "parents phoneNo was copied successfully"
                    
                }
            }.frame(width: data.mainViewWidth/7-30)
            
            
            HStack{
            Text("\(sonName)")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
                .padding(.horizontal,data.show ? 15:20)
            }.frame(width: data.mainViewWidth/7-30)

            
            }
            
            

            
                HStack{
                    
                
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width:data.show ? 6 : 10, height: data.show ? 6 : 10)
                        .foregroundColor(Color(.green))
                        .onTapGesture {
                            data.showEditFather = true
                            let f:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Student")
                            f.predicate = NSPredicate(format: "fatherName = %@", name)
                            do {
                            let fetchReturn = try moc.fetch(f)
                            let newParent = fetchReturn[0] as! Student
                            data.studentEdit = newParent
                            }catch{
                                print(error.localizedDescription)
                            }
                        }


            }
            .frame(width: data.mainViewWidth/7-40)


           }
    }
}
struct parentHeader:View{
    @EnvironmentObject var data:data
    var body: some View{
        HStack{
            Text("All Perents")
                .bold()
                .font(.title3)
            Spacer()
            TextField("Search Perent...", text: $data.parentSearchContent)
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
