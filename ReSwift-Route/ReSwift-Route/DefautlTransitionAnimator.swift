//
//  DefautlTransitionAnimator.swift
//
//  Created by Артур Ружников on 11.12.2021.
//

import Foundation
import UIKit

final class DefautlTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
   static let duration: TimeInterval = 1
   private let operation: UINavigationController.Operation
   
    init?(operation: UINavigationController.Operation) {
        self.operation = operation
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      guard let fromVC = transitionContext.viewController(forKey: .from),
        let toVC = transitionContext.viewController(forKey: .to),
       let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first,
        let snapshot = fromVC.view.snapshotView(afterScreenUpdates: true)
        else {
          return transitionContext.completeTransition(false)
      }
      let containerView = transitionContext.containerView
      let presentable = toVC as? TransitionAnimationPresentable
      
      switch operation {
      case .push:
         toVC.view.frame = window.frame
         toVC.view.alpha = 0
        
         let duration = transitionDuration(using: transitionContext)
//         toVC.view.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
         containerView.addSubview(snapshot)
         window.addSubview(toVC.view)

         presentable?.didStartTransition()
         
         UIView.animate(withDuration: duration,
                        animations: {
                           toVC.view.transform = .identity
                           toVC.view.alpha = 1
                        },
                        completion: { _ in
                           snapshot.removeFromSuperview()
                           transitionContext.completeTransition(true)
                      
                           presentable?.didFinishTransition()
                        })
      case .pop:
         toVC.view.frame = window.frame
         toVC.view.alpha = 0
         let duration = transitionDuration(using: transitionContext)
        
         containerView.addSubview(snapshot)
         containerView.addSubview(toVC.view)

         UIView.animate(withDuration: TimeInterval(duration),
                        animations: {
                           toVC.view.transform = .identity
                           toVC.view.alpha = 1
                        },
                        completion: { _ in
                           snapshot.removeFromSuperview()
                           transitionContext.completeTransition(true)
                        })
      
      case .none:
         break
      @unknown default:
         break
      }
    }
}
