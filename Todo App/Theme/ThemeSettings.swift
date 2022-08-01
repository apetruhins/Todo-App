//
//  ThemeSettings.swift
//  Todo App
//
//  Created by Alex on 01/08/2022.
//

import SwiftUI

class ThemeSettings: ObservableObject {
    @Published var theme: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.theme, forKey: "Theme")
        }
    }
}
