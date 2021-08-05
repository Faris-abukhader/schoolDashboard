//
//  GradeForTeaceher+CoreDataProperties.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/13.
//
//

import Foundation
import CoreData


extension GradeForTeaceher {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GradeForTeaceher> {
        return NSFetchRequest<GradeForTeaceher>(entityName: "GradeForTeaceher")
    }

    @NSManaged public var grade: String?
    @NSManaged public var gradeToTeacher: Teacher?
    
    public var wrappedGrade:String {
        grade ?? "unknown"
    }


}

extension GradeForTeaceher : Identifiable {

}
