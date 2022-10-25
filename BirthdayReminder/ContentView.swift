//
//  ContentView.swift
//  BirthdayReminder
//
//  Created by Ruslan Alekyan on 24.10.2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.lastName), SortDescriptor(\.firstName)]) var persons: FetchedResults<Person>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView { // Заменить на NavigationStack
            List {
                ForEach(persons) { person in
                    NavigationLink {
                        // Добавить новое представление с подробным описанием человека
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(person.firstName ?? "Unknown")
                                Text(person.lastName ?? "Unknown")
                            }
                            
                            Spacer()
                            
                            Text(person.birthday!, style: .date)
                        }
                    }
                }
                .onDelete(perform: deletePersons)
            }
            .navigationTitle("Birthday Reminder")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Birthday", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBirthdayView()
            }
        }
    }
    
    func deletePersons(at offsets: IndexSet) {
        for offset in offsets {
            let person = persons[offset]
            
            moc.delete(person)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
