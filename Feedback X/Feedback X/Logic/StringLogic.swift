//
//  StringLogic.swift
//  Feedback X
//
//  Created by Leon  on 16.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import Foundation


struct StringLogic {
    static func writeToFile(input: String, filePath: URL) throws {
        do {
            try input.write(to: filePath, atomically: true, encoding: .utf8)
            //print("Successfully wrote to file at \(filePath.path)")
        } catch {
            //print("Error writing to file: \(error.localizedDescription)")
            throw error
        }
    }
    static func stringToList(inputString: String) -> [String] {
        // Split the string by commas and remove any leading/trailing whitespaces
        return inputString.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
    }

}
