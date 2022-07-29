//
//  FormRowStaticView.swift
//  Todo App
//
//  Created by Alex on 29/07/2022.
//

import SwiftUI

struct FormRowStaticView: View {
    
    // MARK: - Properties
    
    var icon: String
    var firstText: String
    var secondtext: String
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.gray)
                
                Image(systemName: icon)
                    .foregroundColor(.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(firstText)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(secondtext)
            
        } //: HSTack
    }
}

// MARK: - Preview

struct FormRowStaticView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowStaticView(icon: "gear", firstText: "Application", secondtext: "Todo App")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
