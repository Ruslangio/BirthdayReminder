//
//  Person.swift
//  BirthdayReminder
//
//  Created by Ruslan Alekyan on 24.05.2023.
//

import Foundation

struct Person: Identifiable, Codable {
    var id = UUID()
    let name: String
    let surname: String
    let birthday: Date
    var fullname: String {
        surname + " " + name
    }
}
