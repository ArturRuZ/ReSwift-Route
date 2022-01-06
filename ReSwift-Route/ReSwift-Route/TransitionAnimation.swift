//
//  AnimationTransitionPresenter.swift
//  ReSwift-Route
//
//  Created by Артур Ружников on 11.12.2021.

import UIKit

protocol TransitionAnimationPresenter: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
   func present(controller: TransitionAnimationPresentable)
}

extension TransitionAnimationPresenter where Self: UIViewController {
   func present(controller: TransitionAnimationPresentable) {
      navigationController?.delegate = self
      navigationController?.pushViewController(controller, animated: true)
   }
//   func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//   }
}

protocol TransitionAnimationPresentable where Self: UIViewController {
   func didFinishTransition()
   func didStartTransition()
}
