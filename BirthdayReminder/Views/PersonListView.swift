//
//  PersonListView.swift
//  BirthdayReminder
//
//  Created by Ruslan Alekyan on 24.05.2023.
//

import SwiftUI

struct PersonListView: View {
    @EnvironmentObject var viewModel: PersonList
    
    @State private var isShowingAddPersonSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.persons) { person in
                    VStack(alignment: .leading) {
                        Text(person.fullname)
                            .font(.headline)
                        Text(person.birthday, style: .date)
                            .font(.subheadline)
                    }
                }
                .onDelete(perform: viewModel.deletePerson)
            }
            .navigationTitle("Birthday Reminder")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    addPersonButton
                }
                ToolbarItem {
                    settingsButtons
                }
            }
            .sheet(isPresented: $isShowingAddPersonSheet) {
                AddPersonSheet()
            }
        }
    }
    
    // MARK: - Toolbar Buttons
    
    private var addPersonButton: some View {
        Button {
            isShowingAddPersonSheet = true
        } label: {
            Image(systemName: "plus")
        }
    }
    
    private var settingsButtons: some View {
        Menu {
            Menu {
                Button("Name", action: viewModel.sortByName)
                Button("Birthday", action: viewModel.sortByDate)
            } label: {
                Label("Sort by", systemImage: "arrow.up.arrow.down")
            }
            Picker(selection: $viewModel.reminderTime) {
                ForEach(0..<24) {
                    Text("\($0):00")
                }
            } label: {
                Text("Reminder time - \(viewModel.reminderTime):00")                       // Поменять
            }
            .pickerStyle(.menu)
        } label: {
            Image(systemName: "gear")
        }
    }
}

struct PersonListView_Previews: PreviewProvider {
    static var previews: some View {
        PersonListView()
    }
}
