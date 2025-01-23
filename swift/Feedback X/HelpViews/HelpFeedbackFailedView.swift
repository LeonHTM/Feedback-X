//
//  HelpFeedbackFailedView.swift
//  Feedback X
//
//  Created by Leon  on 20.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct HelpFeedbackFailedView: View {
    @Binding var selectedPage: String
    @Environment(\.colorScheme) var colorScheme
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
        }.background(colorScheme == .dark ? Color.black.opacity(0.35) : Color.white)
    }
}

#Preview {
    @Previewable @State var text = "Hello, World!"
    HelpFeedbackFailedView(selectedPage: $text)
}
