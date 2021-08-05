//
//  StudentAnswer+CoreDataProperties.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/25.
//
//

import Foundation
import CoreData


extension StudentAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudentAnswer> {
        return NSFetchRequest<StudentAnswer>(entityName: "StudentAnswer")
    }

    @NSManaged public var studentName: String?
    @NSManaged public var qId: UUID
    @NSManaged public var stringAnswer: String?
    @NSManaged public var startAnsweringDate : Date?
    @NSManaged public var answer: Int16
    @NSManaged public var fromStudentAnswerToExamQuestion: ExamQuestion?
    @NSManaged public var fromStudentAnswerToExam: Exam?
    
    public var wrappedStudentName : String {
        studentName ?? "unknown Student"
    }
    public var wrappedQId : UUID {
        qId
    }
    public var wrappedAnswer : Int16 {
        answer 
    }

}

extension StudentAnswer : Identifiable {

}
