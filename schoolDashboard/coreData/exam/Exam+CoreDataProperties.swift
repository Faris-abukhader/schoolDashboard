//
//  Exam+CoreDataProperties.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/25.
//
//

import Foundation
import CoreData


extension Exam {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exam> {
        return NSFetchRequest<Exam>(entityName: "Exam")
    }

    @NSManaged public var examDate: Date?
    @NSManaged public var examDuration:Int16
    @NSManaged public var examEndTime:Date?
    @NSManaged public var examName: String?
    @NSManaged public var examStartTime:Date?
    @NSManaged public var gradeName: String?
    @NSManaged public var teacherName: String?
    @NSManaged public var id: UUID
    @NSManaged public var fromExamToExamQuestion: NSSet?
    @NSManaged public var fromExamToStudentAnswer: NSSet?
    
    public var allQuestion : [ExamQuestion] {
        let set = fromExamToExamQuestion as? Set<ExamQuestion> ?? []
        return set.sorted {
            $0.wrappedCorrectAnswer! > $1.wrappedCorrectAnswer!
        }
    }
    public var allAnswer : [StudentAnswer] {
        let set = fromExamToStudentAnswer as? Set<StudentAnswer> ?? []
        return set.sorted{
            $0.wrappedStudentName > $1.wrappedStudentName
        }
    }

}

// MARK: Generated accessors for fromExamToExamQuestion
extension Exam {

    @objc(addFromExamToExamQuestionObject:)
    @NSManaged public func addToFromExamToExamQuestion(_ value: ExamQuestion)

    @objc(removeFromExamToExamQuestionObject:)
    @NSManaged public func removeFromFromExamToExamQuestion(_ value: ExamQuestion)

    @objc(addFromExamToExamQuestion:)
    @NSManaged public func addToFromExamToExamQuestion(_ values: NSSet)

    @objc(removeFromExamToExamQuestion:)
    @NSManaged public func removeFromFromExamToExamQuestion(_ values: NSSet)

}

extension Exam : Identifiable {

}
