//
//  AboutView.swift
//  Feedback X
//
//  Created by Leon  on 14.12.2024.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        
        VStack{
            Image("FeedbackX256.png")
                
                
            Text("This App was made by LeonHTM").fontWeight(.bold)
            
            VStack{
                Text("Legal").fontWeight(.bold)
                Text("This app is provided as is, without any guarantees or warranties. The developer does not accept any responsibility for any actions taken by users of this app. By using this app, you agree to use it at your own risk.")
                
            }.frame(width:200,height:200)
            Link("View Project on Github",
                 destination: URL(string: "https://github.com/LeonHTM/Feedback-X")!)
        }.padding(30)
    }
}

#Preview {
    AboutView()
}
