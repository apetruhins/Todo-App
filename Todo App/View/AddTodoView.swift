//
//  AddTodoView.swift
//  Todo App
//
//  Created by Alex on 24/07/2022.
//

import SwiftUI

struct AddTodoView: View {
    
    // MARK: - Properties
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                } //: Form
                
                Spacer()
            } //: VStack
            .navigationBarTitle("New Todo", displayMode: .inline)
        } //: Navigation
    }
}

// MARK: - Preview

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
