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
    
    enum LabelContent: String {
        case typeTitle = "꽃 자생처"
        case growTitle = "꽃 기르는 법"
        case usageTitle = "꽃 용도"
        
        case empty = ""
    }
    
    func buildLabel(by type: LabelType, with content: LabelContent) {
        switch type {
            case .title:
                self.text = content.rawValue
                self.textColor = UIColor(named: "FlowerColor")!
                self.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            case .description:
                self.numberOfLines = 0
        }
    }
}
