//
//  TestView.swift
//  Feedback X
//
//  Created by Leon  on 08.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import SwiftUI

struct TestView: View {
    
    
    func convertToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.M.yyyy" // No leading zeros
        return dateFormatter.date(from: dateString)
    }
    
    let dateSaveNow = Date().formatted(Date.FormatStyle()
            .day(.defaultDigits)
            .month(.defaultDigits)
            .year())
    
    var body: some View {
        if let cookieDate = convertToDate(dateString: "7.1.2025"),
             let currentDate = convertToDate(dateString: dateSaveNow) {
              
              
              if currentDate >= cookieDate{
                  Text("Cookies Expired")
                      .fontWeight(.bold)
                      .font(.title3)
                      .padding(.leading, 15)
                      .padding(.vertical, 10)
                      .padding(.bottom, -10)
                  
                  
                  
                  VStack(alignment: .center, spacing: 10) {
                      HStack {
                          Spacer()
                          Image(systemName: "exclamationmark.circle.fill")
                              .font(.system(size: 25))
                              .foregroundColor(.yellow)
                          Spacer()
                      }
                      Text("Cookies for this Account have expired.")
                          .font(.title3)
                      Text("The Cookies for this account have expired. Feedback X can not perform any duplications on this account anymore. Please renew the cookies in the cookies section..")
                          .foregroundStyle(.secondary)
                          .multilineTextAlignment(.center)
                  }
                  .padding(10)
                  .background(
                     RoundedRectangle(cornerRadius: 15)
                         .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                         .fill(Color.gray.opacity(0.1))
                  )
                  .padding(.horizontal, 10)
              }else{
                  
                  Text("your mom").padding()
              }
        }
    }
}

#Preview {
    TestView()
}
