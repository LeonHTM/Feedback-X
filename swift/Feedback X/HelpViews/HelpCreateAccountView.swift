//
//  HelpCreateAccountView.swift
//  Feedback X
//
//  Created by Leon  on 20.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct HelpCreateAccountView: View {
    @Binding var selectedPage: String
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Image("FeedbackX256.png")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .shadow(radius: 5)
                    Text("Create Account")
                        .font(.title)
                        .fontWeight(.bold)
                }.padding(.bottom,20)
                
            }.padding()
            
        }
    }
    
}

#Preview {
    @Previewable @State var text = "Hello, World!"
    HelpCreateAccountView(selectedPage: $text)
}
