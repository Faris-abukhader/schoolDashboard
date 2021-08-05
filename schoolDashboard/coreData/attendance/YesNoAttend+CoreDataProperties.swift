//
//  YesNoAttend+CoreDataProperties.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/16.
//
//

import Foundation
import CoreData


extension YesNoAttend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<YesNoAttend> {
        return NSFetchRequest<YesNoAttend>(entityName: "YesNoAttend")
    }

    @NSManaged public var doesAttend: Bool
    @NSManaged public var attendId: Int16
    @NSManaged public var studentName: String?
    @NSManaged public var fromDoesAttendToAttendance: Attendance?
    @NSManaged public var fromDoesAttendToStudent: Student?
    
    public var wrappedBool:Int {
        return doesAttend ? 1:0
    }
    public var wrappedAttendId:Int16 {
        attendId
    }
    public var wrappedStudentName:String {
        studentName ?? "unknown"
    }

}

extension YesNoAttend : Identifiable {

}
