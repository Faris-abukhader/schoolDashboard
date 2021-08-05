//
//  workerDetail.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/5.
//

import SwiftUI

struct workerDetail: View {
    @State var worker = Worker()
    var items = ["Name :","Gender :","id :","work Id :","Date Of Birth :","Address :","Phone :","Nationality :","Salary :","Work :","Contract Date :"]
    @EnvironmentObject var d:data
    var body: some View {
        VStack (alignment: .leading){
            ScrollView(showsIndicators: false){
                HStack{
                    Text("\(worker.name!) Details")
                        .padding(.leading)
                    Spacer()
                }
            Path(CGPath(roundedRect: CGRect(x: 10, y: 0, width: d.width, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil))
            
            Button(action: {d.ShowWorkerDetail=false}, label: {
                HStack{
                    Image(systemName: "arrow.left.circle.fill").foregroundColor(Color("darkBlue"))
                    Text("Go back").bold().font(.title3).foregroundColor(Color("darkBlue")).padding(.trailing,40)
                    Spacer()
                }
            })

        HStack(alignment: .top) {

            Image(worker.gender == Int16(1) ? "male":"female")
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
                    Text(worker.name!)
                    .font(.caption2)
                    .padding()
                    
                    Text(worker.gender == Int16(1) ? "Male":"Female")
                    .font(.caption2)
                    .padding()
                    
                    
                    Text("\(worker.id)")
                    .font(.caption2)
                    .padding()

                    
                    
                    Text("\(worker.workId)")
                    .font(.caption2)
                    .padding()

                    
                    Text("\(worker.birthYear)-\(worker.birthMonth)-\(worker.birthDay)")
                    .font(.caption2)
                    .padding()

                    
                    Text(worker.address ?? "not found")
                    .font(.caption2)
                    .padding()

                    
                    
                    Text("\(worker.phoneNo)")
                    .font(.caption2)
                    .padding()
                    
                    
                    Text(worker.nationality ??  "not found")
                    .font(.caption2)
                    .padding()
                    
                    
                    Text("\(worker.salary)")
                    .font(.caption2)
                    .padding()
                    
                    
                    }
                    VStack(alignment: .leading){
                        
                    Text(worker.work ?? "not found")
                    .font(.caption2)
                    .padding()

                        
                     Text("\(worker.dateOfWorking!)")
                     .font(.caption2)
                     .padding()
                        
                    }
                

                
                }
            }


                Spacer()
                HStack{
                    Button(action: {
                        d.showEditWorker = true
                        d.workerDetail = worker
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

struct workerDetail_Previews: PreviewProvider {
    static var previews: some View {
        workerDetail()
    }
}
