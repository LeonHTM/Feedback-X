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
    @State private var fileData: [(name: String, title: String, content: String, date: String, time: String, iteration: String, path: String, fdb: String, files: String)] = []
    
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
                    ForEach(fileData.indices, id: \.self) { index in
                        let file = fileData[index]
                        Button(action: {
                            print("Button tapped for \(file.name)")
                        }) {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text(file.title.isEmpty ? "Untitled" : file.title)
                                        .font(.headline)
                                    Spacer()
                                    Text(file.date.contains(":") ? String(file.date.dropLast(6)) : file.date)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Text(file.name.prefix(file.name.count - 3))
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .cornerRadius(8)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.bottom, 5)
                        
                        if index < fileData.count - 1 {
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

import SwiftUI

struct DetailActivityView: View {
    let folderURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/saves")
    @State private var fileData: [(name: String, title: String, content: String, date: String, time: String, iteration: String, path: String, fdb: String, files: String)] = []
   
    @State private var filesList: [String] = []
    @State private var fdbList: [String] = []
    @State private var hoveredFile: String? = nil
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 20) {
                if fileData.indices.contains(0) {
                    let file = fileData[0]
                    VStack(alignment: .leading, spacing: 10) {
                        Text(file.title)
                            .font(.title)
                            .fontWeight(.bold)
                        Text("FB\(file.name.prefix(file.title.count - 3))")
                            .foregroundStyle(.secondary)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Iterations:")
                                    .foregroundStyle(.secondary)
                                    .fontWeight(.bold)
                                    .padding([.trailing], -5)
                                Text(file.iteration)
                            }
                            HStack {
                                Text("FB on all Account:")
                                    .foregroundStyle(.secondary)
                                    .fontWeight(.bold)
                                    .padding([.trailing], -2)
                                ForEach(fdbList, id: \.self) { fdb in
                                    Text("FB\(fdb)").padding(.leading,-5)
                                    if fdb != fdbList.last {
                                        Text(",").padding(-5)
                                        }
                                    
                                }
                                
                            }
                        }
                        
                        Divider()
                        Text("Basic Information")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                        
                        VStack (alignment: .leading) {
                            Text("Please provide a descriptive title for your feedback")
                                .fontWeight(.bold)
                            Text(file.title)
                        }
                        VStack (alignment: .leading) {
                            Text("What area are you seeing an issue with?")
                                .fontWeight(.bold)
                            Text(file.path.prefix(while: { $0 != "," }))
                        }
                        VStack (alignment: .leading) {
                            Text("What type of Feedback are you reporting?")
                                .fontWeight(.bold)
                            if file.path.split(separator: ",").dropFirst().first == "1" {
                                Text("Incorrect/Unexpected Behavior")
                            } else if file.path.split(separator: ",").dropFirst().first == "2" {
                                Text("Application Crash")
                            } else if file.path.split(separator: ",").dropFirst().first == "3" {
                                Text("Application Slow/Unresponsive")
                            } else if file.path.split(separator: ",").dropFirst().first == "4" {
                                Text("Battery Life")
                            } else if file.path.split(separator: ",").dropFirst().first == "5" {
                                Text("Suggestion")
                            }
                        }
                        
                        Divider()
                        Text("Details")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                        
                        VStack (alignment: .leading) {
                            Text("What is the path to your Issue?")
                                .fontWeight(.bold)
                            Text(file.path.split(separator: ",").dropFirst(2).joined(separator: ","))
                        }
                        VStack (alignment: .leading) {
                            Text("What time was it when this last occurred?")
                                .fontWeight(.bold)
                            HStack {
                                Text(file.date).padding([.trailing], -5)
                                Text(file.time)
                            }
                        }
                        
                        Divider()
                        Text("Description")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                        
                        VStack (alignment: .leading) {
                            Text("Please describe your Issue and what one can take to reproduce it:")
                                .fontWeight(.bold)
                            Text(file.content)
                        }
                        
                        Divider()
                        Text("Files")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                        
                        // Files section with ForEach implementation
                        VStack(alignment: .leading) {
                            ForEach(filesList, id: \.self) { fileName in
                                HStack {
                                    Image(systemName: "document")  // Document icon
                                    Text(hoveredFile == fileName ? fileName : fileName.split(separator: "/").last.map(String.init) ?? fileName)
                                        .background(hoveredFile == fileName ? Color.accentColor.opacity(0.2) : Color.clear)
                                        //.foregroundColor(hoveredFile == fileName ? .accentColor : .primary)
                                        .onHover {hovering in
                                            if hovering {
                                                hoveredFile = fileName
                                            }else{
                                                hoveredFile = nil
                                            }
                                            
                                            
                                            
                                        }
                                }
                                
                            }
                        }
                        
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
            // Load fileData when view appears
            fileData = FileLoader.loadFolderFiles(from: folderURL, fileLimit: 2)
            
            // Ensure filesList is populated from the first item in fileData
            if let firstFile = fileData.first {
                filesList = stringToList(inputString: firstFile.files)
                fdbList = stringToList(inputString: firstFile.fdb)
                
            
            }
        }
    }
}





#Preview {
    DetailActivityView()
}

