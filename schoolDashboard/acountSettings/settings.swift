//
//  settings.swift
//  schoolDashboard
//
//  Created by admin on 2021/5/3.
//

import SwiftUI

struct settings: View {
    var body: some View {
        
        VStack{
            ScrollView(showsIndicators: false){
                feesView()
                
            }
        }
        
    }
}

struct settings_Previews: PreviewProvider {
    static var previews: some View {
        settings()
    }
}
struct feesView:View{
    @EnvironmentObject var data:data
    var body: some View{
        VStack{
            HStack{
                Text("First Grade :")
                TextField("annual installment", value: $data.firstGradeFees,formatter:NumberFormatter())
                    .keyboardType(.phonePad)
                
            }
            HStack{
                Text("Second Grade :")
                TextField("annual installment", value: $data.secondGradeFees,formatter:NumberFormatter())
                    .keyboardType(.phonePad)
            }

            HStack{
                Text("third Grade :")
                TextField("annual installment", value: $data.thirdGradeFees,formatter:NumberFormatter())
                    .keyboardType(.phonePad)
            }

            HStack{
                Text("Fourth Grade :")
                TextField("annual installment", value: $data.fourthGradeFees,formatter:NumberFormatter())
                    .keyboardType(.phonePad)
            }

            HStack{
                Text("Fifth Grade :")
                TextField("annual installment", value: $data.fifthGradeFees,formatter:NumberFormatter())
                    .keyboardType(.phonePad)
            }

            HStack{
                Text("Sixth Grade :")
                TextField("annual installment", value: $data.sixthGradeFees,formatter:NumberFormatter())
                    .keyboardType(.phonePad)
            }

            HStack{
                Text("Seventh Grade :")
                TextField("annual installment", value: $data.seventhGradeFees,formatter:NumberFormatter())
                    .keyboardType(.phonePad)
            }

            HStack{
                Text("eighth Grade :")
                TextField("annual installment", value: $data.eighthGradeFees,formatter:NumberFormatter())
                    .keyboardType(.phonePad)
            }

            HStack{
                Text("Ninth Grade :")
                TextField("annual installment", value: $data.ninthGradeFees,formatter:NumberFormatter())
                    .keyboardType(.phonePad)
            }

            HStack{
                Text("Tenth Grade :")
                TextField("annual installment", value: $data.tenthGradeFees,formatter:NumberFormatter())
                    .keyboardType(.phonePad)
            }

        }

    }
}
