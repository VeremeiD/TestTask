//
//  VectorEntity+CoreDataProperties.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 27.11.22.
//
//

import Foundation
import CoreData


extension VectorEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VectorEntity> {
        return NSFetchRequest<VectorEntity>(entityName: "VectorEntity")
    }

    @NSManaged public var end_point_x: Double
    @NSManaged public var end_point_y: Double
    @NSManaged public var length: Float
    @NSManaged public var start_point_x: Double
    @NSManaged public var start_point_y: Double
    @NSManaged public var identifier: String?
    @NSManaged public var color_hex: String?

}

extension VectorEntity : Identifiable {

}
