//
//  OnineCheck.swift
//  Feedback X
//
//  Created by Leon  on 04.01.2025.
//  Copyright © 2025 LeonHTM. All rights reserved.
//

import Foundation

struct OnlineCheck {
    static func checkGoogle(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://google.com") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        
        URLSession(configuration: .default)
            .dataTask(with: request) { (_, response, error) in
                if let error = error {
                    print("Error:", error)
                    completion(false)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    completion(true)
                } else {
                    completion(false)
                }
            }
            .resume()
    }
}