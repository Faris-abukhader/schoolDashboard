//
//  Teacher+CoreDataProperties.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/13.
//
//

import Foundation
import CoreData


extension Teacher {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Teacher> {
        return NSFetchRequest<Teacher>(entityName: "Teacher")
    }

    @NSManaged public var addmissionDate: Date?
    @NSManaged public var address: String?
    @NSManaged public var birthday: String?
    @NSManaged public var birthDay: Int16
    @NSManaged public var birthMonth: Int16
    @NSManaged public var birthYear: Int16
    @NSManaged public var email: String?
    @NSManaged public var experience: String?
    @NSManaged public var gender: Int16
    @NSManaged public var id: Int32
    @NSManaged public var major: String?
    @NSManaged public var name: String?
    @NSManaged public var nationality: String?
    @NSManaged public var phoneNo: Int64
    @NSManaged public var religion: String?
    @NSManaged public var salary: Int16
    @NSManaged public var workId: Int32
    @NSManaged public var teachingGrade: String?
    @NSManaged public var teacherToGrade: NSSet?
    @NSManaged public var teacherToAttend: NSSet?
    
    public var teacherGrades:[GradeForTeaceher]{
        let set = teacherToGrade as? Set<GradeForTeaceher> ?? []
        return set.sorted{
            $0.wrappedGrade > $1.wrappedGrade
        }
    }
    public var teacherAttendances:[Attendence]{
        let set = teacherToAttend as? Set<Attendence> ?? []
        return set.sorted {
            $0.wrappedDate > $1.wrappedDate
        }
    }
    
    public var totalAttend:Int{
        var counter:Int = 0
        if teacherAttendances.doesAttend {
            counter+=1
        }
        return counter
    }

    



}


// MARK: Generated accessors for teacherToGrade
extension Teacher {

    @objc(addTeacherToGradeObject:)
    @NSManaged public func addToTeacherToGrade(_ value: GradeForTeaceher)

    @objc(removeTeacherToGradeObject:)
    @NSManaged public func removeFromTeacherToGrade(_ value: GradeForTeaceher)

    @objc(addTeacherToGrade:)
    @NSManaged public func addToTeacherToGrade(_ values: NSSet)

    @objc(removeTeacherToGrade:)
    @NSManaged public func removeFromTeacherToGrade(_ values: NSSet)

}

extension Teacher : Identifiable {

}
