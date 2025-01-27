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
    @NSManaged public var rounds: NSOrderedSet?

}

// MARK: Generated accessors for rounds
extension ResultsCoreDataModel {

    @objc(insertObject:inRoundsAtIndex:)
    @NSManaged public func insertIntoRounds(_ value: RoundCoreDataModel, at idx: Int)

    @objc(removeObjectFromRoundsAtIndex:)
    @NSManaged public func removeFromRounds(at idx: Int)

    @objc(insertRounds:atIndexes:)
    @NSManaged public func insertIntoRounds(_ values: [RoundCoreDataModel], at indexes: NSIndexSet)

    @objc(removeRoundsAtIndexes:)
    @NSManaged public func removeFromRounds(at indexes: NSIndexSet)

    @objc(replaceObjectInRoundsAtIndex:withObject:)
    @NSManaged public func replaceRounds(at idx: Int, with value: RoundCoreDataModel)

    @objc(replaceRoundsAtIndexes:withRounds:)
    @NSManaged public func replaceRounds(at indexes: NSIndexSet, with values: [RoundCoreDataModel])

    @objc(addRoundsObject:)
    @NSManaged public func addToRounds(_ value: RoundCoreDataModel)

    @objc(removeRoundsObject:)
    @NSManaged public func removeFromRounds(_ value: RoundCoreDataModel)

    @objc(addRounds:)
    @NSManaged public func addToRounds(_ values: NSOrderedSet)

    @objc(removeRounds:)
    @NSManaged public func removeFromRounds(_ values: NSOrderedSet)

}

extension ResultsCoreDataModel : Identifiable {

}
