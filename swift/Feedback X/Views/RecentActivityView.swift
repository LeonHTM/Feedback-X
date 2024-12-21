//
//  RecentActivity.swift
//  Feedback X
//
//  Created by LeonHTM on 20.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import SwiftUI

struct RecentActivityView: View {
    let folderURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/saves")
    @State private var fileData: [(name: String, title: String, content: String, date: String, time: String, iteration: String)] = []
    
    var body: some View {
        HStack {
            Text("Recent Activity")
                .font(.headline)
                .padding([.leading], 10)
                .padding([.top, .bottom], 10)
            Spacer()
            Button(action: {})
            { Image(systemName: "line.3.horizontal.decrease.circle") }
                .buttonStyle(.plain)
                .padding(.trailing, 10)
        }
        Divider()
        ScrollView {
            VStack(alignment: .leading) {
                if fileData.isEmpty {
                    Text("No files found or folder is empty.")
                        .foregroundColor(.gray)
                } else {
                    ForEach(fileData, id: \.name) { file in
                        Button(action: {
                            print("Button tapped for \(file.name)")
                        }) {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text(file.title.isEmpty ? "Untitled" : file.title)
                                        .font(.headline)
                                    Spacer()
                                    Text(
                                        file.date.contains(":")
                                            ? String(file.date.dropLast(6))
                                            : file.date
                                    )
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                }
                                Text(file.name.prefix(file.name.count - 4))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .cornerRadius(8)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.bottom, 5)
                        if let lastFile = fileData.last, file != lastFile {
                            Divider()
                        }
                    }
                }
            }
            .padding([.leading, .trailing], 25)
            .onAppear {
                fileData = FileLoader.loadFolderFiles(from: folderURL,fileLimit:nil)
            }
        }
    }
}

struct DetailActivityView: View {
    let folderURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/saves")
    @State private var fileData: [(name: String, title: String, content: String, date: String, time: String, iteration: String)] = []
   
    var body: some View {
        ScrollView {
            VStack (alignment:.leading,spacing:20) {
                if fileData.indices.contains(0) {
                    let file = fileData[0]
                    VStack(alignment: .leading, spacing: 10) {
                        Text(file.title)
                            .font(.title)
                            .fontWeight(.bold)
                        Text("FB\(file.name.prefix(file.title.count - 4))")
                            .foregroundColor(.secondary)
                        HStack{
                            Text("Iterations:")
                                .foregroundColor(.secondary)
                            
                        }
                        Divider()
                        
                            
                            
                        Text("Content: \(file.content)")
                            
                        Text("Date: \(file.date)")
                            
                        Text("Time: \(file.time)")
                            
                    }
                    .padding()
                    .padding(.bottom, 10)
                } else {
                    // Handle the case when fileData is empty
                    Text("No files available.")
                        .font(.headline)
                        .padding()
                }
            }
        }
        .onAppear {
            fileData = FileLoader.loadFolderFiles(from: folderURL, fileLimit:2)
        }
    }
}





#Preview {
    DetailActivityView()
}

