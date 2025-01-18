//
//  RecentActivityView.swift
//  Feedback X
//
//  Created by Leon  on 13.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct RecentActivityView: View {
    let folderURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/saves")
    @State private var fileData: [(name: String, title: String, content: String, date: String, time: String, iteration: String, path: String, fdb: String, files: String)] = []
    @Binding var selectedFile: (name: String, title: String, content: String, date: String, time: String, iteration: String, path: String, fdb: String, files: String)?
    @EnvironmentObject var accountLoader: AccountLoader
    
    var body: some View {
        VStack {
           /* HStack {
                Text("Recent Activity")
                    .font(.headline)
                    .padding([.leading], 10)
                    .padding([.top, .bottom], 10)
                Spacer()
                Button(action: {})
                { Image(systemName: "line.3.horizontal.decrease.circle") }
                    .buttonStyle(.plain)
                    .padding(.trailing, 10)
            }*/
            //Divider()
            ScrollView {
                VStack(alignment: .leading, spacing:0) {
                    if fileData.isEmpty {
                        Text("No files found or Directory is empty.")
                            .foregroundColor(.gray)
                            .padding(10)
                    } else {
                        ForEach(fileData.indices, id: \.self) { index in
                            let file = fileData[index]
                            Button(action: {
                                selectedFile = file
                            }) {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text(file.title.isEmpty ? "Untitled" : file.title)
                                            .foregroundStyle(selectedFile?.name == file.name ? Color.white : Color.primary)
                                            .font(.headline)
                                            .lineLimit(1)
                                            
                                        
                                        Spacer()
                                        Text(file.date.contains(":") ? String(file.date.dropLast(6)) : file.date)
                                            .font(.subheadline)
                                            .foregroundStyle(selectedFile?.name == file.name ? Color.white.opacity(0.7) : Color.secondary)
                                    }
                                    Text("FB\(file.name.prefix(file.name.count - 4))")
                                        .font(.subheadline)
                                        .foregroundStyle(selectedFile?.name == file.name ? Color.white.opacity(0.7) : Color.secondary)
                                        .lineLimit(1)
                                }
                                .padding([.leading, .trailing], 20)
                                .padding(.vertical, 5)
                                .background(selectedFile?.name == file.name ? Color.accentColor : Color.clear)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .contentShape(RoundedRectangle(cornerRadius: 8))
                            }
                            .buttonStyle(PlainButtonStyle())

                            
                            
                            
                            if index < fileData.count - 1 {
                                Divider()
                                    
                            }
                        }
                    }
                }.padding([.leading, .trailing],5)

                .onAppear {
                    fileData = FileLoader.loadFolderFiles(from: folderURL, fileLimit: nil)
                }
            }
        }//.frame(width:300)
    }
}
