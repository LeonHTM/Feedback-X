//
//  DragSelectionHelper.swift
//  Feedback X
//
//  Created by Leon  on 12.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct DragSelectionHelper {
    /// Detects the index of an element based on the drag location.
    /// - Parameters:
    ///   - point: The CGPoint representing the drag location.
    ///   - accounts: The list of accounts to search.
    ///   - rowHeight: The height of each row in the list.
    ///   - contentWidth: The width of the content area.
    /// - Returns: The index of the element at the drag location, if any.
    static func detectIndex(from point: CGPoint, in accounts: [Account], rowHeight: CGFloat, contentWidth: CGFloat) -> Int? {
        return accounts.indices.first { index in
            let rect = CGRect(x: 0, y: CGFloat(index) * rowHeight, width: contentWidth, height: rowHeight)
            return rect.contains(point)
        }
    }
}
