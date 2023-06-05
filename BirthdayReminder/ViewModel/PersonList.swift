//
//  PersonList.swift
//  BirthdayReminder
//
//  Created by Ruslan Alekyan on 24.05.2023.
//

import SwiftUI

class PersonList: ObservableObject {
    @Published private(set) var persons = [Person]() {
        didSet {
            storePersonsInUserDefaults()
        }
    }
    
    @Published var reminderTime = 0 {
        didSet {
            storeReminderTimeInUserDefaults()
        }
    }
        
    init() {
        askPermission()
        restoreFromUserDefaults()
    }
    
    // MARK: - Save & Load
    
    private let personsKey = "persons"
    private let reminderTimeKey = "reminderTimeKey"

    
    private func storePersonsInUserDefaults() {
        if let encodedPersons = try? JSONEncoder().encode(persons) {
            UserDefaults.standard.set(encodedPersons, forKey: personsKey)
        }
    }
    
    private func storeReminderTimeInUserDefaults() {
        UserDefaults.standard.set(reminderTime, forKey: reminderTimeKey)
    }
    
    private func restoreFromUserDefaults() {
        if let encodedPersons = UserDefaults.standard.data(forKey: personsKey) {
            if let decodedPersons = try? JSONDecoder().decode([Person].self, from: encodedPersons) {
                persons = decodedPersons
            }
        }
        
        reminderTime = UserDefaults.standard.integer(forKey: reminderTimeKey)
    }
    
    // MARK: - Notifications
    
    private let center = UNUserNotificationCenter.current()
    
    private func askPermission() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func addNotification(for person: Person) {
        let content = UNMutableNotificationContent()
        content.title = person.fullname
        content.body = "has a birthday today"
        content.sound = .default
        
        var dateComponents = Calendar.current.dateComponents([.month, .day], from: person.birthday)
        dateComponents.hour = reminderTime
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: person.id.uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    // MARK: - Sorting
    
    func sortByName() {
        persons.sort(by: { $0.fullname < $1.fullname })
    }
    
    func sortByDate() {
        persons.sort(by: { $0.birthday < $1.birthday })
    }
    
    // MARK: - Intents
    
    func addPerson(name: String, surname: String, birthday: Date) {
        let person = Person(name: name, surname: surname, birthday: birthday)
        addNotification(for: person)
        persons.append(person)
    }
    
    func deletePerson(at indexSet: IndexSet) {
        persons.remove(atOffsets: indexSet)
    }
}

