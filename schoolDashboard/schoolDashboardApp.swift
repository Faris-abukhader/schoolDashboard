//
//  schoolDashboardApp.swift
//  schoolDashboard
//
//  Created by admin on 2021/2/18.
//

import SwiftUI

@main
struct schoolDashboardApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var d = data()
    @State var showSignIn = false
    @State var showAdmin = false
    @State var showTeacher = false
    @State var showStudent = false

    var body: some Scene {
        WindowGroup{

            switch d.page {
            case 1 :
                  signInView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(d)
            case 2 :
                  ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(d)
            case 3 :
                  teacherMainPage()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(d)

                
            case 4 :
                  studentMainPage()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(d)

                
            default:
                signInView()
                  .environment(\.managedObjectContext, persistenceController.container.viewContext)
                  .environmentObject(d)

            }
        }
    }
}
