//
//  StringtoList.swift
//  Feedback X
//
//  Created by Leon  on 22.12.2024.
//  Copyright © 2024 LeonHTM. All rights reserved.
//

import Foundation

func stringToList(inputString: String) -> [String] {
    // Split the string by commas and remove any leading/trailing whitespaces
    return inputString.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
}

