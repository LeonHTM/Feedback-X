//
//  DetailActivityView.swift
//  Feedback X
//
//  Created by LeonHTM on 20.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import SwiftUI

struct DetailActivityView: View {
    let fileToShow: (name: String, title: String, content: String, date: String, time: String, iteration: String, path: String, fdb: String, files: String)
    @State private var hoveredFile: String? = nil
    @EnvironmentObject var accountLoader: AccountLoader
    @EnvironmentObject var fileLoader: FileLoader
    @State private var showDeleteAlert: Bool = false
    @State private var noFileAlert: Bool = false
    @Binding var index: Int?
    
    
    public let onDeleteActivity: () -> Void
    

    // Computed properties for derived lists
    private var filesList: [String] {
        stringToList(inputString: fileToShow.files)
    }

    private var fdbList: [String] {
        stringToList(inputString: fileToShow.fdb)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(fileToShow.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .textSelection(.enabled)
                    
                    Text("FB\(fileToShow.name.prefix(fileToShow.name.count - 4))")
                        .foregroundStyle(.secondary)
                        .textSelection(.enabled)

                    VStack(alignment: .leading) {
                        HStack {
                            Text("Iterations:")
                                .foregroundStyle(.secondary)
                                .fontWeight(.bold)
                            Text(fileToShow.iteration).textSelection(.enabled).padding(-5)
                        }
                        HStack(alignment: .top) {
                            Text("FB on all Accounts:")
                                .foregroundStyle(.secondary)
                                .fontWeight(.bold)
                            Text(fdbList.map { "FB\($0)" }.joined(separator: ", "))
                                .lineLimit(3)
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 5)
                                .textSelection(.enabled)
                        }
                    }
                    
                    Divider()
                    Text("Basic Information")
                        .font(.title2)
                        .foregroundStyle(.secondary)

                    VStack(alignment: .leading) {
                        Text("Please provide a descriptive title for your feedback")
                            .fontWeight(.bold)
                        Text(fileToShow.title)
                            .textSelection(.enabled)
                    }

                    VStack(alignment: .leading) {
                        Text("What area are you seeing an issue with?")
                            .fontWeight(.bold)
                        Text(fileToShow.path.prefix(while: { $0 != "," })) .textSelection(.enabled)
                    }

                    VStack(alignment: .leading) {
                        Text("What type of Feedback are you reporting?")
                            .fontWeight(.bold)
                        let feedbackType = fileToShow.path.split(separator: ",").dropFirst().first
                        Text(
                            feedbackType == "1" ? "Incorrect/Unexpected Behavior" :
                            feedbackType == "2" ? "Application Crash" :
                            feedbackType == "3" ? "Application Slow/Unresponsive" :
                            feedbackType == "4" ? "Battery Life" :
                            feedbackType == "5" ? "Suggestion" :
                            "Unknown"
                        ) .textSelection(.enabled)
                    }
                    
                    Divider()
                    Text("Details")
                        .font(.title2)
                        .foregroundStyle(.secondary)

                    VStack(alignment: .leading) {
                        Text("What is the path to your Issue?")
                            .fontWeight(.bold)
                        Text(fileToShow.path.split(separator: ",").dropFirst(2).joined(separator: ",")) .textSelection(.enabled)
                    }

                    VStack(alignment: .leading) {
                        Text("What time was it when this last occurred?")
                            .fontWeight(.bold)
                        HStack {
                            (Text(fileToShow.date) + Text(" ") + Text(fileToShow.time)).textSelection(.enabled)
                        }
                    }

                    Divider()
                    Text("Description")
                        .font(.title2)
                        .foregroundStyle(.secondary)

                    VStack(alignment: .leading) {
                        Text("Please describe your Issue and what one can take to reproduce it:")
                            .fontWeight(.bold)
                        Text(fileToShow.content) .textSelection(.enabled)
                    }

                    Divider()
                    Text("Files")
                        .font(.title2)
                        .foregroundStyle(.secondary)

                    VStack(alignment: .leading) {
                        if fileToShow.files != "No Uploads" {
                            ForEach(filesList, id: \.self) { fileName in
                                HStack{
                                    let absoluteFilePath = (fileName)
                                    if FileManager.default.fileExists(atPath: absoluteFilePath) {
                                        let nsImage = NSWorkspace.shared.icon(forFile: absoluteFilePath)
                                        Image(nsImage: nsImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 16, height: 16)
                                    }else{
                                        
                                        Image("custom.document.2.badge.questionmark")
                                            
                                    }
                                    Button(action:{
                                        
                                        let fileURL = URL(fileURLWithPath: absoluteFilePath)
                                        if FileManager.default.fileExists(atPath: absoluteFilePath) {
                                            NSWorkspace.shared.activateFileViewerSelecting([fileURL])}
                                        else{
                                            
                                            noFileAlert = true
                                        }
                                        
                                    })
                                    {
                                        Text(hoveredFile == fileName ? fileName : fileName.split(separator: "/").last.map(String.init) ?? fileName)
                                            .background(hoveredFile == fileName ? Color.accentColor.opacity(0.2) : Color.clear)
                                            .onHover { hovering in
                                                hoveredFile = hovering ? fileName : nil
                                            }
                                    }.buttonStyle(PlainButtonStyle())
                                    Button(action: {
                                        
                                        let fileURL = URL(fileURLWithPath: absoluteFilePath)
                                        if FileManager.default.fileExists(atPath: absoluteFilePath) {
                                            NSWorkspace.shared.activateFileViewerSelecting([fileURL])}
                                        else{
                                            
                                            noFileAlert = true
                                        }
                                        
                                        
                                    }) {
                                        Image(systemName: "magnifyingglass")
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .foregroundStyle(Color.secondary)
                                }.padding(.bottom,-5)
                            }


                        } else {
                            Text("No files were uploaded in this feedback")
                        }
                    }.alert(isPresented: $noFileAlert) {
                        Alert(
                            title: Text("This file doesn't exist"),
                            message: Text("The file must have been deleted or moved since the feedback was created."),
                            dismissButton: .cancel()
                        )
                    }
                    Divider()
                    HStack{
                        Spacer()
                        Button(action:{
                            showDeleteAlert = true
                        }){
                            
                            HStack{
                                Text("Delete Feedback")
                                Image(systemName: "trash")
                            }
                            .foregroundStyle(Color.red)
                        }
                        .padding(20)
                        
                        Spacer()
                    }
                    .alert(isPresented: $showDeleteAlert) {
                                            Alert(
                                                title: Text("Delete \(fileToShow.title)?"),
                                                message: Text("Are you sure you want to delete Account \(fileToShow.name)?"),
                                                primaryButton: .destructive(Text("Confirm")) {
                                                    
                                                    fileLoader.deleteFile(named:fileToShow.name)
                                                    onDeleteActivity()
                                                    
                                                    
                                                    

                                                    
                                                },
                                                secondaryButton: .cancel()
                                            )
                                        }
                    


                    
                    
                    
                    
                }
                .padding()
                .padding(.bottom, 10)
            }
        }
    }
}
