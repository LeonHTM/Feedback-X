//
//  TestView.swift
//  Feedback X
//
//  Created by Leon  on 08.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct TestView: View {
    @State private var cookiesList: Set<String> = []

    var items = ["yo", "wallah yo", "antifa"]

    var body: some View {
        List(items, id: \.self) { item in
            HStack {
                
                
                
                
                ZStack {
                    Image(systemName: "circle")
                        .font(.system(size: 20))
                    Image(systemName: cookiesList.contains(item) ? "checkmark" : "")
                        .foregroundStyle(Color.primary)
                }
                .background(
                    Circle()
                        .fill(cookiesList.contains(item) ? Color.accentColor : Color.clear)
                )
                .foregroundStyle(cookiesList.contains(item) ? Color.accentColor : Color.primary)
                
                
                Text(item) // Item text
            }
            .contentShape(Rectangle()) // Makes the entire row tappable
            .onTapGesture {
                if cookiesList.contains(item) {
                    cookiesList.remove(item) // Deselect
                } else {
                    cookiesList.insert(item) // Select
                }
            }
        }
    }
}

#Preview {
    TestView()
}
