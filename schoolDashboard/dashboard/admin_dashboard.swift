//
//  admin_dashboard.swift
//  schoolDashboard
//
//  Created by admin on 2021/2/18.
//

import SwiftUI

struct admin_dashboard: View {
    
    // Screen Component
    
    

    
    // four total view
   var icon = ["person.3.fill","person.2.fill","person.crop.circle.fill.badge.plus","money-bag"]
    var colour = [Color.green,Color.blue,Color.yellow,Color.green]
    var label = ["Students","Teachers","Parents","Total Earnings"]
    var amount = ["50,000","1,000","25,000","$90,000"]
    @EnvironmentObject var data:data
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) private var totalStudent:FetchedResults<Student>
    @FetchRequest(entity: Teacher.entity(), sortDescriptors: []) private var totalTeacher:FetchedResults<Teacher>
    @FetchRequest(entity: Worker.entity(), sortDescriptors: []) private var totalWorker:FetchedResults<Worker>

    var body: some View {
        VStack{
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                
                HStack {
                    TotalView(icon: icon[0], label: label[0], totalAmount: String(totalStudent.count),colour: colour[0]).environmentObject(data)
                    TotalView(icon: icon[1], label: label[1], totalAmount: String(totalTeacher.count),colour: colour[1])
                    
                }
                .padding(.bottom)
                HStack {
                    TotalView(icon: icon[2], label: label[2], totalAmount: String(totalStudent.filter{$0.fatherName!.count > 0}.count + totalStudent.filter{$0.motherName!.count > 0}.count) ,colour: colour[2])
                    TotalViewCustom(icon: icon[3], label: label[3], totalAmount:String(getTotalTeacherFees()),colour: colour[3]).environmentObject(data)

                }
                .padding(.bottom)
            feesCollection().environmentObject(data)
                calenderView()
                HStack{
                    noticeView()
                    Spacer()
                    activiteView()
                }.padding(.horizontal)
                
                
            }
        }
    }
    func getTotalTeacherFees() -> Int{
        var totalFees = 0
        var totalInCome = 0
        for s in totalStudent {
            totalInCome += data.fees[indexOfGrade(grade: s.garde!)]
        }
        for t in totalTeacher {
            totalFees += Int(t.salary)
        }
        for w in totalWorker {
            totalFees += Int(w.salary)
        }
        return  totalInCome - totalFees
    }
    
    func indexOfGrade(grade:String)->Int{
        if grade.contains("First"){
            return 0
        } else if grade.contains("Second"){
            return 1
        } else if grade.contains("Third"){
            return 2
        } else if grade.contains("Fourth"){
            return 3
        } else if grade.contains("Fifth"){
            return 4
        } else if grade.contains("Sixth"){
            return 5
        } else if grade.contains("Seventh"){
            return 6
        } else if grade.contains("Eighth"){
            return 7
        } else if grade.contains("Ninth"){
            return 8
        } else if grade.contains("Tenth"){
            return 9
        }else{
            return 0
        }
    }
}

struct admin_dashboard_Previews: PreviewProvider {
    static var previews: some View {
        admin_dashboard()
    }
}
struct TotalView:View{
    @State var icon:String
    @State var label:String
    @State var totalAmount:String
    @State var colour:Color
    @EnvironmentObject var d:data
    var body: some View{
        HStack{
            VStack{
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(colour)
                Text(label)
                    .frame(width: 120, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .font(.subheadline)
            }.padding(.leading)
            Divider().frame(width: 20, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(totalAmount)
                .font(.footnote)
        }
        .padding(10)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(15)
        .frame(width: (d.mainViewWidth/2), height: d.mainViewHeight/10)
    }
}
struct TotalViewCustom:View{
    @State var icon:String
    @State var label:String
    @State var totalAmount:String
    @State var colour:Color
    @EnvironmentObject var d:data
    var body: some View{
        HStack{
            VStack{
                Image(icon)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(colour)
                Text(label)
                    .frame(width: 150, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .font(.subheadline)
            }
            Divider().frame(width: 20, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text(totalAmount)
                .font(.footnote)
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(15)
        .frame(width: (d.mainViewWidth/2), height: d.mainViewHeight/10)
    }
}
struct feesCollection:View{
    @EnvironmentObject var d:data
    var body: some View{
        VStack{
            HStack{
                // left side
                VStack(alignment:.leading){
                    HStack{
                        Image(systemName: "square.fill")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        VStack(alignment:.leading) {
                            Text("$1000")
                                .font(.footnote)
                            Text("Collections")
                                .font(.caption)
                        }
                    }.padding()
                    HStack{
                        Image(systemName: "square.fill")
                            .foregroundColor(.red)
                        VStack(alignment:.leading) {
                            Text("$8000")
                                .font(.footnote)
                            Text("Fees")
                                .font(.caption)
                        }
                    }.padding()
                    HStack{
                        Image(systemName: "square.fill")
                            .foregroundColor(.yellow)
                        VStack(alignment:.leading) {
                            Text("$3800")
                                .font(.footnote)
                            Text("Expenses")
                                .font(.caption)
                        }

                    }.padding()
                }
             // right side
               Spacer()
                VStack{
                    
                    // chart code
                    ZStack {
                        VStack{
                        Text("12000").font(.caption2)
                        .offset(x:d.show ? -d.mainViewWidth/3.2: -d.mainViewWidth/2.88, y: -68)

                        Text("9000").font(.caption2)
                            .offset(x:d.show ? -d.mainViewWidth/3.2: -d.mainViewWidth/2.88,y: -41)
                        Text("4000").font(.caption2)
                            .offset(x: d.show ? -d.mainViewWidth/3.2: -d.mainViewWidth/2.88, y:-15)
                        Text("2000").font(.caption2)
                            .offset(x: d.show ? -d.mainViewWidth/3.2: -d.mainViewWidth/2.88, y:10)
                        Text("0").font(.caption2)
                            .offset(x: d.show ? -d.mainViewWidth/3.2: -d.mainViewWidth/2.88, y:35)
                        }
                        Path(CGPath(roundedRect: CGRect(x: 1, y: 190, width:d.show ? d.width/1.8:d.width/1.4, height: 0.5), cornerWidth: 5, cornerHeight: 5, transform: nil))
                        Path(CGPath(roundedRect: CGRect(x: 1, y: 150, width: d.show ? d.width/1.8:d.width/1.4, height: 0.5), cornerWidth: 5, cornerHeight: 5, transform: nil))
                        Path(CGPath(roundedRect: CGRect(x: 1, y: 110, width: d.show ? d.width/1.8:d.width/1.4, height: 0.5), cornerWidth: 5, cornerHeight: 5, transform: nil))
                        Path(CGPath(roundedRect: CGRect(x: 1, y: 70, width: d.show ? d.width/1.8:d.width/1.4, height: 0.5), cornerWidth: 5, cornerHeight: 5, transform: nil))
                        Path(CGPath(roundedRect: CGRect(x: 1, y: 30, width: d.show ? d.width/1.8:d.width/1.4, height: 0.5), cornerWidth: 5, cornerHeight: 5, transform: nil))


                        HStack(alignment: .firstTextBaseline) {
                            Image(systemName: "rectangle.portrait.fill")
                                .resizable()
                                .frame(width: 70, height: 150)
                                .cornerRadius(15)
                                .foregroundColor(.blue)
                                .padding(.trailing)
                            
                            Image(systemName: "rectangle.portrait.fill")
                                .resizable()
                                .frame(width: 70, height: 100)
                                .cornerRadius(15)
                                .foregroundColor(.red)
                                .padding(.trailing)

                            
                            
                            Image(systemName: "rectangle.portrait.fill")
                                .resizable()
                                .frame(width: 70, height: 80)
                                .cornerRadius(15)
                                .foregroundColor(.yellow)
                        }



                        
                    }
                    
                }.padding(.trailing)
                
                
                
            }
        }
        .background(Color.white)
        .frame(width: d.mainViewWidth-40, height: d.mainViewHeight/4)
    }
}
struct calenderView:View{
    @State var date = Date()
    var body: some View{
        HStack{
            DatePicker("Event Calender", selection: $date)
            
        }.padding()
        .padding(.horizontal)
    }
}
struct  activiteView:View{
    @EnvironmentObject var d:data
    @State var show = true
    @FetchRequest(entity: Activity.entity(), sortDescriptors: []) var activities:FetchedResults<Activity>
    var body: some View{
        if show {
            VStack(alignment: .leading){
            HStack{
                Text("Activity Board")
                    .padding(.leading)
                    Spacer()
                Button(action: {show.toggle()}, label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.red)
                        .padding(.trailing,5)
                })
            }.padding()
            ScrollView{
                ForEach(activities){ activity in
                    noticeLabel(title: activity.title!, content: activity.content!, date: activity.date!).padding(.leading)
                }
                
            }
        }
        .frame(width: d.mainViewWidth/2.3, height: d.mainViewHeight/2)
        .background(Color.white)
        .cornerRadius(15)
    }
  }
}
struct noticeView:View{
    @EnvironmentObject var d:data
    @FetchRequest(entity: Notice.entity(), sortDescriptors: []) var notice:FetchedResults<Notice>
    @State var show = true
    var body: some View{
        if show {
            VStack(alignment: .leading){
            HStack{
                Text("Noitce Board")
                    .padding(.leading)
                    Spacer()
                Button(action: {show.toggle()}, label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.red)
                        .padding(.trailing,5)
                })
            }.padding()
            ScrollView{
                ForEach(notice){ note in
                    noticeLabel(title: note.title ?? "", content: note.content ?? "", date: note.date ?? Date()).padding(.leading)
                }
                
            }
        }
        .frame(width: d.mainViewWidth/2.3, height: d.mainViewHeight/2)
        .background(Color.white)
        .cornerRadius(15)
    }
  }
}

struct noticeLabel:View{
    @State var title = ""
    @State var content = ""
    @State var date = Date()
    var format :DateFormatter {
        let format = DateFormatter()
        format.dateStyle = .short
        format.timeStyle = .short
        return format
    }
    var body: some View{
        VStack(alignment:.leading){
            Text("\(format.string(from: date))")
                .font(.caption2)
                .foregroundColor(Color(.lightGray))
            Text("Fares abukahder")
                .font(.footnote)
                .foregroundColor(Color("yellow"))
            Text(title)
                .font(.footnote)
                .foregroundColor(Color(.black))
            Text(content)
                .font(.caption)
                .foregroundColor(Color("fontColor"))
        }
        .padding(.bottom)

    }
}
struct studentNumber{
    var fristGradeTotalNum:Int
    var secondGradeTotalNum:Int
    var thirdGradeTotalNum:Int
    var fourthGradeTotalNum:Int
    var fifthGradeTotalNum:Int
    var sixthGradeTotalNum:Int
    var seventhGradeTotalNum:Int
    var eighthGradeTotalNum:Int
    var ninthGradeTotalNum:Int
    var tenthGradeTotalNum:Int
    var data:data
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var student:FetchedResults<Student>
    
    mutating func getTheAmount()  ->Int{
        for s in student {
            if s.garde == "First Grade Section A" || s.garde == "First Grade Section B" || s.garde == "First Grade Section C" {
                fristGradeTotalNum+=1
            }
            if s.garde == "Second Grade Section A" || s.garde == "Second Grade Section B" || s.garde == "Second Grade Section C" {
                secondGradeTotalNum+=1
            }
            if s.garde == "Third Grade Section A" || s.garde == "Third Grade Section B" || s.garde == "Third Grade Section C" {
                thirdGradeTotalNum+=1
            }
            if s.garde == "Fourth Grade Section A" || s.garde == "Fourth Grade Section B" || s.garde == "Fourth Grade Section C" {
                fourthGradeTotalNum+=1
            }
            if s.garde == "Fifth Grade Section A" || s.garde == "Fifth Grade Section B" || s.garde == "Fifth Grade Section C" {
                fifthGradeTotalNum+=1
            }
            if s.garde == "Sixth Grade Section A" || s.garde == "Sixth Grade Section B" || s.garde == "Sixth Grade Section C" {
                sixthGradeTotalNum+=1
            }
            if s.garde == "Seventh Grade Section A" || s.garde == "Seventh Grade Section B" || s.garde == "Seventh Grade Section C" {
                seventhGradeTotalNum+=1
            }
            if s.garde == "Seventh Grade Section A" || s.garde == "Seventh Grade Section B" || s.garde == "Seventh Grade Section C" {
                seventhGradeTotalNum+=1
            }
            if s.garde == "Eighth Grade Section A" || s.garde == "Eighth Grade Section B" || s.garde == "Eighth Grade Section C" {
                eighthGradeTotalNum+=1
            }
            if s.garde == "Ninth Grade Section A" || s.garde == "Ninth Grade Section B" || s.garde == "Ninth Grade Section C" {
                ninthGradeTotalNum+=1
            }
            if s.garde == "Tenth Grade Section A" || s.garde == "Tenth Grade Section B" || s.garde == "Tenth Grade Section C" {
                tenthGradeTotalNum+=1
            }
            
            
            
        }
        return 0

    }

}
