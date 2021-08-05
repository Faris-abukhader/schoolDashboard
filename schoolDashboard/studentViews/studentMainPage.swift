//
//  studentMainPage.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/15.
//

import SwiftUI
import CoreData

struct studentMainPage: View {
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
    @State var leftListHeadTitle = ["Main","Attendance","Homework","Exam","Notice"]
    @State var leftListHeadTitleIcon = ["cursorarrow.and.square.on.square.dashed","person.3.fill","person.2.fill","person.2.fill","person.fill.badge.plus","books.vertical","latch.2.case.fill","tablecells.badge.ellipsis","plus.rectangle.fill.on.rectangle.fill","pencil.and.outline","text.book.closed","rectangle.and.pencil.and.ellipsis","car.fill","building.2.fill","note.text","message.circle.fill","rectangle.grid.2x2.fill","person.crop.circle"]

    @State var showLeftList = true
    @State var offsetX:CGFloat = .zero
    @State var value:CGFloat = .zero
//    @State var show = true
    
    
    
    @EnvironmentObject var data:data
    
    
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
             MainLeftListItem1(headTitle: leftListHeadTitle[0], icon: leftListHeadTitleIcon[0],isTeacher: false).padding(.vertical,-3)
             MainLeftListItem1(headTitle: leftListHeadTitle[1], icon: leftListHeadTitleIcon[1],isTeacher: false).padding(.vertical,-3)
             MainLeftListItem1(headTitle: leftListHeadTitle[2], icon: leftListHeadTitleIcon[2],isTeacher: false).padding(.vertical,-3)
             MainLeftListItem1(headTitle: leftListHeadTitle[3], icon: leftListHeadTitleIcon[3],isTeacher: false).padding(.vertical,-3)

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
                         upperHeader1()
                            .background(Color(.blue))
                         

                     
                     
                     
                     // this is scroll view for main View
                     ZStack(alignment: .topTrailing) {
                     whichView2(index: data.pageIndex).environmentObject(data).padding()
                                         .frame(width: data.mainViewWidth, height: height - height/15)
                                         .background(Color("background"))
                         
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
}

func whichView2(index:Int) -> AnyView {
    switch (index){
    case 111 : return AnyView(studentMain())
    case 222 : return AnyView(studentAttendance())
    case 333 : return AnyView(studentExamWindow())
    default :
        print ("no avialable index")
        return AnyView(studentMain())
        
    }
}


struct studentMainPage_Previews: PreviewProvider {
    static var previews: some View {
        studentMainPage()
    }
}
