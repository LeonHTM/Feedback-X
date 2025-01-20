//
//  HelpFeedbackFailedView.swift
//  Feedback X
//
//  Created by Leon  on 20.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct HelpFeedbackFailedView: View {
    @Binding var selectedPage: String
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    @Previewable @State var text = "Hello, World!"
    HelpFeedbackFailedView(selectedPage: $text)
}
