//
//  Questions+CoreDataProperties.swift
//  schoolDashboard
//
//  Created by admin on 2021/6/25.
//
//

import Foundation
import CoreData


extension Questions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Questions> {
        return NSFetchRequest<Questions>(entityName: "Questions")
    }

    @NSManaged public var id: UUID
    @NSManaged public var question: String?
    @NSManaged public var fromQuestionsToExamQuestion: ExamQuestion?
    
    public var wrappedId : UUID {
        id
    }
    public var wrappedQuestion : String? {
        question
    }

}

extension Questions : Identifiable {

}
