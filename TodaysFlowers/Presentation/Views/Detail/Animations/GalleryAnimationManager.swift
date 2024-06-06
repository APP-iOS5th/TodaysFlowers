//
//  GalleryAnimationManager.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/6/24.
//

import UIKit

final class GalleryAnimationManager: NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        GalleryPresentAnimator()
    }
}
