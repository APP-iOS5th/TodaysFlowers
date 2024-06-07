//
//  GalleryDismissAnimator.swift
//  TodaysFlowers
//
//  Created by jinwoong Kim on 6/6/24.
//

import UIKit

final class GalleryDismissAnimator: NSObject {
    let transitionDuration: TimeInterval = 0.3
    
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
        
        let copiedImageView = makeCopy(
            of: fromView.imageScrollView,
            from: fromView.pageControl.currentPage
        )
        copiedImageView.frame = fromView.view.convert(fromView.imageScrollView.frame, to: nil)

        fromView.view.hideAllSubviews()
        
        var destinationFrame = calculateDestinationFrame(with: toView.flowerContentView.imageScrollView.convert(toView.flowerContentView.imageScrollView.frame, to: nil))
        destinationFrame.origin.x = 0
        
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
