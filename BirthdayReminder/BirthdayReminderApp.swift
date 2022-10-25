//
//  BirthdayReminderApp.swift
//  BirthdayReminder
//
//  Created by Ruslan Alekyan on 24.10.2022.
//

import SwiftUI

@main
struct BirthdayReminderApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
