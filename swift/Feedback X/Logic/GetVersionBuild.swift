//
//  GetVersionBuild.swift
//  Feedback X
//
//  Created by Leon  on 08.02.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import Foundation
import SwiftUI

struct VersionBuild {
    static func getAppVersion() -> String {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            print("App Version: \(appVersion)") // Debug print
            return appVersion
        }
        return "Unknown"
    }
    
    static func getBuildNumber() -> String {
        if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            print("Build Number: \(buildNumber)") // Debug print
            return buildNumber
        }
        return "Unknown"
    }
}
