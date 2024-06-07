//
//  GalleryPresentAnimator.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/6/24.
//

import UIKit

final class GalleryPresentAnimator: NSObject {
    let transitionDuration: TimeInterval = 0.5
    
    private lazy var whiteBackgroundView: UIView = {
        let whiteBackgroundView = UIView()
        whiteBackgroundView.backgroundColor = .white
        
        return whiteBackgroundView
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = 0
        
        return blurView
    }()
    
    private func makeCopy(of view: UIView, from index: Int) -> UIImageView {
        let imageView = view.subviews[index] as! UIImageView
        let copiedImageView = UIImageView(image: imageView.image)
        copiedImageView.contentMode = .scaleAspectFill
        
        return copiedImageView
    }
}

extension GalleryPresentAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        transitionDuration
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        containerView.subviews.forEach { $0.removeFromSuperview() }
        
        containerView.addSubview(blurView)
        containerView.addSubview(whiteBackgroundView)
        
        blurView.frame = containerView.frame
        
        let fromView = transitionContext.viewController(forKey: .from) as! DetailViewController
        let toView = transitionContext.viewController(forKey: .to) as! ImageGalleryViewController
        let imageScrollView = fromView.flowerContentView.imageScrollView
        let currentPage = fromView.flowerContentView.pageControl.currentPage
        
        let copiedCurrentImageView = makeCopy(
            of: imageScrollView,
            from: currentPage
        )
        containerView.addSubview(copiedCurrentImageView)
        imageScrollView.isHidden = true
        
        // TODO: Change frame calculation logic
        var copiedImageViewFrame = imageScrollView.convert(imageScrollView.frame, to: nil)
        copiedImageViewFrame.origin.x = 0
        copiedCurrentImageView.frame = copiedImageViewFrame
        whiteBackgroundView.frame = copiedImageViewFrame
        
        containerView.addSubview(toView.view)
        toView.view.hideAllSubviews()
        toView.view.layoutIfNeeded()
        
        let yOriginOfToView = toView.imageScrollView.frame.origin.y
        
        runExpandAnimator(
            for: copiedCurrentImageView,
            in: containerView,
            yOrigin: yOriginOfToView
        ) {
            toView.pageControl.currentPage = currentPage
            toView.view.showAllSubviews()
            imageScrollView.isHidden = false
            copiedCurrentImageView.removeFromSuperview()
            self.whiteBackgroundView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
    
    private func runExpandAnimator(
        for view: UIImageView,
        in containerView: UIView,
        yOrigin: CGFloat,
        completion: @escaping () -> ()
    ) {
        let springTiming = UISpringTimingParameters(dampingRatio: 0.8)
        let animator = UIViewPropertyAnimator(duration: transitionDuration, timingParameters: springTiming)
        
        animator.addAnimations {
            self.blurView.alpha = 1
            view.frame.origin.y = yOrigin
            self.whiteBackgroundView.frame = containerView.frame
            containerView.layoutIfNeeded()
        }
        
        animator.addCompletion { _ in
            completion()
        }
        
        animator.startAnimation()
    }
}
