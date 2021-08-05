//
//  TestView.swift
//  schoolDashboard
//
//  Created by admin on 2021/2/21.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var data:data
    @State var Fname  = ""
    @State var names = ["fares","raed","obada"]
    let width  = 400
    let height = 600
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                Text("first name :").foregroundColor(Color.white).padding(.leading,5)
                    TextField("frist name...", text: $Fname)
                        .font(.footnote)
                        .frame(width: CGFloat(width) - 40, height: 15)
                        .padding(10)
                        .background(Color("darkBlue"))
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .padding(.bottom)
                        .padding(.leading,5)
                
                Picker("name", selection: $names, content: {})
                

            }
            
        }
        .frame(width: CGFloat(width) , height: CGFloat(height))
        .background(Color("lightBlue"))
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
