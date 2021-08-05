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
    @NSManaged public var examId: UUID
    @NSManaged public var qId: UUID
    @NSManaged public var question: String?
    @NSManaged public var fromExamQuestionToExam: Exam?
    @NSManaged public var fromExamQuestionToQuestions: NSSet?
    @NSManaged public var fromExamQuestionToStudentAnswer: StudentAnswer?
    
    
    public var wrappedCorrectAnswer : String? {
        correctAnswer
    }
    public var wrappedExamId : UUID {
        examId
    }
    public var wrappedQId : UUID {
        qId
    }
    public var wrappedQuestion : String? {
        question
    }
    
    public var allQuestions : [Questions] {
        let set = fromExamQuestionToQuestions as? Set<Questions> ?? []
        return set.sorted {
            $0.wrappedQuestion! > $1.wrappedQuestion!
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
