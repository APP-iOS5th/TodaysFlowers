//
//  StringHandler.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/4/24.
//

import Foundation

struct StringHandler {
    static func separateByComma(_ target: String) -> String {
        let regex = Regex(/\.\s/)
        let replacedString = target.replacing(regex, with: ".\n\n")
        
        return replacedString
    }
}
