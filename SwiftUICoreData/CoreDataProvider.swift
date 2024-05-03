//
//  CoreDataProvider.swift
//  SwiftUICoreData
//
//  Created by Martin Wainaina on 03/05/2024.
//

import Foundation
import CoreData

struct CoreDataProvider {
    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "MovieModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable initialize CoreDataProvider with error \(error.localizedDescription)")
            }
        }
    }
}
