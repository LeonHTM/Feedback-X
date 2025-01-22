//
//  HelpCreateFeedbackView.swift
//  Feedback X
//
//  Created by Leon  on 20.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct HelpCreateFeedbackView: View {
    @Binding var selectedPage: String
    var body: some View {
        VStack{
            Divider()
                            .foregroundStyle(Color.black)
                            .offset(y:8)
            
            ScrollView{
                
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
                Divider()
            }
            
        }
    }
}

#Preview {
    @Previewable @State var text = "Hello, World!"
    HelpCreateFeedbackView(selectedPage: $text)
}
