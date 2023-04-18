//
//  CoreDataStack.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import CoreData

class CoreDataStack {
    let kPlanetStore = "PlanetStore"
    
    static let shared = CoreDataStack()
    private init() {}
    
    lazy var persistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: kPlanetStore)
        container.loadPersistentStores { persistentStoreDescription, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    private var _mainObjectContext: NSManagedObjectContext?
    
    func mainContext() -> NSManagedObjectContext {
        if _mainObjectContext == nil {
            _mainObjectContext = persistantContainer.viewContext
        }
        return _mainObjectContext!
    }
    
    func newWorkerContext() -> NSManagedObjectContext {
        return persistantContainer.newBackgroundContext()
    }
    
    func saveMainContext() {
        let context = persistantContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Unable to save main context error \(error.localizedDescription))")
            }
        }
    }
    
    
    func saveContext(context: NSManagedObjectContext) {
        if context.hasChanges {
            context.performAndWait {
                do {
                    try context.save()
                    saveMainContext()
                } catch {
                    fatalError("Unable to save on context error \(error.localizedDescription))")
                }
            }
        }
    }

    func saveContext(_ context: NSManagedObjectContext) {
        if context == self.mainContext() {
            saveMainContext()
        } else {
            if context.hasChanges {
                context.performAndWait {[weak self] in
                    do {
                        try context.save()
                        if let weakSelf = self {
                            weakSelf.saveMainContext()
                        }
                    } catch let error as NSError {

                        print("Unresolved error while saving main context \(error), \(error.userInfo)")
                    }
                }

            }
        }
    }

    func deleteObject(object: NSManagedObject) {
        if let context = object.managedObjectContext {
            context.delete(object)
            self.saveContext(context: context)
        }
    }
}


extension CoreDataStack {
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>, onContext: NSManagedObjectContext) -> [T]? {
        do {
            let objects = try onContext.fetch(request)
            return objects
        } catch {
            print("Fetch Failed \(error)")
        }
        return nil
    }
}
