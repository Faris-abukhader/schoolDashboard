//
//  activityCenter.swift
//  schoolDashboard
//
//  Created by admin on 2021/7/30.
//

import SwiftUI
import CoreData

struct activityCenter: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var data:data
    @FetchRequest(entity: Activity.entity(), sortDescriptors: []) var activities :FetchedResults<Activity>
    @State var title = ""
    @State var content = ""
    @State var show = false
    @State var date = Date()
    @State var editTitle = ""
    var body: some View {
        ZStack{
        VStack{
            NoticeCenterheader( label: "Activity Center",searchlabel: "Search previous activities")
            ScrollView(showsIndicators: false){
                addnewActivities()
                
                List{
                    ForEach(activities.filter{
                        data.noticeSearchContent.isEmpty ? true : $0.title!.contains(data.noticeSearchContent)
                    }){ note in
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: data.mainViewWidth-50,height: 40)
                                .foregroundColor(Color.white)
                                
                            activityList(title: note.title ?? "" ,content: note.content ?? "", date: note.date ?? Date())
                            .onTapGesture {
                                show = true
                                content = note.content ?? " "
                                title = note.title ?? " "
                                date = note.date ?? Date()
                                
                            }
                                
                                
                        }
                }
                .onDelete(perform: deleteActivity)

                }
                
               
                .frame(height: 300)
                .cornerRadius(10)
                
                if show {
                    noticeShowView(title: $title, content: $content,date: $date,close:$show)
                }
                
                
                
            }
            
            
            
            
        }
            if data.showEditNoticeView {
                editAcitivtyView(previousTitle: $data.editNoticeTitle, title: $data.editNoticeTitle, content: $data.editNoticeContent).environmentObject(data)
            }
      }
        .frame(width:data.mainViewWidth-40,height: data.height/1.2)

    }
    func deleteActivity(index :IndexSet){
        withAnimation {
            index.map { activities[$0] }.forEach(moc.delete)

            do {
                try moc.save()
            } catch {
                print(error.localizedDescription)
            }
        }

    }

}

struct activityCenter_Previews: PreviewProvider {
    static var previews: some View {
        activityCenter()
    }
}

struct activityList:View{
    @State var title = ""
    @State var content = ""
    @State var date = Date()
    @EnvironmentObject var data:data
    var body: some View{
        HStack(alignment:.firstTextBaseline){
            Text(title)
                .padding(.leading)
            Spacer()
            Text("\(date)")
                    .padding(.trailing)
                .font(.caption2)
                .foregroundColor(Color("fontColor"))
           
                Image("edit")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.trailing)
            .onTapGesture {
                    data.showEditNoticeView.toggle()
                    data.editNoticeTitle = title
                    data.editNoticeContent = content
                    data.editNoticeDate = date
            }
            }
    }
}
struct addnewActivities:View{
    @Environment(\.managedObjectContext)  var moc
    @State var activityTitle = ""
    @State var activityContent = ""
    @EnvironmentObject var data:data
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .frame(width: data.mainViewWidth-30, height: 180)
                
        VStack{
            HStack{
                Text("Activity Title :")
                    .font(.caption2)
                TextField("Activity Title...", text: $activityTitle)
                    .font(.footnote)
                    .padding(5)
                    .background(Color("lightGry"))
                    .cornerRadius(15)
            }.padding(.horizontal)
            .padding(.bottom)
            .padding(.top)
            
            
            HStack{
                Text("Activity Content :")
                    .font(.caption2)
                TextField("Activity Content...", text: $activityContent)
                    .font(.footnote)
                    .padding(5)
                    .background(Color("lightGry"))
                    .cornerRadius(15)
            }.padding(.horizontal)
            HStack{
                Button(action: {
                    if activityTitle.count > 0 && activityContent.count > 0 {
                        let newActivity = Activity(context: moc)
                        newActivity.title = activityTitle
                        newActivity.content = activityContent
                        newActivity.date = Date()
                        do {
                            try moc.save()
                        }catch{
                            print(error.localizedDescription)
                        }
                        activityTitle = ""
                        activityContent = ""
                    }
                }, label: {
                    Text("Done")
                        .font(.caption2)
                        .padding(10)
                        .padding(.horizontal,10)
                        .background(Color("darkBlue").opacity(0.7))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                })
            }.padding(.bottom,40)
          }
        }
    }
}
struct editAcitivtyView:View{
    @Binding var previousTitle:String
    @Binding var title:String
    @Binding var content:String
    @EnvironmentObject var data:data
    @FetchRequest(entity: Activity.entity(), sortDescriptors: []) var fetch:FetchedResults<Activity>
    @Environment(\.managedObjectContext) var moc
    @State var showAlert = false
    var body: some View{
        ZStack{
            
        
            VStack(alignment: .leading){
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    
                    VStack(alignment: .leading) {
                        
                    Text("Activity Title :").foregroundColor(.white)
                        TextField("Activity Title...", text: $title)
                        .font(.footnote)
                        .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                        .padding(10)
                        .background(Color("darkBlue"))
                        .cornerRadius(10)
                        .padding(.bottom)
                        .foregroundColor(.white)

                    
                    Text("Activity Content :").foregroundColor(.white)
                        TextField("Activity Content...", text: $content)
                        .font(.footnote)
                        .frame(width: data.mainViewWidth/1.7 - 40, height: 200)
                        .lineLimit(20)
                        .padding(10)
                        .background(Color("darkBlue"))
                        .cornerRadius(10)
                        .padding(.bottom)
                        .foregroundColor(.white)


                        
                }
                    ZStack(alignment: .center){
                        HStack{
                            Spacer()
                        Button(action: {

                            if title.isEmpty || content.isEmpty {
                                showAlert = true
                            }else{
                            let f:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Activity")
                                f.predicate = NSPredicate(format: "date = %@", data.editNoticeDate as CVarArg)
                                do {
                            let fetchReturn = try moc.fetch(f)
                            let newNotice = fetchReturn[0] as! NSManagedObject
                                newNotice.setValue(title, forKey: "title")
                                newNotice.setValue(content, forKey: "content")
                                do {
                                    try moc.save()
                                }catch {
                                    print(error.localizedDescription)
                                }

                            }catch{
                                print(error.localizedDescription)
                            }
                            data.showEditNoticeView = false
                            
                          }
                        }, label: {
                            Text("Done")
                                .padding(10)
                                .padding(.horizontal,10)
                                .background(Color("yellow"))
                                .cornerRadius(15)
                                .foregroundColor(.white)
                            
                                
                        })
                        .alert(isPresented: $showAlert, content: {
                            Alert(title: Text("Warning"), message: Text("Make sure that the title of activity and it's content isn't empty."), dismissButton: Alert.Button.cancel())
                        })
                            Spacer()
                            Button(action: {data.showEditNoticeView=false}, label: {
                                Text("Cancel")
                                    .padding(10)
                                    .padding(.horizontal,10)
                                    .background(Color("yellow"))
                                    .cornerRadius(15)
                                    .foregroundColor(.white)
                            })
                            Spacer()
                     }
                    }
                
                }
            }.padding()
            
            
        }.frame(width: data.mainViewWidth/1.7, height: data.mainViewHeight/4)
        .background(Color("lightBlue"))
        .cornerRadius(10)
        .shadow(radius: 2)
        Button(action: {data.showEditNoticeView = false}, label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color("darkBlue"))
        })
        .offset(x: data.mainViewWidth/3, y: -data.mainViewHeight/6)

    }
}

