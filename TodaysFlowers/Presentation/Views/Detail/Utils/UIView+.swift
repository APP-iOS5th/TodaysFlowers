//
//  UIView+.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/6/24.
//

import UIKit

extension UIView {
    func hideAllSubviews() {
        self.subviews.forEach { $0.isHidden = true }
        self.backgroundColor = .clear
    }
    
    func showAllSubviews(with backgroundColor: UIColor = .white) {
        self.subviews.forEach { $0.isHidden = false }
        self.backgroundColor = backgroundColor
    }
}
