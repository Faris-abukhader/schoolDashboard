//
//  Attendance+CoreDataProperties.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/15.
//
//

import Foundation
import CoreData


extension Attendance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attendance> {
        return NSFetchRequest<Attendance>(entityName: "Attendance")
    }

    @NSManaged public var date: Date?
    @NSManaged public var gradeName: String?
    @NSManaged public var teacherName: String?
    @NSManaged public var subject: String?
    @NSManaged public var attendId: Int16
    @NSManaged public var attendToTeacher: Teacher?
    @NSManaged public var fromAttendanceToDoesAttend: NSSet? 
    
    public var wrappedDate:Date {
        date ?? Date()
    }
    
    public var wrappedGrade:String {
        gradeName ?? "unknown Grade"
    }
    
    public var wrappedTeacherName:String {
        teacherName ?? "unknown Teacher"
    }
    
    public var wrappedSubject:String {
        subject ?? "unknown Subject"
    }
    
    public var wrappedAttendId:Int16 {
        attendId
    }
    




    
    public var allAttend:[YesNoAttend] {
       let set = fromAttendanceToDoesAttend as? Set<YesNoAttend> ?? []
        return set.sorted{
            $0.wrappedBool > $1.wrappedBool
        }
        
    }
    public var totalAttend:Int {
        var counter:Int = 0
        for attend in allAttend {
            if attend.doesAttend {
                counter+=1
            }
        }
        return counter
    }
    
    public var totalNonAttend:Int {
        var counter:Int = 0
        for attend in allAttend {
            if !attend.doesAttend {
                counter+=1
            }
        }
        return counter
    }

    
    


}

extension Attendance : Identifiable {

}
