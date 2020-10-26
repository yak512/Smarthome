//
//  DeviceSave+CoreDataProperties.swift
//  Smarthome
//
//  Created by Yakoub on 26/10/2020.
//
//

import Foundation
import CoreData


extension DeviceSave {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeviceSave> {
        return NSFetchRequest<DeviceSave>(entityName: "DeviceSave")
    }

    @NSManaged public var id: Int16
    @NSManaged public var intensity: Float
    @NSManaged public var mode: String?
    @NSManaged public var position: Int16
    @NSManaged public var temperature: Float

}

extension DeviceSave : Identifiable {

}
