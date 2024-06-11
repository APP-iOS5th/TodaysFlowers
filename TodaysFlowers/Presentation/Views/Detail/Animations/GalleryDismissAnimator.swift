//
//  GalleryDismissAnimator.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/6/24.
//

import UIKit

final class GalleryDismissAnimator: NSObject {
    private let transitionDuration: TimeInterval = 0.3
    
    private func makeCopy(of view: UIView, from index: Int) -> UIImageView {
        let imageView = view.subviews[index] as! UIImageView
        let copiedImageView = UIImageView(image: imageView.image)
        copiedImageView.contentMode = .scaleAspectFill
        copiedImageView.clipsToBounds = true
        
        return copiedImageView
    }
}

extension GalleryDismissAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        transitionDuration
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let fromView = transitionContext.viewController(forKey: .from) as! ImageGalleryViewController
        let toView = transitionContext.viewController(forKey: .to) as! DetailViewController
        let imageScrollView = fromView.imageScrollView
        let currentPage = fromView.pageControl.currentPage
        
        let copiedImageView = makeCopy(
            of: imageScrollView,
            from: currentPage
        )
        copiedImageView.frame = fromView.view.convert(imageScrollView.frame, to: nil)

        fromView.view.hideAllSubviews()
        
        let destinationFrame = calculateDestinationFrame(
            with: toView.flowerContentView.imageScrollView.convert(
                toView.flowerContentView.imageScrollView.frame, to: nil
            )
        )
        
        containerView.subviews.forEach { $0.removeFromSuperview() }
        containerView.addSubview(copiedImageView)
        toView.flowerContentView.updateCurrentPage(to: fromView.pageControl.currentPage)
        
        runShrinkAnimator(for: copiedImageView, to: destinationFrame) {
            transitionContext.completeTransition(true)
        }
    }
    
    private func calculateDestinationFrame(with rect: CGRect) -> CGRect {
        CGRect(
            origin: CGPoint(
                x: 0,
                y: rect.origin.y
            ),
            size: rect.size
        )
    }
    
    private func runShrinkAnimator(
        for view: UIView,
        to frame: CGRect,
        completion: @escaping () -> ()
    ) {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: transitionDuration,
            delay: .zero
        ) {
            view.frame = frame
        } completion: { _ in
            completion()
        }
    }
}
