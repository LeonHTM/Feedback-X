//
//  CombinedActivityView.swift
//  Feedback X
//
//  Created by Leon on 13.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

/// A view that combines the recent activity view and the detail activity view.
struct CombinedView: View {
    @State private var selectedFile: (name: String, title: String, content: String, date: String, time: String, iteration: String, path: String, fdb: String, files: String)? = nil
    @AppStorage("selectedIndexActivity") private var selectedIndex: Int?

    @EnvironmentObject var accountLoader: AccountLoader
    @EnvironmentObject var feedbackPython: FeedbackPython
    @EnvironmentObject var fileLoader: FileLoader
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HSplitView {
            // Recent activity view
            RecentActivityView(selectedFile: $selectedFile, selectedIndex: $selectedIndex)
                .frame(minWidth: 250, maxWidth: .infinity)
                .environmentObject(accountLoader)
                .environmentObject(fileLoader)
                .if(colorScheme == .light) {
                    $0.background(Color.white)
                }
                
            if let file = selectedFile {
                // Detail activity view when a file is selected
                DetailActivityView(fileToShow: file, index: $selectedIndex, onDeleteActivity: {
                    print("onDeleteActivity")
                    if let currentIndex = selectedIndex {
                        if currentIndex > 0 && fileLoader.files.count > 1 {
                            print("1")
                            print(currentIndex)
                            selectedFile = fileLoader.files[(currentIndex - 1)]
                        } else {
                            print("2")
                            selectedFile = nil
                        }
                    } else {
                        print("3")
                        selectedFile = nil
                    }
                })
                    .frame(minWidth: 500, maxWidth: 1250)
                    .environmentObject(accountLoader)
                    .environmentObject(fileLoader)
                    .if(colorScheme == .light) {
                        $0.background(Color.white)
                    }
                
            } else {
                // Create feedback view when no file is selected
                CreateFeedbackView()
                    .frame(minWidth: 500, maxWidth: 1250)
                    .environmentObject(accountLoader)
                    .environmentObject(feedbackPython)
                    .environmentObject(fileLoader)
                    .if(colorScheme == .light) {
                        $0.background(Color.white)
                    }
            }
        }
    }
}

#Preview {
    CombinedView()
}
