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

// Struct to handle device image related functionalities
struct DeviceImage {

    // Function to get the device identifier based on the hardware model
    static func getDeviceIdentifier() -> String {

        var size = 0
        // Get the size of the data required to store the hardware model name
        sysctlbyname("hw.model", nil, &size, nil, 0)

        var model = [CChar](repeating: 0, count: size)
        // Retrieve the actual hardware model name
        sysctlbyname("hw.model", &model, &size, nil, 0)

        // Identify the device based on the hardware model name
        switch String(cString: model) {
            // MacBook Air models
            case "MacBookAir9,1", "MacBookAir10,1", "Mac14,2", "Mac15,12", "Mac15,13", "Mac14,15":
                return "MacBook Air"
            // MacBook Pro models
            case "Mac16,1", "Mac16,6", "Mac16,8", "Mac16,7", "Mac16,5", "Mac15,3", "Mac15,6", "Mac15,8", "Mac15,10", "Mac15,7",
                 "Mac15,9", "Mac15,11", "Mac14,5", "Mac14,9", "Mac14,6", "Mac14,10", "Mac14,7", "MacBookPro18,3", "MacBookPro18,4",
                 "MacBookPro18,1", "MacBookPro18,2", "MacBookPro17,1", "MacBookPro16,3", "MacBookPro16,2", "MacBookPro16,1",
                 "MacBookPro16,4", "MacBookPro15,4", "MacBookPro15,1", "MacBookPro15,3", "MacBookPro15,2":
                return "MacBook Pro"
            // Mac Pro models
            case "Mac14,8", "MacPro7,1":
                return "Mac Pro"
            // iMac models
            case "Mac16,3", "Mac16,2", "Mac15,5", "Mac15,4", "iMac21,1", "iMac21,2", "iMac20,1", "iMac20,2", "iMac19,1", "iMac19,2":
                return "iMac"
            // iMac Pro model
            case "iMacPro1,1":
                return "iMac Pro"
            // Mac mini models
            case "Mac16,11", "Mac16,10", "Mac14,3", "Mac14,12", "Macmini9,1", "Macmini8,1":
                return "Mac mini"
            // Mac Studio models
            case "Mac14,13", "Mac14,14", "Mac13,1", "Mac13,2":
                return "Mac Studio"
            // Default case for unknown models
            default:
                return "Unknown Mac Device"
        }
    }

    // Function to get the device name
    static func getDeviceName() -> String {
        return Host.current().localizedName ?? "Unknown"
    }
}
