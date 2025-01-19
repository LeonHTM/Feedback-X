//
//  RecentActivityView.swift
//  Feedback X
//
//  Created by Leon on 13.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct RecentActivityView: View {
    @Binding var selectedFile: (name: String, title: String, content: String, date: String, time: String, iteration: String, path: String, fdb: String, files: String)?
    @Binding var selectedIndex: Int?
    @EnvironmentObject var accountLoader: AccountLoader
    @EnvironmentObject var fileLoader: FileLoader
    @State private var showDeleteAlert: Bool = false

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    if fileLoader.files.isEmpty {
                        Text("No files found or directory is empty.")
                            .foregroundColor(.gray)
                            .padding(10)
                    } else {
                        ForEach(fileLoader.files.indices, id: \.self) { index in
                            let file = fileLoader.files[index]
                            Button(action: {
                                selectedFile = file
                                selectedIndex = index
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
                            .alert(isPresented: $showDeleteAlert) {
                                Alert(
                                    title: Text("Delete \(selectedFile?.title ?? "Unknown")?"),
                                    message: Text("Are you sure you want to delete feedback \(selectedFile?.name ?? "Unknown")?"),
                                    primaryButton: .destructive(Text("Confirm")) {
                                        
                                        fileLoader.deleteFile(named:selectedFile?.name ?? "yo")
                                        if index + 1 < fileLoader.files.count{
                                            
                                            
                                            selectedFile = fileLoader.files[index+1]
                                        }else{
                                            
                                            selectedFile = nil
                                        }

                                       
                                        
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                            .contextMenu {
                                
                                
                                Button(role: .destructive) {
                                    
                                    showDeleteAlert = true
                                    selectedFile = file
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                            

                            if index < fileLoader.files.count - 1 {
                                Divider()
                            }
                        }
                    }
                }
                .padding([.leading, .trailing], 5)
            }
        }
        .onAppear {
            fileLoader.loadFolderFiles()
        }
    }
}

