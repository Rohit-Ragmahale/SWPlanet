//
//  Planet.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import Foundation
import CoreData

@objc(Planet)
public class Planet: NSManagedObject {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<Planet> {
      return NSFetchRequest<Planet>(entityName: "Planet")
    }
}

extension Planet {
    @NSManaged public var name: String
    @NSManaged public var terrain: String

}
