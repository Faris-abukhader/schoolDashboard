//
//  allWorker.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/5.
//

import SwiftUI
import CoreData

struct allWorker: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var data:data
    @FetchRequest(entity: Worker.entity(), sortDescriptors: []) var worker :FetchedResults<Worker>
    var body: some View {
        ZStack{
            if data.ShowWorkerDetail {
                workerDetail(worker: data.workerDetail)
            } else {
        VStack{
            ScrollView( showsIndicators: false){
                allWorkerheader().frame(width:data.mainViewWidth-40)
            Path(CGPath(roundedRect: CGRect(x: 0, y: 0, width: data.mainViewWidth, height: 0.2), cornerWidth: 0, cornerHeight: 0, transform: nil))
                workerTableHeader()
                List{
                    ForEach(worker.filter{
                        data.workerSearchContent.isEmpty ? true : $0.name!.contains(data.workerSearchContent)
                    }
                    .sorted{
                        if data.allWorkerSortType == 1 {
                            return $0.name! < $1.name!
                        } else
                        if data.allWorkerSortType == 2{
                           return  $0.gender < $1.gender
                        } else {
                            return true
                        }
                    }
                    .reversed()){ wrk in
                        workerTable(worker:wrk)
                    }
                }.cornerRadius(15)
                .onTapGesture {
                    
                }
                .frame(width:data.mainViewWidth-40,height: data.height/1.2)
            }
        }
        }
            if data.showAddWorkerWindow {
                addWorkerWindow()
            }
            
            if data.showEditWorker {
                editWorkerWindow(worker:data.workerDetail)

            }
    }


    }
}

struct allWorker_Previews: PreviewProvider {
    static var previews: some View {
        allWorker()
    }
}

struct allWorkerheader:View{
    @EnvironmentObject var data:data
    var body: some View{
        HStack{
            Text("All Workers")
                .bold()
                .font(.title3)
            Spacer()
            TextField("search Worker...", text: $data.workerSearchContent)
                .font(.footnote)
                .frame(width: 120, height: 20)
                .padding(5)
                .background(Color("lightGry"))
                .cornerRadius(15)
            
            Button(action: {
                withAnimation(.spring()){
                            data.showAddWorkerWindow.toggle()
                }
            }, label: {
                Text("Add Worker")
                    .font(.custom("", size: 8))
                    .foregroundColor(.white)
                    .padding(5)
                    .padding(.horizontal,5)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(.trailing)
            })
        }

    }
}
struct workerTableHeader:View{
    @EnvironmentObject var data:data
    var body: some View{
        HStack(alignment: .center){

            
            HStack{
            Text("StudentId")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/6-20)

            
            HStack{
            Button(action: {
                data.allWorkerSortType = 1
            }, label: {
                Text("Name")
                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ?  6 : 10)
                    .foregroundColor( data.allWorkerSortType == 1 ? Color("yellow") : Color(.darkGray))
                
            })
            }.frame(width: data.mainViewWidth/6)
            
            
            HStack{
            Button(action: {
                data.studentSortType = 2
            }, label: {
                Text("Gender")
                    .font(.custom("", size:data.show  ? 8:10))
                    .foregroundColor(.black)
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .resizable()
                    .frame(width:data.show ? 6 : 10, height: data.show ?  6 : 10)
                    .foregroundColor( data.allWorkerSortType==2 ? Color("yellow") : Color(.darkGray))
            })
            }.frame(width: data.mainViewWidth/6-20)
            
            
            
            
            
            HStack{
            Text("Phone No")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/6-20)
            
            
            
            HStack{
            Text("Work")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/6-20)

            
            
            HStack{
            Text("Action")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/6-20)
            


        }.padding(.leading,-35)

    }
}
struct workerTable:View{
    @State var worker:Worker
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) private var moc
    @State var deleteStudent = false
    var body: some View{
        HStack(alignment: .center){
            HStack{
                Text(String(worker.workId))
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/6-20)
            
            
            HStack{
                Text(worker.name ?? " ")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/9)
            
            HStack{
                Text(worker.gender == Int16(1) ? "Male":"Female")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/6-20)


            
            HStack{
                Text(String(worker.phoneNo) ?? "")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
                    .onTapGesture {
                        data.showToast = true
                        data.toastContent = "worker phoneNo was copied successfully"
                        toastContent(Content:String(worker.phoneNo))
                    }
            }.frame(width: data.mainViewWidth/6-20)

            
            HStack{
                Text(worker.work ?? " ")
                .font(.custom("", size:data.show  ? 8:10))
                .foregroundColor(.black)
            }.frame(width: data.mainViewWidth/6)

            
            
            HStack{
                    Image(systemName: "eye")
                        .resizable()
                        .frame(width:data.show ? 6 : 10, height: data.show ? 6 : 10)
                        .foregroundColor(Color(.lightGray))
                        .onTapGesture {
                            data.ShowWorkerDetail = true
                            data.workerDetail = worker
                       }
                
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width:data.show ? 6 : 10, height: data.show ? 6 : 10)
                        .foregroundColor(Color(.green))
                        .onTapGesture {
                            data.workerDetail = worker
                            data.showEditWorker = true
                       }
                

                    Image(systemName: "trash")
                        .resizable()
                        .frame(width:data.show ? 6 : 10, height: data.show ? 6 : 10)
                        .foregroundColor(Color(.red))
                        .onTapGesture {
                            deleteStudent = true

                        }
                        .alert(isPresented: $deleteStudent, content: {
                            Alert(title: Text("Confirm the delection"), message: Text("Are you sure you want to delete \(worker.name!) worker ?"), primaryButton: .destructive(Text("Delete")){
                                let f:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Worker")
                                f.predicate = NSPredicate(format: "name = %@", worker.name!)
                                let fetchReturn = try? moc.fetch(f)
                                let fetchResult = fetchReturn as! [Worker]
                                for object in fetchResult {
                                    moc.delete(object)
                                }
                                do {
                                    try moc.save()
                                }catch{
                                    print(error.localizedDescription)
                                }
                            }, secondaryButton: .cancel())
                        })

            }.frame(width: data.mainViewWidth/6-20)


        }
    }
}
