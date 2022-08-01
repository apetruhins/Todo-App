//
//  ThemeSettings.swift
//  Todo App
//
//  Created by Alex on 01/08/2022.
//

import SwiftUI

final public class ThemeSettings: ObservableObject {
    @Published public var theme: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.theme, forKey: "Theme")
            
        }
    }
    
    private init() {}
    
    public static let shared = ThemeSettings()
}
