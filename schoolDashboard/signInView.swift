//
//  signInView.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/11.
//

import SwiftUI
import CoreData

struct signInView: View {
    @State var show = false
    @State var mainWidth = UIScreen.main.bounds.width
    @State var mainHeight = UIScreen.main.bounds.height
    @EnvironmentObject var data:data
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color("darkBlue"),.blue,Color(.cyan),.blue,Color("darkBlue")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea(.all)


            
            VStack{
                Spacer()
                HStack{
                Text("Faris School Managment System")
                    .font(.custom("customFontTwo", size: 30))
                    .foregroundColor(Color.white)
                    .shadow(radius: 1)
                    .offset(x: show ? 0:-mainWidth)
                    .padding(.bottom)
                }
                .shadow(radius: 20)

                
                
                Image("faresLogo")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(80)
                    .shadow(color: Color(.cyan), radius: 20, x: 0, y: 0)
                    .offset(x: show ? 0:mainWidth)
                
                Spacer()

                signInStruct()
                    .offset(y: show ? 0:mainHeight)
                    .padding(.top,-100)

                Spacer()

                    
            }
            


           
            
        }.colorScheme(.light)
        .background(LinearGradient(gradient: Gradient(colors: [.blue,.blue,.red]), startPoint: .top, endPoint: .bottomTrailing)
)
        .onAppear{
            withAnimation(.spring(response: 2, dampingFraction: 1.4, blendDuration: 1.4)){
                show.toggle()
            }
        }
    }
}

struct signInView_Previews: PreviewProvider {
    static var previews: some View {
        signInView()
    }
}

struct signInStruct:View{
    @EnvironmentObject var data:data
    @State var username = ""
    @State var password = ""
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) private var students:FetchedResults<Student>
    @FetchRequest(entity: Teacher.entity(), sortDescriptors: []) private var teachers:FetchedResults<Teacher>
    var body: some View{
        ZStack{
            
            Rectangle()
                .frame(width: data.width/2, height: data.height/3)
                .foregroundColor(Color("darkBlue"))
                .cornerRadius(10)
                .shadow(color: Color(.cyan), radius: 20, x: 0, y: 0)
            
            Rectangle()
                .frame(width: data.width/2, height: data.height/9)
                .foregroundColor(Color("yellow"))
                .cornerRadius(10)
                .offset(y: -data.height/11)

            
            VStack{
                Spacer()
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.white)
                Spacer()
                HStack{
                    Text("Username :")
                        .foregroundColor(.white)
                        .padding(.leading)
                    TextField("username...", text: $username)
                        .font(.caption)
                        .foregroundColor(.white)
                        .frame(width: data.width/4)
                        .padding(.horizontal,10)
                        .padding(.vertical,4)
                        .background(Color("blueColor2"))
                        .cornerRadius(10)
                }.padding(.bottom)
                
                HStack{
                    Text("Password : ")
                        .foregroundColor(.white)
                        .padding(.leading)
                    TextField("password...", text: $password)
                        .font(.caption)
                        .foregroundColor(.white)
                        .frame(width: data.width/4)
                        .padding(.horizontal,10)
                        .padding(.vertical,4)
                        .background(Color("blueColor2"))
                        .cornerRadius(10)
                }
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        
                        if username == "Admin" && password == "12345" {
                            data.username = username
                            data.page = 2
                            data.pageIndex = 1
                        } else if isTeacher(name: username) && password == "12345" {
                            data.username = username
                            data.page = 3
                            data.pageIndex = 11
                        } else if isStudent(name: username) && password == "12345" {
                            data.username = username
                            data.page = 4
                            data.pageIndex = 111

                        }

                        
                    }, label: {
                        Text("Sign in")
                            .foregroundColor(.white)
                            .padding(10)
                            .padding(.horizontal,10)
                            .background(Color("blueColor1"))
                            .cornerRadius(15)
                            .shadow(radius: 3)
                    })
                    Spacer()
                    Button(action: {
                        password = ""
                        username = ""
                        data.shake.toggle()
                    }, label: {
                        Text("Reset")
                            .foregroundColor(.white)
                            .padding(10)
                            .padding(.horizontal,10)
                            .background(Color("blueColor1"))
                            .cornerRadius(15)
                            .shadow(radius: 3)
                    })
                    Spacer()
                }
                Spacer()

            }
            
        }.frame(width: data.width/2, height: data.height/3)

    }
    
    func isTeacher(name:String)->Bool {
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Teacher")
        fetch.predicate = NSPredicate.init(format: "name = %@", name)
            if try! moc.fetch(fetch).count > 0 {
                return true
            }else {
                return false
            }
    }
    
    func isStudent(name:String)->Bool {
        let fetch:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Student")
        fetch.predicate = NSPredicate.init(format: "name = %@", name)
            if try! moc.fetch(fetch).count > 0 {
                return true
            }else {
                return false
            }
    }

}
