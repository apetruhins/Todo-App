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
    @State private var animatingButton: Bool = false
    @State private var showingSettingsView: Bool = false
    
    // Fetching data
    @Environment(\.managedObjectContext) private var managedObjectContext

    @FetchRequest(
        entity: TodoItem.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoItem.name, ascending: true)])
    private var items: FetchedResults<TodoItem>
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ZStack {
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
                            self.showingSettingsView.toggle()
                        }, label: {
                            Image(systemName: "gearshape.fill")
                        }) //: Add button
                        .sheet(isPresented: $showingSettingsView, content: {
                            SettingsView()
                        })
                )
                
                // MARK: - No todo items
                
                if items.count == 0 {
                    EmptyListView()
                }
                
            } //: ZStack
            .sheet(isPresented: $showingAddTodoView, content: {
                AddTodoView()
                    .environment(\.managedObjectContext, self.managedObjectContext)
            })
            .overlay(
                ZStack {
                    
                    Group {
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                        
                    } //: Group
                    .animation(
                        .easeInOut(duration: 2)
                            .repeatForever(autoreverses: true)
                        , value: self.animatingButton)
                    
                    Button(action: {
                        self.showingAddTodoView.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(
                                Circle()
                                    .fill(Color("ColorBase"))
                            )
                            .frame(width: 48, height: 48, alignment: .center)
                    }) //: Button
                    .onAppear {
                        self.animatingButton.toggle()
                    }
                    
                } //: ZStack
                .padding(.bottom, 15)
                .padding(.trailing, 15)
                , alignment: .bottomTrailing
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
