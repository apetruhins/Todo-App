//
//  ContentView.swift
//  Todo App
//
//  Created by Alex on 24/07/2022.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @State private var showingAddTodoView: Bool = false
    
    // Fetching data
    @Environment(\.managedObjectContext) private var managedObjectContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoItem.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<TodoItem>
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            List(items) { item in
                Text(item.name ?? "")
            } //: List
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                self.showingAddTodoView.toggle()
                }, label: {
                    Image(systemName: "plus")
                }) //: Add button
                .sheet(isPresented: $showingAddTodoView, content: {
                    AddTodoView()
                        .environment(\.managedObjectContext, self.managedObjectContext)
                })
            )
        } //: Navigation
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
