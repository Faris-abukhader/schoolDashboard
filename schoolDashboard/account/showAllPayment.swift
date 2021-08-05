//
//  showAllPayment.swift
//  schoolDashboard
//
//  Created by admin on 2021/5/29.
//

import SwiftUI

struct showAllPayment: View {
    @EnvironmentObject var data:data
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var student:FetchedResults<Student>

    var body: some View {
        VStack(alignment:.center){
            ScrollView{
            
            ForEach(data.studentEdit.feesArray){ i in
                Text("\(i.wrappedFee)").foregroundColor(.white)
            }
            
          




            }.frame(width: data.mainViewWidth/2, height: data.mainViewHeight/4-60)
            .padding(.top)
            Button(action: {data.showAllPayment=false}, label: {
                Text("Close")
                    .foregroundColor(.black)
                    .font(.caption)
                    .padding(.horizontal)
                    .padding(.vertical,5)
                    .background(Color("yellow"))
                    .cornerRadius(10)
            })
            
        }.frame(width: data.mainViewWidth/2, height: data.mainViewHeight/4)
        .background(Color("lightBlue"))
        .cornerRadius(10)
        .padding(.horizontal)

    }
}

struct showAllPayment_Previews: PreviewProvider {
    static var previews: some View {
        showAllPayment()
    }
}
