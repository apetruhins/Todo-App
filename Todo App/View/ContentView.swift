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
        entity: TodoItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoItem.name, ascending: true)])
    private var items: FetchedResults<TodoItem>
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.items, id: \.self) { item in
                    HStack {
                        Text(item.name ?? "")
                        
                        Spacer()
                        
                        Text(item.priority ?? "")
                    }
                }
                .onDelete(perform: deleteTodo)
            } //: List
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(
                leading: EditButton(),
                trailing:
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
    
    // MARK: - Functions
    
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = items[index]
            
            managedObjectContext.delete(todo)
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
