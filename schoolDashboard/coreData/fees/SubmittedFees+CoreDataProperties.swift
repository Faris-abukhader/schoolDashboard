//
//  SubmittedFees+CoreDataProperties.swift
//  schoolDashboard
//
//  Created by admin on 2021/5/29.
//
//

import Foundation
import CoreData


extension SubmittedFees {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubmittedFees> {
        return NSFetchRequest<SubmittedFees>(entityName: "SubmittedFees")
    }

    @NSManaged public var adding: Bool
    @NSManaged public var fee: String?
    @NSManaged public var mount: Int16
    @NSManaged public var belongToStudent: Student?
    
    public var wrappedFee:String {
        fee ?? "unknown"
    }
    
    public var wrappedAmount:Int16{
        mount
    }

}

extension SubmittedFees : Identifiable {

}
