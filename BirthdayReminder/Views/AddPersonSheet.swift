//
//  AddPersonSheet.swift
//  BirthdayReminder
//
//  Created by Ruslan Alekyan on 24.05.2023.
//

import SwiftUI

struct AddPersonSheet: View {
    @EnvironmentObject var viewModel: PersonList
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                nameSection
                dateSection
            }
            .navigationTitle("Add Person")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    cancelButton
                }
                ToolbarItem {
                    addButton
                }
            }
        }
    }
    
    // MARK: - Sections
    
    @State private var name = ""
    @State private var surname = ""
    @State private var birthday = Date()
    
    private var nameSection: some View {
        Section("Full name") {
            TextField("Name", text: $name)
            TextField("Surname", text: $surname)
        }
    }
    
    private var dateSection: some View {
        Section("Birthday") {
            DatePicker("Birthday", selection: $birthday, in: ...Date(), displayedComponents: .date)
                .datePickerStyle(.wheel)
        }
    }
    
    // MARK: - Toolbar Buttons
    
    private var cancelButton: some View {
        Button("Cancel") {
            dismiss()
        }
    }
    
    private var addButton: some View {
        Button("Add") {
            viewModel.addPerson(name: name, surname: surname, birthday: birthday)
            dismiss()
        }
    }
}

struct AddPersonSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonSheet()
    }
}
