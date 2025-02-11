//
//  ColorforWaitingTime.swift
//  Feedback X
//
//  Created by Leon  on 05.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

public struct ColorForWaitingTime {
    static func colorMatch(_ time: Double, maxTime: Double = 100) -> Color {
        let clampedTime = max(20, min(maxTime, time)) // Clamp time to the range 20...maxTime
        let progress = (clampedTime - 20) / (maxTime - 20) // Normalize to 0.0 (20) to 1.0 (maxTime)

        // Transition logic
        let red: Double
        let green: Double

        if progress <= 0.5 {
            // Transition from Red to Yellow (0.0 to 0.5)
            red = 1.0
            green = 2 * progress
        } else {
            // Transition from Yellow to Green (0.5 to 1.0)
            red = 2 * (1.0 - progress)
            green = 1.0
        }

        return Color(red: red, green: green, blue: 0.0)
    }
}


