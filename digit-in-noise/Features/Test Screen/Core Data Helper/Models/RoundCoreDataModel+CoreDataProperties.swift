//
//  RoundCoreDataModel+CoreDataProperties.swift
//  digit-in-noise
//
//  Created by Erik Egers on 2025/01/27.
//
//

import Foundation
import CoreData


extension RoundCoreDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoundCoreDataModel> {
        return NSFetchRequest<RoundCoreDataModel>(entityName: "RoundCoreDataModel")
    }

    @NSManaged public var difficulty: Int16
    @NSManaged public var tripletPlayed: String?
    @NSManaged public var tripletSubmitted: String?
    @NSManaged public var result: ResultsCoreDataModel?

}

extension RoundCoreDataModel : Identifiable {

}
