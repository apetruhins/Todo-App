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
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            List(0..<5) { item in
                Text("Hello, World!")
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
                })
            )
        } //: Navigation
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
