//
//  AnimationTransition.swift
//  Tumblr
//
//  Created by sangho Cho on 2021/05/20.
//

import Foundation
import UIKit

class AnimationTransition: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {

  var presenting: Bool?

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

    // 애니메이션이 발생한 위치 (현재 뷰)
    let containerView = transitionContext.containerView

    // from, to 뷰
    guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
    guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }

    if let presentingValue = self.presenting {
      if presentingValue {
        // 각 from, to에 따라서 ViewController와 View를 정의
        let menuVC = toViewController as? MenuViewController
        guard let toView = menuVC?.view  else { return }

        toView.alpha = 0
        toView.frame = containerView.frame

        containerView.addSubview(toView)

        // MARK: Animation

        menuVC?.textImageView.transform = CGAffineTransform(translationX: -300, y: 0)
        menuVC?.textLabel.transform = CGAffineTransform(translationX: -300, y: 0)
        menuVC?.quoteImageView.transform = CGAffineTransform(translationX: -150, y: 0)
        menuVC?.quoteLabel.transform = CGAffineTransform(translationX: -150, y: 0)
        menuVC?.chatImageView.transform = CGAffineTransform(translationX: -50, y: 0)
        menuVC?.chatLabel.transform = CGAffineTransform(translationX: -50, y: 0)
        menuVC?.photoImageView.transform = CGAffineTransform(translationX: 300, y: 0)
        menuVC?.photoLabel.transform = CGAffineTransform(translationX: 300, y: 0)
        menuVC?.linkImageView.transform = CGAffineTransform(translationX: 150, y: 0)
        menuVC?.linkLabel.transform = CGAffineTransform(translationX: 150, y: 0)
        menuVC?.audioImageView.transform = CGAffineTransform(translationX: 50, y: 0)
        menuVC?.audioLabel.transform = CGAffineTransform(translationX: 50, y: 0)

        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
          menuVC?.textImageView.transform = CGAffineTransform.identity
          menuVC?.textLabel.transform = CGAffineTransform.identity
          menuVC?.quoteImageView.transform = CGAffineTransform.identity
          menuVC?.quoteLabel.transform = CGAffineTransform.identity
          menuVC?.chatImageView.transform = CGAffineTransform.identity
          menuVC?.chatLabel.transform = CGAffineTransform.identity
          menuVC?.photoImageView.transform = CGAffineTransform.identity
          menuVC?.photoLabel.transform = CGAffineTransform.identity
          menuVC?.linkImageView.transform = CGAffineTransform.identity
          menuVC?.linkLabel.transform = CGAffineTransform.identity
          menuVC?.audioImageView.transform = CGAffineTransform.identity
          menuVC?.audioLabel.transform = CGAffineTransform.identity
        })

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
                        toView.alpha = 1
                       }) { _ in
          transitionContext.completeTransition(true)
        }

      } else {
        let menuVC = fromViewController as? MenuViewController

        guard let fromView = menuVC?.view else { return }

        UIView.animate(withDuration: 0.5,
                       animations: {
                        fromView.alpha = 0.0
                       })

        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
          menuVC?.textImageView.transform = CGAffineTransform(translationX: -300, y: 0)
          menuVC?.textLabel.transform = CGAffineTransform(translationX: -300, y: 0)
          menuVC?.quoteImageView.transform = CGAffineTransform(translationX: -150, y: 0)
          menuVC?.quoteLabel.transform = CGAffineTransform(translationX: -150, y: 0)
          menuVC?.chatImageView.transform = CGAffineTransform(translationX: -50, y: 0)
          menuVC?.chatLabel.transform = CGAffineTransform(translationX: -50, y: 0)
          menuVC?.photoImageView.transform = CGAffineTransform(translationX: 300, y: 0)
          menuVC?.photoLabel.transform = CGAffineTransform(translationX: 300, y: 0)
          menuVC?.linkImageView.transform = CGAffineTransform(translationX: 150, y: 0)
          menuVC?.linkLabel.transform = CGAffineTransform(translationX: 150, y: 0)
          menuVC?.audioImageView.transform = CGAffineTransform(translationX: 50, y: 0)
          menuVC?.audioLabel.transform = CGAffineTransform(translationX: 50, y: 0)
        }, completion: { _ in
          transitionContext.completeTransition(true)
        })
      }
    }
  }

}
