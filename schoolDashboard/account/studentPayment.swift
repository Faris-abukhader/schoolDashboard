//
//  studentPayment.swift
//  schoolDashboard
//
//  Created by admin on 2021/2/26.
//

import SwiftUI
import CoreData

struct studentPayment: View {
    @EnvironmentObject var data:data
    @Environment(\.managedObjectContext) var moc
    @State var feesPay = ""
    @State var totalFees = 2000
    @State var restOfFees = 1200
    @State var paymentAmount = ""
    @State var currentDate = Date()
    var dateFormat:DateFormatter{
        let format = DateFormatter()
        format.timeStyle = .short
        format.dateStyle = .short
        return format
    }
    var body: some View {
        VStack(alignment:.leading){
          
            HStack{
                Spacer()
                Text("Total Fees : \(data.studentEdit.totalAmount)")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.top,40)
                Spacer()
            }
            HStack{
                Spacer()
                Text("Rest Of Fees : \( eachGradeFees(grade: data.studentEdit.garde ?? "") - Int(data.studentEdit.totalAmount))")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.bottom,40)
                Spacer()
            }

            
            Text("Payment amount :")
                .font(.footnote)
                .foregroundColor(.white)
                .padding(.leading)

            

            TextField("Payment amount...", text: $paymentAmount)
                .frame(width: data.mainViewWidth/2.2, height: 15)
                .font(.footnote)
                .foregroundColor(.white)
                .padding(.vertical,5)
                .background(Color("darkBlue"))
                .cornerRadius(10)
                .padding(.leading)

            





            Spacer()
            
            HStack{
                Spacer()
                Button(action: {
                    
                    let s:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Student")
                    s.predicate = NSPredicate(format: "id = %@", data.paymentId)
                    do {
                    let fetchReturn = try moc.fetch(s)
                    let studentPayment = fetchReturn[0] as! Student
                    let payment = SubmittedFees(context: moc)
                        payment.belongToStudent = studentPayment
                        payment.mount = Int16(paymentAmount) ?? 0
                        payment.adding = true
                        payment.fee = "\(dateFormat.string(from: currentDate)) + \(paymentAmount)"
                        try moc.save()
                        
                    }catch{
                        print(error.localizedDescription)
                    }

                    
                    data.showStudentPayment = false
                    
                    
                }, label: {
                    Text("done")
                        .foregroundColor(.black)
                        .font(.caption)
                        .padding(.horizontal)
                        .padding(.vertical,10)
                        .background(Color("yellow"))
                        .cornerRadius(10)
                })
                
                Button(action: {data.showStudentPayment=false}, label: {
                    Text("Cancel")
                        .foregroundColor(.black)
                        .font(.caption)
                        .padding(.horizontal)
                        .padding(.vertical,10)
                        .background(Color("yellow"))
                        .cornerRadius(10)
                })
                Spacer()
            }.padding(.bottom,40)




            
        }.frame(width: data.mainViewWidth/2, height: data.mainViewHeight/4)
        .background(Color("lightBlue"))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct studentPayment_Previews: PreviewProvider {
    static var previews: some View {
        studentPayment()
    }
}
