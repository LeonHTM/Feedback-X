//
//  stackstack.swift
//  Feedback X
//
//  Created by Leon  on 20.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let folderURL = URL(fileURLWithPath: "/Users/leon/Desktop/Feedback-X/python/saves")
    
    // Update the data structure to include the filename (name)
    @State private var fileData: [(name: String, title: String, content: String,date: String, time: String)] = []
    
    var body: some View {
        HStack{
            Text("Recent Activity")
                .font(.headline)
                .padding([.leading],10)
                .padding([.top,.bottom],10)
            Spacer()
            Button(action: {})
            {Image(systemName:"line.3.horizontal.decrease.circle")}
                .buttonStyle(.plain)
                .padding(.trailing,10)
        }
        Divider()
        ScrollView {
            VStack(alignment: .leading) {
                if fileData.isEmpty {
                    Text("No files found or folder is empty.")
                        .foregroundColor(.gray)
                } else {
                    // Use 'name' as the unique identifier in the ForEach loop
                    ForEach(fileData, id: \.name) { file in
                        Button(action: {
                            // You can add any action here when the button is tapped
                            print("Button tapped for \(file.name)")
                        }) {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack{
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
                                
                                Text(file.name.prefix(file.name.count - 4)) // Display Date and Time
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                            }
                            
                            .cornerRadius(8) // Optional: adds a subtle shadow for better visual
                        }
                        .buttonStyle(PlainButtonStyle())  // This removes the default button styling
                        .padding(.bottom, 5)
                        if let lastFile = fileData.last, file != lastFile {
                            Divider()
                        }
                    }

                }
            }
            .padding([.leading, .trailing],25)
            .onAppear(perform: loadFiles)
        }
    }
    
    func loadFiles() {
        do {
            // Get all files in the directory
            let fileURLs = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
            
            // Filter .txt files and exclude "rewrite.txt"
            let txtFiles = fileURLs
                .filter { $0.pathExtension.lowercased() == "txt" && $0.lastPathComponent != "rewrite.txt" }
                .sorted { $0.lastPathComponent.localizedCompare($1.lastPathComponent) == .orderedAscending }
            
            // Print filenames for debugging
            print("\(txtFiles.map { $0.lastPathComponent })")
            print("\txtFiles")
            
            // Parse each file and include the filename as 'name'
            fileData = try txtFiles.compactMap { url in
                let content = try String(contentsOf: url, encoding: .utf8)
                return parseFile(content: content, filename: url.lastPathComponent) // Pass filename
            }
        } catch {
            print("Error loading files: \(error.localizedDescription)")
        }
    }
    
    // Updated parseFile to return 'name' along with title and content
    func parseFile(content: String, filename: String) -> (name: String, title: String, content: String, date: String, time: String)? {
        let lines = content.split(separator: "\n", omittingEmptySubsequences: false)
        
        guard lines.count >= 7 else { return nil }  // Ensure the file has enough lines
        
        let title = String(lines[0]) // Extract the title (first line)
        let date = String(lines[1])  // Extract the date (second line)
        let time = String(lines[2])  // Extract the time (third line)
        
        // Find the indexes for "Content_Start" and "Content_Finish" to extract content
        guard let contentStartIndex = lines.firstIndex(of: "Content_Start"),
              let contentFinishIndex = lines.firstIndex(of: "Content_Finish"),
              contentStartIndex < contentFinishIndex else { return nil }
        
        // Extract content between "Content_Start" and "Content_Finish"
        let contentLines = lines[(contentStartIndex + 1)..<contentFinishIndex]
        let content = contentLines.joined(separator: "\n")
        
        // Return the filename ('name'), title, content, date, and time
        return (name: filename, title: title, content: content, date: date, time: time)
    }

}




#Preview {
    ContentView()
}
