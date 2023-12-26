//
//  InputFieldView.swift
//  Vollmed
//
//  Created by Ricardo dos Santos Amaral on 26/12/23.
//

import SwiftUI

struct InputFieldView: View {
    
    var titleKey: String
    var text: Binding<String>
    var secure: Bool
    var py: CGFloat
    var px: CGFloat
    
    init(_ titleKey: String, text: Binding<String>, secure: Bool = false, py: CGFloat = 14, px: CGFloat = 14) {
        self.titleKey = titleKey
        self.text = text
        self.secure = secure
        self.py = py
        self.px = px
    }
    
    var body: some View {
        if secure {
            SecureField(titleKey, text: text)
                .padding(.vertical, py)
                .padding(.horizontal, px)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(14)
            
        } else {
            TextField(titleKey, text: text)
                .padding(.vertical, py)
                .padding(.horizontal, px)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(14)
        }
    }
}

struct InputFieldView_Previews: PreviewProvider {
    static var previews: some View {
        InputFieldView("Insira seu nome", text: .constant("Text"))
    }
}
