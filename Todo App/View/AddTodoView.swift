//
//  AddTodoView.swift
//  Todo App
//
//  Created by Alex on 24/07/2022.
//

import SwiftUI

struct AddTodoView: View {
    
    // MARK: - Properties
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = [ "High", "Normal", "Low" ]
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Todo", text: $name)
                    
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Button {
                        
                    } label: {
                        Text("Save")
                    }

                } //: Form
                
                Spacer()
            } //: VStack
            .navigationBarTitle("New Todo", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            })
            )
        } //: Navigation
    }
}

// MARK: - Preview

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
