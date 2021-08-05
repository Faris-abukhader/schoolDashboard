//
//  Student+CoreDataProperties.swift
//  schoolDashboard
//
//  Created by admin on 2021/5/29.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var adderss: String?
    @NSManaged public var addmissionDate: Date?
    @NSManaged public var birthday: String?
    @NSManaged public var birthMonth: Int16
    @NSManaged public var birthYear: Int16
    @NSManaged public var brithDay: Int16
    @NSManaged public var email: String?
    @NSManaged public var fatherAddress: String?
    @NSManaged public var fatherName: String?
    @NSManaged public var fatherNationality: String?
    @NSManaged public var fatherOccupation: String?
    @NSManaged public var fatherPhone: Int64
    @NSManaged public var garde: String?
    @NSManaged public var gender: Int16
    @NSManaged public var id: String?
    @NSManaged public var motherAddress: String?
    @NSManaged public var motherName: String?
    @NSManaged public var motherNationality: String?
    @NSManaged public var motherOccupation: String?
    @NSManaged public var motherPhone: Int64
    @NSManaged public var name: String?
    @NSManaged public var nationality: String?
    @NSManaged public var phoneNo: Int64
    @NSManaged public var religion: String?
    @NSManaged public var studentId: Int16
    @NSManaged public var relationship: NSSet?
    @NSManaged public var fromStudentToDoesAttend: YesNoAttend?
    
    public var feesArray:[SubmittedFees]{
        let set = relationship as? Set<SubmittedFees> ?? []
        return set.sorted{
            $0.wrappedFee > $1.wrappedFee
        }
    }
    
    public var firstFees:String {
        if feesArray.count != 0 {
            return feesArray[0].wrappedFee
        }else {
            return ""
        }
    }
    
    public var totalAmount:Int16 {
        var totalAmount:Int16 = 0
        for f in feesArray {
            totalAmount += f.mount
            
        }
        return totalAmount
    }
    
    


}

// MARK: Generated accessors for relationship
extension Student {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: SubmittedFees)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: SubmittedFees)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}

extension Student : Identifiable {

}
