//
//  FileLoader.swift
//  Feedback X
//
//  Created by Leon  on 21.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import Foundation

struct FileLoader {
    static func loadFolderFiles(from folderURL: URL, fileLimit: Int? = nil) -> [(name: String, title: String, content: String, date: String, time: String, iteration: String, path: String, fdb: String, files: String)] {
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
            let txtFiles = fileURLs
                .filter { $0.pathExtension.lowercased() == "txt" && $0.lastPathComponent != "rewrite.txt" }
                .sorted { $0.lastPathComponent.localizedCompare($1.lastPathComponent) == .orderedDescending }

            //print("Found \(txtFiles.count) valid text files.")
            
            // Apply the limit if specified
            let limitedFiles = fileLimit != nil ? Array(txtFiles.prefix(fileLimit!)) : txtFiles
            
            return limitedFiles.compactMap { url in
                do {
                    let content = try String(contentsOf: url, encoding: .utf8)
                    return splitFile(content: content, filename: url.lastPathComponent)
                } catch {
                    print("Error reading file \(url.lastPathComponent): \(error.localizedDescription)")
                    return nil
                }
            }
        } catch {
            print("Error loading files: \(error.localizedDescription)")
            return []
        }
    }
    
    static func splitFile(content: String, filename: String) -> (name: String, title: String, content: String, date: String, time: String, iteration: String, path: String, fdb: String, files: String)? {
        let lines = content.split(separator: "\n", omittingEmptySubsequences: false)
        //print("File \(filename) has \(lines.count) lines.")
        
        //guard lines.count >= 7 else {
        //    print("File \(filename) is too short. Skipping.")
        //    return nil
        //}
        
        let title = String(lines[0])
        let date = String(lines[1])
        let time = String(lines[2])
        let iteration = String(lines[3])
        let fdb = String(lines[4])
        let path = String(lines[5])
        let files = String(lines[6])
        
        guard let contentStartIndex = lines.firstIndex(of: "Content_Start"),
              let contentFinishIndex = lines.firstIndex(of: "Content_Finish"),
              contentStartIndex < contentFinishIndex else {
                  print("File \(filename) doesn't have the expected 'Content_Start' and 'Content_Finish'. Skipping.")
                  return nil
              }
        
        let contentLines = lines[(contentStartIndex + 1)..<contentFinishIndex]
        let content = contentLines.joined(separator: "\n")
        
        //print("Parsed file: \(filename), title: \(title), date: \(date), time: \(time), itertion \(iteration), fdb \(fdb).")
        
        return (name: filename, title: title, content: content, date: date, time: time,iteration: iteration,path: path,fdb: fdb, files: files)
    }
}

