//
//  GalleryPresentAnimator.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/6/24.
//

import UIKit

final class GalleryPresentAnimator: NSObject {
    let transitionDuration: TimeInterval = 0.75
    
    private lazy var whiteBackgroundView: UIView = {
        let whiteBackgroundView = UIView()
        whiteBackgroundView.backgroundColor = .white
        
        return whiteBackgroundView
    }()
    
    private func makeCopy(of view: UIView, from index: Int) -> UIImageView {
        let imageView = view.subviews[index] as! UIImageView
        let copiedImageView = UIImageView(image: imageView.image)
        copiedImageView.contentMode = .scaleAspectFill
        
        return copiedImageView
    }
}
