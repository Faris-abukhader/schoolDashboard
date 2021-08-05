//
//  ExamQuestion+CoreDataProperties.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/25.
//
//

import Foundation
import CoreData


extension ExamQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExamQuestion> {
        return NSFetchRequest<ExamQuestion>(entityName: "ExamQuestion")
    }

    @NSManaged public var correctAnswer: String?
    @NSManaged public var ExamId: Int16
    @NSManaged public var qId: Int16
    @NSManaged public var question: String?
    @NSManaged public var fromExamQuestionToExam: Exam?
    @NSManaged public var fromExamQuestionToQuestions: NSSet?
    @NSManaged public var fromExamQuestionToStudentAnswer: NSSet?
    
    public var wrappedCorrectAnswer : String? {
        correctAnswer
    }
    public var wrappedExamId : Int16 {
        ExamId
    }
    public var wrappedQId : Int16 {
        qId
    }
    public var wrappedQuestion : String? {
        question
    }
    
    public var allQuestions : [Questions] {
        let set = fromExamQuestionToQuestions as? Set<Questions> ?? []
        return set.sorted {
            $0.wrappedId > $1.wrappedId
        }
    }
    
    public var allAnswer : [StudentAnswer] {
        let set = fromExamQuestionToStudentAnswer as? Set<StudentAnswer> ?? []
        return set.sorted {
            $0.wrappedQId > $1.wrappedQId
        }
    }

}

// MARK: Generated accessors for fromExamQuestionToQuestions
extension ExamQuestion {

    @objc(addFromExamQuestionToQuestionsObject:)
    @NSManaged public func addToFromExamQuestionToQuestions(_ value: Questions)

    @objc(removeFromExamQuestionToQuestionsObject:)
    @NSManaged public func removeFromFromExamQuestionToQuestions(_ value: Questions)

    @objc(addFromExamQuestionToQuestions:)
    @NSManaged public func addToFromExamQuestionToQuestions(_ values: NSSet)

    @objc(removeFromExamQuestionToQuestions:)
    @NSManaged public func removeFromFromExamQuestionToQuestions(_ values: NSSet)

}

// MARK: Generated accessors for fromExamQuestionToStudentAnswer
extension ExamQuestion {

    @objc(addFromExamQuestionToStudentAnswerObject:)
    @NSManaged public func addToFromExamQuestionToStudentAnswer(_ value: StudentAnswer)

    @objc(removeFromExamQuestionToStudentAnswerObject:)
    @NSManaged public func removeFromFromExamQuestionToStudentAnswer(_ value: StudentAnswer)

    @objc(addFromExamQuestionToStudentAnswer:)
    @NSManaged public func addToFromExamQuestionToStudentAnswer(_ values: NSSet)

    @objc(removeFromExamQuestionToStudentAnswer:)
    @NSManaged public func removeFromFromExamQuestionToStudentAnswer(_ values: NSSet)

}

extension ExamQuestion : Identifiable {

}
