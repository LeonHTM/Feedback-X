//
//  HelpMe1.swift
//  Feedback X
//
//  Created by Leon  on 20.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct HelpWelcomeView: View {
    @Binding var selectedPage: String
    @Binding var visibility: NavigationSplitViewVisibility
    var body: some View {
        ScrollView{
            VStack(alignment: .leading,spacing:10){
                HStack{
                    Image("FeedbackX256.png")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                        .shadow(radius: 5)
                    
                    VStack(alignment:.leading,spacing:10){
                        Text("Feedback X User Guide")
                            .font(.title)
                            .fontWeight(.bold)
                        Button(action:{
                            withAnimation{
                                if visibility == .all{
                                    visibility = .detailOnly
                                }else if visibility == .detailOnly{
                                    visibility = .all
                                }
                            }
                        }){
                            HStack{
                                Image(systemName:"sidebar.left")
                                Text("Table of Contents")
                            }.foregroundStyle(Color.accentColor)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                
                Divider()
                Text("What is Feedback X used for?")
                    .font(.title3)
                    .fontWeight(.bold)
                Text("Feedback X is a programm to duplicate Feedbacks inside the Apple Feedback System. The goal of duplicating Bugs is to get more Attention to the bugs that really matter. Feedback X does this by loging into the Feedback Assistant Website on different Apple Accounts and submiting the Feedback each once. The Apple Developer Accounts for this have to be created manually (Apple detects bots creating Apple Accounts) and saved inside the app.").lineLimit(nil)
                
            }.padding()
            Spacer()
        }
    }
}

#Preview {
    @Previewable @State var text = "Hello, World!"
    @Previewable @State var visibility: NavigationSplitViewVisibility = .all
    HelpWelcomeView(selectedPage: $text,visibility: $visibility)
}
