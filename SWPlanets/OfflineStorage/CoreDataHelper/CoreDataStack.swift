//
//  CoreDataStack.swift
//  SWPlanets
//
//  Created by Rohit Ragmahale on 18/04/2023.
//

import CoreData

struct PersistenceManager {
  static let shared = PersistenceManager()

  let persistentContainer: NSPersistentContainer

  init(inMemory: Bool = false) {
    persistentContainer = NSPersistentContainer(name: "PlanetStore")
    if inMemory,
      let storeDescription = persistentContainer.persistentStoreDescriptions.first {
      storeDescription.url = URL(fileURLWithPath: "/dev/null")
    }

    persistentContainer.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unable to configure Core Data Store: \(error), \(error.userInfo)")
      }
    }
  }

  static var preview: PersistenceManager = {
    let result = PersistenceManager(inMemory: true)
    let viewContext = result.persistentContainer.viewContext
    for friendNumber in 0..<10 {
      let newFriend = Planet(context: viewContext)
      newFriend.name = "Planet \(friendNumber)"
    }
    do {
      try viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    return result
  }()
}
