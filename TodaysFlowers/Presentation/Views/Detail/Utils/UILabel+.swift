//
//  UILabel+.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/4/24.
//

import UIKit

extension UILabel {
    enum LabelType {
        case title
        case description
    }
    
    func buildLabel(by type: LabelType, with content: String) {
        switch type {
            case .title:
                self.text = content
                self.textColor = UIColor(named: "FlowerColor")!
                self.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            case .description:
                self.text = content
                self.font = UIFont.systemFont(ofSize: 16, weight: .light)
                self.numberOfLines = 0
        }
    }
}
