//
//  Extensions.swift
//  Feedback X
//
//  Created by Leon  on 24.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
