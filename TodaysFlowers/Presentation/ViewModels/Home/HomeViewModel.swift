//
//  HomeViewModel.swift
//  TodaysFlowers
//
//  Created by 황민경 on 6/10/24.
//

import UIKit
import Combine
import Foundation

class HomeViewModel: ObservableObject {
    @Published var flowers: [Flower] = []
    
    init() {
        loadFlowers()
    }
    
    func loadFlowers() {
        flowers = [
            Flower(
                id: 1,
                name: "아젤레아",
                lang: "사랑의 기쁨",
                content: "Some content",
                type: "Some type",
                grow: "Some grow information",
                usage: "Some usage",
                imageData: [UIImage.assetToData("sample_flower1.jpeg")], // Some image data
                date: Date()
            ),
            Flower(
                id: 15,
                name: "온시디움",
                lang: "순박한 마음",
                content: "Some content",
                type: "Some type",
                grow: "Some grow information",
                usage: "Some usage",
                imageData: [UIImage.assetToData("sample_flower4.jpeg")], // Some image data
                date: Date.retrieveDateFromToday(by: 1)
            )
        ]
    }
}
