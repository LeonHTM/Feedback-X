//
//  SecureInputView.swift
//  Feedback X
//
//  Created by LeonHTM  on 04.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct SecureInputView: View {
    
    // Binding to the text input
    @Binding private var text: String
    // State to toggle between secure and plain text field
    @State private var isSecured: Bool = true
    // Title for the text field
    private var title: String
    
    // Initializer to set the title and bind the text input
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            // Group to switch between SecureField and TextField
            Group {
                if isSecured {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }.padding(.trailing, 40)

            // Button to toggle the secure state
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye" : "eye.slash")
                    .accentColor(.gray)
            }
        }
    }
}

#Preview{
    SecureInputView("password", text: .constant("")).padding(15)
}
