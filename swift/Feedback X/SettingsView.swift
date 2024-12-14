//
//  SettingsView.swift
//  Feedback X
//
//  Created by Leon  on 14.12.2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack{
            Text("Settings")
            NavigationLink("back",destination:SidebarView())
            
        }.padding(30)
    }
}

#Preview {
    SettingsView()
}
