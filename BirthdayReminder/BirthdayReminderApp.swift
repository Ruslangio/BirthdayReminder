//
//  BirthdayReminderApp.swift
//  BirthdayReminder
//
//  Created by Ruslan Alekyan on 24.05.2023.
//

import SwiftUI

@main
struct BirthdayReminderApp: App {
    @StateObject var viewModel = PersonList()
    
    var body: some Scene {
        WindowGroup {
            PersonListView()
                .environmentObject(viewModel)
        }
    }
}
