//
//  CombinedActivityView.swift
//  Feedback X
//
//  Created by Leon  on 13.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct CombinedView: View {
    @State private var selectedFile: (name: String, title: String, content: String, date: String, time: String, iteration: String, path: String, fdb: String, files: String)? = nil
    @EnvironmentObject var accountLoader: AccountLoader

    var body: some View {
        HSplitView {
            RecentActivityView(selectedFile: $selectedFile)
                .frame(minWidth: 250, maxWidth: .infinity)
                .environmentObject(accountLoader)
                
            if let file = selectedFile {
                DetailActivityView(fileToShow: file)
                    .frame(minWidth: 500, maxWidth: 1250)
                    .environmentObject(accountLoader)
            } else {
                CreateFeedbackView()
                    .frame(minWidth: 500, maxWidth: 1250)
                    .environmentObject(accountLoader)
            }
        }
        Spacer()
    }
}


#Preview {
    CombinedView()
}
