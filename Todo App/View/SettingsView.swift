//
//  SettingsView.swift
//  Todo App
//
//  Created by Alex on 29/07/2022.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var iconSettings: IconNames
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .center, spacing: 0) {
                
                // MARK: - Form
                
                Form {
                    
                    // MARK: - Section 1
                    
                    Section("Choose the app icon") {
                        Picker(selection: $iconSettings.currentIndex, label:
                                
                            HStack {
                                
                                ZStack {
                                    
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .strokeBorder(Color.primary, lineWidth: 2)
                                    
                                    Image(systemName: "paintbrush")
                                            .font(.system(size: 28, weight: .regular, design: .default))
                                        .foregroundColor(.primary)
                                }.frame(width: 44, height: 44)
                            
                            Text("App Icons".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                            }
                               
                        ) {
                            
                            ForEach(0..<iconSettings.iconNames.count, id: \.self) { index in
                                HStack {
                                    Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "Blue") ?? UIImage())
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                        .cornerRadius(8)
                                    
                                    Spacer()
                                        .frame(width: 8)
                                    
                                    Text(self.iconSettings.iconNames[index] ?? "Blue")
                                        .frame(alignment: .leading)
                                    
                                } //: HStack
                                .padding(3)
                                
                            } //: ForEach
                            
                        } //: Picker
                        .onReceive([self.iconSettings.currentIndex].publisher.first()) { value in
                            
                            let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                            
                            if index != value {
                                UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]) { error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                        }
                        
                    } //: Section 1
                    .padding(.vertical, 3)
                    
                    // MARK: - Section 3
                    
                    Section("Folow us on social media") {
                        FormRowLinkView(icon: "globe", color: .pink, text: "Website", link: "https://swiftuimasterclass.com")
                        FormRowLinkView(icon: "link", color: .blue, text: "Twitter", link: "https://twitter.com/robertpetras")
                        FormRowLinkView(icon: "play.rectangle", color: .green, text: "Courses", link: "https://www.udemy.com/user/robert-petras")
                    } //: Section 3
                    .padding(.vertical, 3)
                    
                    // MARK: - Section 4
                    Section("About the application") {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondtext: "Todo App")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondtext: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondtext: "Alex")
                        FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondtext: "Robert Petras")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondtext: "1.0.0")
                    } //: Section 4
                    
                    .padding(.vertical, 3)
                    
                } //: Form
                .listStyle(.grouped)
                .environment(\.horizontalSizeClass, .regular)
                
                // MARK: - Footer
                
                Text("Copyright © All rights reserved.\nBetter Apps ♡ Less Code.")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(.secondary)
                
            } //: VStack
            .navigationBarTitle("Settings", displayMode: .inline)
            .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(IconNames())
    }
}
