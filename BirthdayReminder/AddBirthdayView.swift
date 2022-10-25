//
//  AddBirthdayView.swift
//  BirthdayReminder
//
//  Created by Ruslan Alekyan on 24.10.2022.
//

import SwiftUI

struct AddBirthdayView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var surname = ""
    @State private var birthday = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                    TextField("Surname", text: $surname)
                }
                
                Section {
                    Text("Birthday")
                    DatePicker("Birthday", selection: $birthday, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(.wheel)
                }
            }
            .navigationTitle("Add Birthday")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newPerson = Person(context: moc)
                        newPerson.id = UUID()
                        newPerson.firstName = name
                        newPerson.lastName = surname
                        newPerson.birthday = birthday
                        
                        try? moc.save()
                        dismiss()
                    }
                    .disabled(name.isEmpty || surname.isEmpty)
                }
            }
        }
    }
}

struct AddBirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        AddBirthdayView()
    }
}
