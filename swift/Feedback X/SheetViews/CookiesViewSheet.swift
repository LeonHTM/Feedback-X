//
//  CookiesViewSheet.swift
//  Feedback X
//
//  Created by Leon  on 05.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct CookiesViewSheet: View {
    
    @State var waitingTime: Double = 20
    
    
    var body: some View {
        Text(String(waitingTime))
            .foregroundStyle(ColorForWaitingTime.colorMatch(waitingTime,maxTime:waitingTime))
    }
}

#Preview {
    CookiesViewSheet()
}
