//
//  RecentActivity.swift
//  Feedback X
//
//  Created by LeonHTM on 20.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import SwiftUI

struct DetailActivityView: View {
    let fileToShow: (name: String, title: String, content: String, date: String, time: String, iteration: String, path: String, fdb: String, files: String)
    @State private var filesList: [String] = []
    @State private var fdbList: [String] = []
    @State private var hoveredFile: String? = nil
    @EnvironmentObject var accountLoader: AccountLoader
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(fileToShow.title)
                        .font(.title)
                        .fontWeight(.bold)
                    Text("FB\(fileToShow.name.prefix(fileToShow.name.count - 4))")
                        .foregroundStyle(.secondary)
                    
                    
                        .onChange(of:fileToShow.name) {
                            filesList = stringToList(inputString: fileToShow.files)
                            fdbList = stringToList(inputString: fileToShow.fdb)
                        }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Iterations:")
                                .foregroundStyle(.secondary)
                                .fontWeight(.bold)
                            Text(fileToShow.iteration).padding(-5)
                        }
                        HStack(alignment: .top){
                            Text("FB on all Account:")
                                .foregroundStyle(.secondary)
                                .fontWeight(.bold)
                            Text(fdbList.map { "FB\($0)" }.joined(separator: ", "))
                                .lineLimit(3) // Allow wrapping to multiple lines
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 5)
                        }
                        
                    }
                    
                    Divider()
                    Text("Basic Information")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    
                    VStack (alignment: .leading) {
                        Text("Please provide a descriptive title for your feedback")
                            .fontWeight(.bold)
                        Text(fileToShow.title)
                    }
                    VStack (alignment: .leading) {
                        Text("What area are you seeing an issue with?")
                            .fontWeight(.bold)
                        Text(fileToShow.path.prefix(while: { $0 != "," }))
                    }
                    VStack (alignment: .leading) {
                        Text("What type of Feedback are you reporting?")
                            .fontWeight(.bold)
                        if fileToShow.path.split(separator: ",").dropFirst().first == "1" {
                            Text("Incorrect/Unexpected Behavior")
                        } else if fileToShow.path.split(separator: ",").dropFirst().first == "2" {
                            Text("Application Crash")
                        } else if fileToShow.path.split(separator: ",").dropFirst().first == "3" {
                            Text("Application Slow/Unresponsive")
                        } else if fileToShow.path.split(separator: ",").dropFirst().first == "4" {
                            Text("Battery Life")
                        } else if fileToShow.path.split(separator: ",").dropFirst().first == "5" {
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
                        Text(fileToShow.path.split(separator: ",").dropFirst(2).joined(separator: ","))
                    }
                    VStack (alignment: .leading) {
                        Text("What time was it when this last occurred?")
                            .fontWeight(.bold)
                        HStack {
                            Text(fileToShow.date).padding([.trailing], -5)
                            Text(fileToShow.time)
                        }
                    }
                    Divider()
                    Text("Description")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    
                    VStack (alignment: .leading) {
                        Text("Please describe your Issue and what one can take to reproduce it:")
                            .fontWeight(.bold)
                        Text(fileToShow.content)
                    }
                    
                    Divider()
                    Text("Files")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    
                    // Files section with ForEach implementation
                    VStack(alignment: .leading) {
                        if fileToShow.files != "No Uploads"{
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
                        }else{
                            Text("No files were uploaded in this feedback")
                        }
                    }
                                            
                    
                }
                .padding()
                .padding(.bottom, 10)
            }
        }
     
        .onAppear{
            filesList = stringToList(inputString: fileToShow.files)
            fdbList = stringToList(inputString: fileToShow.fdb)
        }
    }
}




