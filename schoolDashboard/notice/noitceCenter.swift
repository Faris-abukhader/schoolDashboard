//
//  noitceCenter.swift
//  schoolDashboard
//
//  Created by admin on 2021/4/24.
//

import SwiftUI
import CoreData

struct noitceCenter: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var data:data
    @FetchRequest(entity: Notice.entity(), sortDescriptors: []) var notice :FetchedResults<Notice>
    @State var title = ""
    @State var content = ""
    @State var show = false
    @State var date = Date()
    @State var editTitle = ""
    var body: some View {
        ZStack{
        VStack{
            NoticeCenterheader( label: "Notice Center",searchlabel: "Search previous notices")
            ScrollView(showsIndicators: false){
                addnewNotice()
                
                List{
                    ForEach(notice.filter{
                        data.noticeSearchContent.isEmpty ? true : $0.title!.contains(data.noticeSearchContent)
                    }){ note in
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: data.mainViewWidth-50,height: 40)
                                .foregroundColor(Color.white)
                                
                            noticeList(title: note.title ?? "" ,content: note.content ?? "", date: note.date ?? Date())
                            .onTapGesture {
                                show = true
                                content = note.content ?? " "
                                title = note.title ?? " "
                                date = note.date ?? Date()
                                
                            }
                                
                                
                        }
                }
                .onDelete(perform: deleteNotice)

                }
                
               
                .frame(height: 300)
                .cornerRadius(10)
                
                if show {
                    noticeShowView(title: $title, content: $content,date: $date,close:$show)
                }
                
                
                
            }
            
            
            
            
        }
            if data.showEditNoticeView {
                editNoticeView(previousTitle: $data.editNoticeTitle, title: $data.editNoticeTitle, content: $data.editNoticeContent).environmentObject(data)
            }
      }
        .frame(width:data.mainViewWidth-40,height: data.height/1.2)

    }
    func deleteNotice(index :IndexSet){
        withAnimation {
            index.map { notice[$0] }.forEach(moc.delete)

            do {
                try moc.save()
            } catch {
                print(error.localizedDescription)
            }
        }

    }

}
struct noticeList:View{
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
struct noitceCenter_Previews: PreviewProvider {
    static var previews: some View {
        noitceCenter()
    }
}
struct NoticeCenterheader:View{
    @State var label:String
    @State var searchlabel:String
    @State var searchContent=""
    @EnvironmentObject var data:data
    var body: some View{
        HStack{
            Text(label)
                .bold()
                .font(.title3)
            Spacer()
            TextField(searchlabel, text: $data.noticeSearchContent)
                .font(.footnote)
                .frame(width: 120, height: 20)
                .padding(5)
                .background(Color("lightGry"))
                .cornerRadius(15)
            
            Button(action: { }, label: {
                Text("Search")
                    .font(.custom("", size: 8))
                    .foregroundColor(.white)
                    .padding(5)
                    .padding(.horizontal,5)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
            })
        }

    }
}
struct addnewNotice:View{
    @Environment(\.managedObjectContext)  var moc
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) private var teacher:FetchedResults<Student>
    @State var noticeTitle = ""
    @State var noticeContent = ""
    @EnvironmentObject var data:data
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .frame(width: data.mainViewWidth-30, height: 180)
                
        VStack{
            HStack{
                Text("Notice Title :")
                    .font(.caption2)
                TextField("Notice Title...", text: $noticeTitle)
                    .font(.footnote)
                    .padding(5)
                    .background(Color("lightGry"))
                    .cornerRadius(15)
            }.padding(.horizontal)
            .padding(.bottom)
            .padding(.top)
            
            
            HStack{
                Text("Notice Content :")
                    .font(.caption2)
                TextField("Notice Content...", text: $noticeContent)
                    .font(.footnote)
                    .padding(5)
                    .background(Color("lightGry"))
                    .cornerRadius(15)
            }.padding(.horizontal)
            HStack{
                Button(action: {
                    if noticeTitle.count > 0 && noticeContent.count > 0 {
                        let newNotice = Notice(context: moc)
                        newNotice.title = noticeTitle
                        newNotice.content = noticeContent
                        newNotice.date = Date()
                        do {
                            try moc.save()
                        }catch{
                            print(error.localizedDescription)
                        }
                        noticeTitle = ""
                        noticeContent = ""
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
struct noticeShowView:View{
    @Binding var title:String
    @Binding var content:String
    @Binding var date:Date
    @Binding var close:Bool
    @EnvironmentObject var data:data
    var body: some View{
        ZStack(alignment: .topLeading){
            RoundedRectangle(cornerRadius: 10)
                .frame(width:data.mainViewWidth-50)
                .foregroundColor(Color("darkBlue"))
            
            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .padding()
        }
        ZStack(alignment: .topLeading){
            RoundedRectangle(cornerRadius: 10)
                .frame(width:data.mainViewWidth-50,height: UIScreen.main.bounds.height/4)
                .foregroundColor(Color(.lightGray))
            ScrollView{
            VStack(alignment: .leading){
                Text("\(date)")
                    .padding(10)
                    .font(.custom("", size: 8))
                    .foregroundColor(Color(.white))
                Text(content)
                    .foregroundColor(.black)
                    .padding()
                    .frame(width:data.mainViewWidth-60)
                    .lineLimit(20)
            }
          }
        }
        ZStack(alignment:.center){
            Button(action: {close.toggle()}, label: {
                Text("Close")
                    .font(.caption2)
                    .padding(10)
                    .padding(.horizontal,10)
                    .background(Color("darkBlue"))
                    .cornerRadius(15)
            })
        }
    }
}
struct editNoticeView:View{
    @Binding var previousTitle:String
    @Binding var title:String
    @Binding var content:String
    @EnvironmentObject var data:data
    @FetchRequest(entity: Notice.entity(), sortDescriptors: []) var fetch:FetchedResults<Notice>
    @Environment(\.managedObjectContext) var moc
    @State var showAlert = false
    var body: some View{
        ZStack{
            
        
            VStack(alignment: .leading){
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    
                    VStack(alignment: .leading) {
                        
                    Text("Noitce Title :").foregroundColor(.white)
                        TextField("Noitce Title...", text: $title)
                        .font(.footnote)
                        .frame(width: data.mainViewWidth/1.7 - 40, height: 15)
                        .padding(10)
                        .background(Color("darkBlue"))
                        .cornerRadius(10)
                        .padding(.bottom)
                        .foregroundColor(.white)

                    
                    Text("Notice Content :").foregroundColor(.white)
                        TextField("Notice Content...", text: $content)
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
                            let f:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Notice")
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
                            Alert(title: Text("Warning"), message: Text("Make sure that the title of noitce and it's content isn't empty."), dismissButton: Alert.Button.cancel())
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
