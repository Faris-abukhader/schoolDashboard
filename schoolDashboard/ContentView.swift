//  ContentView.swift
//  schoolDashboard
//  Created by admin on 2021/2/18.
import SwiftUI
import CoreData

struct ContentView: View {
    // core data component
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    
    // Screen Component
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    
    
    // left side list combonent
    @State var leftListHeadTitle = ["Dashboard","Students","Teachers","Worker","Parents","Account","Class","Attendance","Exam","Notice","Activity","Message","UI ELements","Account Settings"]
    @State var leftListHeadTitleIcon = ["cursorarrow.and.square.on.square.dashed","person.3.fill","person.2.fill","person.2.fill","person.fill.badge.plus","books.vertical","latch.2.case.fill","tablecells.badge.ellipsis","pencil.and.outline","text.book.closed","rectangle.and.pencil.and.ellipsis","car.fill","building.2.fill","note.text","message.circle.fill","rectangle.grid.2x2.fill","person.crop.circle"]
    @State var showLeftList = true
    var Dashboarditem = [""]
    var Studentitem = [""]
    var Taecheritem = [""]
    var Parentsitem = [""]
    var Acountitem  = [""]
    var classitem = [""]
    var attendance = [""]
    var examitem = [""]
    var noticeitem = [""]
    var messageitem = [""]
    var accountSettingsitem = [""]
    @State var offsetX:CGFloat = .zero
    @State var value:CGFloat = .zero
    @EnvironmentObject var data:data
    @StateObject var chartData = sharingData()
    let time = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var showToast = false
    @State var toastTime = 3
    var body: some View {
       
        // main Stack
        ZStack(alignment:.leading ) {
            

            

            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0){
                                
                // represent the left side for the list
                ZStack {
                    VStack{
                 ScrollView{
                    Image("faresLogo")
                        .resizable()
                        .frame(width: 140, height: 140)
                        .padding(.top)
                    VStack{
                MainLeftListItem(headTitle:"Dashboard",item: Dashboarditem,icon: leftListHeadTitleIcon[0]).padding(.vertical,-3)
                MainLeftListItem(headTitle:"Student",item: Studentitem,icon: leftListHeadTitleIcon[1]).padding(.vertical,-3)
                MainLeftListItem(headTitle:"Teachers",item: Taecheritem,icon: leftListHeadTitleIcon[2]).padding(.vertical,-3)
                MainLeftListItem(headTitle:"Parents",item: Parentsitem,icon: leftListHeadTitleIcon[3]).padding(.vertical,-3)
                MainLeftListItem(headTitle:"Worker",item: Parentsitem,icon: leftListHeadTitleIcon[4]).padding(.vertical,-3)
                MainLeftListItem(headTitle:"Account",item: Acountitem,icon: leftListHeadTitleIcon[5]).padding(.vertical,-3)
                MainLeftListItem(headTitle:"Class",item: classitem,icon: leftListHeadTitleIcon[6]).padding(.vertical,-3)
                    }
                    VStack{
                MainLeftListItem(headTitle:"Attendance",item: attendance,icon: leftListHeadTitleIcon[9]).padding(.vertical,-3)
                MainLeftListItem(headTitle:"Exam",item: examitem,icon: leftListHeadTitleIcon[10]).padding(.vertical,-3)
                    }
                    VStack{
                    MainLeftListItem(headTitle:"Notice",item: noticeitem,icon: leftListHeadTitleIcon[13]).padding(.vertical,-3)
                        MainLeftListItem(headTitle:"Activity",item: noticeitem,icon: leftListHeadTitleIcon[14]).padding(.vertical,-3)
                    MainLeftListItem(headTitle:"Message",item: messageitem,icon: leftListHeadTitleIcon[15]).padding(.vertical,-3)
                    MainLeftListItem(headTitle:"Account Settings",item: accountSettingsitem,icon: leftListHeadTitleIcon[16]).padding(.vertical,-3)

                    }
                    Spacer()
                }
               }.frame(width: width/5, height: height)
               .background(Color("lightBlue"))
               .ignoresSafeArea(.all)
                    
                }
                .offset(x: data.show ? 0:-data.mainViewWidth/10)
                

                
                VStack(alignment: .leading){
                    
                    // represent the upper list
                        upperHeader()
                           .background(Color(.blue))

                    
                    
                    // this is scroll view for main View
                    
                    ZStack(alignment: .topTrailing){
                    whichView(index: data.pageIndex).environmentObject(data).padding()
                                        .frame(width: data.mainViewWidth, height: height - height/15)
                                        .background(Color("background"))
                                        .environmentObject(chartData)
                    
                        
                        if data.showSignoutList {
                                Button(action: {
                                    data.page = 1
                                    data.username = ""
                                    data.password = ""
                                    data.showSignoutList = false
                                    
                                }, label: {
                                    HStack{
                                        Image(systemName: "person.crop.circle.badge.minus")
                                            .foregroundColor(Color(.darkGray))
                                        Text("Sign out")
                                            .font(.caption2)
                                            .foregroundColor(Color(.darkGray))
                                    }
                                })
                                .frame(width: data.width/4.4, height: 40)
                                .background(Color.white)
                                .cornerRadius(5)
                                .offset(y:-5)
                      }


                    }
                    Spacer()
                }
                .padding(.top)
                .frame(width: data.mainViewWidth, height: height)
                .offset(x: data.show ? 0:-data.mainViewWidth/10)
                    
                    
                
                
                
            }

            
            if !data.show {
            Button(action: {
                data.mainViewWidth =  UIScreen.main.bounds.width - UIScreen.main.bounds.width/5
                offsetX = .zero
                data.show.toggle()
            }, label: {
                Image(systemName: "line.horizontal.3")
                    .foregroundColor(Color("yellow"))
                    .padding(10)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
            })
            .offset(x: 70,y:-height/2.3)
            }
            
            if data.show {
            Button(action: {
                    data.mainViewWidth =  data.width
                    offsetX = -data.width/12.2

                data.show.toggle()
            }, label: {
                Image(systemName: "line.horizontal.3")
                    .foregroundColor(Color("yellow"))
                    .padding(10)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
            })
            .offset(x: 130,y:-height/2.3)
            }


            
            
            // Toast View
            Button(action: {data.showToast=false}, label: {
            ZStack{
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width/2, height: 40)
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 1)
                    .blur(radius: 0.7)
                Text(data.toastContent)
                    .bold()
                    .foregroundColor(Color.black)
            }
            
                })
                .onReceive(time){ s in
                if toastTime == 0 {
                    data.showToast = false
                    toastTime = 3
                } else {
                    toastTime -= 1
                }
            }
                .animation(.linear)
                .offset(x:UIScreen.main.bounds.width/3,y:data.showToast ? UIScreen.main.bounds.height/2 - 50:UIScreen.main.bounds.height)

        
               

        }.preferredColorScheme(.light)
        
        
        
        // to deal with keyboard when it open and close and the layout for the screen
        
        .padding(.top,self.value)
        .animation(.spring()).onAppear{
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main){(noti)in
                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                self.value = height
            }
            
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){(noti)in
                self.value = 0
            }
            
            
        }
    }
    

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                print(nsError.localizedDescription)
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
func whichView(index:Int) -> AnyView {
    switch (index){
    case 1 : return AnyView(admin_dashboard())
    case 2 : return AnyView(allStudent())
    case 3 : return AnyView(allTeacher())
    case 4 : return AnyView(allFees())
    case 5 : return AnyView(allTeacher())
    case 6 : return AnyView(teacherDetails())
    case 7 : return AnyView(addTeacher())
    case 8 : return AnyView(allParents())
    case 9 : return AnyView(allFees())
    case 10 : return AnyView(allClasses())
    case 11: return AnyView(noitceCenter())
    case 12 :return AnyView(settings())
    case 13:return AnyView(allWorker())
    case 14 :return AnyView(attendanceMainView())
    case 15 :return AnyView(examMainWindow())
    case 16 :return AnyView(activityCenter())
        

    
    
    default :
        print ("no avialable index")
        return AnyView(ContentView())
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


 // left side list total 16 iclude sublist over down
struct MainLeftListItem:View{
    @State var headTitle:String
    @State var item:[String]
    @State var icon:String
    @State var show = false
    @EnvironmentObject var data:data
    var body: some View{
        VStack{
            Button(action: {
                    show.toggle()
                if headTitle == "Dashboard" {
                    data.pageIndex = 1
                }
                if headTitle=="Student"{
                    data.pageIndex = 2
                }
                if headTitle=="Teachers"{
                    data.pageIndex = 3
                }
                if headTitle=="Account"{
                    data.pageIndex = 4
                }
                if headTitle == "Parents" {
                    data.pageIndex = 8
                }
                if headTitle == "Class" {
                    data.pageIndex = 10
                }
                if headTitle == "Notice" {
                    data.pageIndex = 11
                }
                if headTitle=="Account Settings"{
                    data.pageIndex = 12
                }
                if headTitle=="Worker"{
                    data.pageIndex = 13
                }
                if headTitle ==  "Attendance" {
                    data.pageIndex = 14
                }
                if headTitle == "Exam" {
                    data.pageIndex = 15
                }
                if headTitle == "Activity" {
                    data.pageIndex = 16
                }
                
                
            }, label: {
                HStack{
                    Image(systemName: icon)
                        .resizable()
                        .frame(width: 12, height: 12, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color("yellow"))
                    Text(headTitle)
                        .foregroundColor(.white)
                        .font(.custom("D", size: 14))
                    Spacer()
                    Image(systemName:  show && item.count != 1 ?  "chevron.down":"chevron.right")
                        .resizable()
                        .frame(width:  show && item.count != 1 ? 8:5, height:show && item.count != 1 ? 5: 8)
                        .foregroundColor(show ? Color("yellow"):.white)
                        .padding(.trailing)
                }.padding()
                
            }).background(Color("lightBlue"))
            if show && item.count != 1 {

                ForEach(0..<item.count){ i in
                    VStack(alignment: .leading){
                    leftSubList(label: item[i])
                        .padding(.vertical,-5)
                    }
                }

            }
            
        }
        .padding(.vertical,-4)
    }
    
}

// sublit for left side list
struct leftSubList:View{
    @State var label:String
    @State var clicked = false
    @EnvironmentObject var data:data
    var body: some View{
        HStack(alignment: .center){
            Button(action: {
                clicked.toggle()
                if label=="Admin  "{
                    data.pageIndex = 1
                }
                if label=="All Students"{
                    data.pageIndex = 2
                }
                if label=="Student Details"{
                    data.pageIndex = 3
                }
                if label=="Add Student"{
                    data.pageIndex = 4
                }
                if label=="All Teachers"{
                    data.pageIndex = 5
                }
                if label=="Teacher Details"{
                    data.pageIndex = 6
                }
                if label=="Add Teacher"{
                    data.pageIndex = 7
                }
                if label=="Fees Collection"{
                    data.pageIndex = 9
                }


            }, label: {
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 5, height: 8)
                    .foregroundColor(.white)
                Text(label)
                    .font(.custom("D", size: 14))
                    .padding(.leading,10)
                    .foregroundColor(.white)
            })
            Spacer()
        }
        .padding()
        .background(Color("darkBlue"))
    }
}
struct upperHeader:View{
    @State var searchContent = ""
    @EnvironmentObject var d:data
    var body: some View{
        HStack{
            Text("Welcome , Admin")
                .font(.subheadline)
                .foregroundColor(Color("fontColor"))
                .shadow(radius: 0.1)
                .padding(.leading,5)
            Spacer()
            
            ZStack {
                TextField("Search here", text: $searchContent)
                    .font(.caption2)
                    .frame(width: 120, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(5)
                    .background(Color(.lightGray))
                    .cornerRadius(20)
                    .padding(5)
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color(.darkGray))
                    .offset(x: 50)
                
            }
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "globe")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color(.darkGray))
                    .padding(5)
                    .background(Color(.lightGray))
                    .cornerRadius(50)
                Text("English")
                    .font(.custom("", size: 10))
                    .foregroundColor(Color(.darkGray))
                Image(systemName: "chevron.down")
                    .resizable()
                    .frame(width: 6, height: 4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(.darkGray))

            })
            Divider()
                .frame(width: 10, height: 20)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "envelope.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.lightGray))
            })
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "bell.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.lightGray))
            })
            
            Divider()
                .frame(width: 10, height: 20)


            Button(action: {d.showSignoutList.toggle()}, label: {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.lightGray))
                VStack(alignment:.leading){
                    Text("Fares abukhader")
                        .frame(width: 90, height: 15, alignment: .leading)
                        .foregroundColor(.black)
                        .font(.system(.caption2))
                        .lineLimit(1)
                    Text("Admin")
                        .foregroundColor(Color(.darkGray))
                        .font(.custom("", size: 10))
                }
                Image(systemName: "chevron.down")
                    .resizable()
                    .frame(width: 10, height: 6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(.darkGray))
                    .padding(.leading,10)
                    .padding(.trailing)
                    
            })
        }
        .background(Color(.white))

    }
}
