//
//  AccountsView.swift
//  Feedback X
//
//  Created by LeonHTM on 14.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//


import SwiftUI

struct RecentAccountsView: View {
    let folderPath = "/Users/leon/Desktop/Feedback-X/python/accounts/accounts.txt"
    @State private var accountData: [(relay: String, account: String, password: String, country: String, icloudmail: String, appledev: String, cookies: String)] = []
    @State var selectedAccount: (relay: String, account: String, password: String, country: String, icloudmail: String, appledev: String, cookies: String)?
    
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing:0) {
                    if accountData.isEmpty {
                        Text("No files found or folder is empty.")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(accountData.indices, id: \.self) { index in
                            let account = accountData[index]
                            Button(action: {
                                selectedAccount = account
                            }) {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text(account.icloudmail.isEmpty ? "Untitled" : account.icloudmail)
                                            .font(.headline)
                                            .lineLimit(1)
                                        
                                        Spacer()
                                        Text(account.country)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Text(account.password)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .lineLimit(1)
                                }
                                .padding([.leading, .trailing], 20)
                                .padding(.vertical, 5)
                                .background(selectedAccount?.icloudmail == account.icloudmail ? Color.accentColor : Color.clear)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .contentShape(RoundedRectangle(cornerRadius: 8))
                            }
                            .buttonStyle(PlainButtonStyle())

                            
                            
                            
                            if index < accountData.count - 1 {
                                Divider()
                                    
                            }
                        }
                    }
                }.padding([.leading, .trailing],5)

                .onAppear {
                    accountData = AccountLoader(from: folderPath)
                }
            }
        }//.frame(width:300)
    }
}
/*struct DetailActivityView: View {
    let fileToShow: (name: String, title: String, content: String, date: String, time: String, iteration: String, path: String, fdb: String, files: String)
    @State private var filesList: [String] = []
    @State private var fdbList: [String] = []
    @State private var hoveredFile: String? = nil
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(fileToShow.title)
                        .font(.title)
                        .fontWeight(.bold)
                    Text("FB\(fileToShow.name.prefix(fileToShow.name.count - 4))")
                        .foregroundStyle(.secondary)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Iterations:")
                                .foregroundStyle(.secondary)
                                .fontWeight(.bold)
                            Text(fileToShow.iteration).padding(-5)
                        }
                        HStack {
                            Text("FB on all Account:")
                                .foregroundStyle(.secondary)
                                .fontWeight(.bold)
                            ForEach(fdbList, id: \.self) { fdb in
                                Text("FB\(fdb)")
                                    .padding(.leading, -5)
                                if fdb != fdbList.last {
                                    Text(",")
                                        .padding(-5)
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
            }
        }
        //.frame(minWidth:500,maxWidth:1000)
        .onAppear {
            filesList = stringToList(inputString: fileToShow.files)
            fdbList = stringToList(inputString: fileToShow.fdb)
        }
    }
}


struct CombinedView: View {
    @State private var selectedFile: (name: String, title: String, content: String, date: String, time: String, iteration: String, path: String, fdb: String, files: String)? = nil

    var body: some View {
        HSplitView {
            RecentActivityView(selectedFile: $selectedFile)
                .frame(minWidth: 250, maxWidth: .infinity)
                
            if let file = selectedFile {
                DetailActivityView(fileToShow: file)
                    .frame(minWidth: 500, maxWidth: 1250) // Fill remaining space when a file is selected
            } else {
                CreateFeedbackView()
                    .frame(minWidth: 500, maxWidth: 1250) // Fill remaining space when no file is selected
            }
        }
        Spacer()
    }
}
*/


#Preview{
    RecentAccountsView()
}
