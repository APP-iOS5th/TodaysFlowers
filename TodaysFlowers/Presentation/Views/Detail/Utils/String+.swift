//
//  String+.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/12/24.
//

import UIKit

extension String {
    func lineHeight(withFontSize fontSize: CGFloat) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = fontSize / 4
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: fontSize, weight: .medium)
        ]
        
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
}
