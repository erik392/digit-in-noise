//
//  ResultsCoreDataModel+CoreDataProperties.swift
//  digit-in-noise
//
//  Created by Erik Egers on 2025/01/27.
//
//

import Foundation
import CoreData


extension ResultsCoreDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResultsCoreDataModel> {
        return NSFetchRequest<ResultsCoreDataModel>(entityName: "ResultsCoreDataModel")
    }

    @NSManaged public var score: Int16
    @NSManaged public var rounds: NSSet?

}

// MARK: Generated accessors for rounds
extension ResultsCoreDataModel {

    @objc(addRoundsObject:)
    @NSManaged public func addToRounds(_ value: RoundCoreDataModel)

    @objc(removeRoundsObject:)
    @NSManaged public func removeFromRounds(_ value: RoundCoreDataModel)

    @objc(addRounds:)
    @NSManaged public func addToRounds(_ values: NSSet)

    @objc(removeRounds:)
    @NSManaged public func removeFromRounds(_ values: NSSet)

}

extension ResultsCoreDataModel : Identifiable {

}
