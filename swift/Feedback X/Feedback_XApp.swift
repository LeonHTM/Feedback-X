//
//  Feedback_XApp.swift
//  Feedback X
//
//  Created by Leon  on 10.12.2024fire
//

import SwiftUI

@main
struct Feedback_XApp: App {
    var body: some Scene {
        WindowGroup {
            CreateFeedback()
                .frame(minWidth: 700, idealWidth: 925,  minHeight: 360-28, idealHeight:625)
        }
            
    }
}
