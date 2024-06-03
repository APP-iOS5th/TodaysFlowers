//
//  Flower.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/3/24.
//

import Foundation

struct Flower: Identifiable, Hashable {
    let id: Int
    let name: String
    let lang: String
    let type: String
    let grow: String
    let usage: String
    let imageData: [Data]
    let date: Date
}
