//
//  Entity.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import CoreData

class Entity<T: NSManagedObject> {

    class func entityName() -> String {
        "\(T.self)"
    }

    class func create(onContext: NSManagedObjectContext) -> T? {
        return NSEntityDescription.insertNewObject(forEntityName: entityName(), into: onContext) as? T
    }
    
    class func fetchRequest(predicate: NSPredicate? = nil, sortOrder: [NSSortDescriptor]? = nil) -> NSFetchRequest<T> {
        let request = NSFetchRequest<T>.init(entityName: entityName())
        request.predicate = predicate
        request.sortDescriptors = sortOrder
        return request
    }
    
    class func fetch(onContext: NSManagedObjectContext, predicate: NSPredicate? = nil, sortOrder: [NSSortDescriptor]? = nil) -> [T] {
        let request = fetchRequest(predicate: predicate, sortOrder: sortOrder)
        return CoreDataStack.shared.fetch(request: request, onContext: onContext) ?? []
    }
    
    class func deleteAllObjectsOfType(predicate: NSPredicate?, onContext: NSManagedObjectContext) {
        let request = fetchRequest(predicate: predicate)
        do {
            let fetchedEnities = try onContext.fetch(request)
            for entity in fetchedEnities {
                onContext.delete(entity)
            }
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
        CoreDataStack.shared.saveContext(context: onContext)
    }
}
