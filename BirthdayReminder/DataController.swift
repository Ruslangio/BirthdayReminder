//
//  DataController.swift
//  BirthdayReminder
//
//  Created by Ruslan Alekyan on 24.10.2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "BirthdayReminder")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
