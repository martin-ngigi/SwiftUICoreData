//
//  Model.swift
//  SwiftUICoreData
//
//  Created by Martin Wainaina on 03/05/2024.
//

import Foundation
import CoreData

//provide core functionalities for other Models

protocol Model {
    
}

extension Model where Self: NSManagedObject {
    func save() throws {
        try CoreDataProvider.shared.viewContext.save()
    }
    
    func delete() throws {
        CoreDataProvider.shared.viewContext.delete(self)
        try save()
    }
    
    static var all: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: String(describing: self))
        request.sortDescriptors = []
        return request
    }
}
