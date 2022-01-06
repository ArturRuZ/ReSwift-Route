//
//  Router.swift
//  ReSwift-Route
//
//  Created by Артур Ружников on 11.12.2021.
//

import Foundation
import UIKit
import ReSwift

extension Router {
   enum RouterMode {
      case supportedRoutes([String])
      case excludedRoutes([String])
      case all
   }
}

final class Router {
   var rootController: UINavigationController
   private let mode: RouterMode
   
   private  func navigateWithRemovingOvers(to: UIViewController) {
      pushWithTransitionIfNeeded(to)
      rootController.viewControllers.removeAll(where: {$0 != to})
   }
   private  func navigate(to: UIViewController) {
      pushWithTransitionIfNeeded(to)
   }
   private  func popFromCurrentController() {
      rootController.popViewController(animated: true)
   }
   
   private func pushWithTransitionIfNeeded(_ to: UIViewController) {
      if let transitionPresenter = rootController.viewControllers.last as? TransitionAnimationPresenter,
         let presentable = to as? TransitionAnimationPresentable {
         transitionPresenter.present(controller: presentable)
      } else {
         rootController.pushViewController(to, animated: true)
      }
   }
   
   init(_ mode: RouterMode) {
      self.mode = mode
      rootController = UINavigationController()
      rootController.navigationBar.isHidden = true
   }
   
   init(_ mode: RouterMode, _ with: UIViewController) {
      self.mode = mode
      rootController = UINavigationController()
      rootController.navigationBar.isHidden = true
      navigateWithRemovingOvers(to: with)
   }
}

extension Router {
   func reduce(_ action: Action, _ state: NavigationState?) -> NavigationState {
      let currentState = state ?? NavigationState()
      
      guard let creator = action as? RoutingCreator else { return currentState }
      
      switch self.mode {
      case .supportedRoutes(let routes):
         guard routes.contains(type(of: creator).description) else { return currentState }
      case .excludedRoutes(let routes):
         guard !routes.contains(type(of: creator).description) else { return currentState }
      case .all:
         break
      }
      
      switch creator.routingAction.route {
      case .goBack:
         let newState = NavigationState(currentScreenDescription: currentState.previousScreenDescription,
                                        previousScreenDescription: currentState.currentScreenDescription,
                                        transitionType: creator.routingAction.route.transitionForState)
         self.popFromCurrentController()
         return newState
      case .showNext(destination: let destination):
         let vc = destination.init()
         let newState = NavigationState(currentScreenDescription: vc.description,
                                        previousScreenDescription: currentState.currentScreenDescription,
                                        transitionType: creator.routingAction.route.transitionForState)
         
         self.navigate(to: vc)
         return newState
      case .showSingle(destination: let destination):
         let vc = destination.init()
         self.navigateWithRemovingOvers(to: vc)
         let newState = NavigationState(currentScreenDescription: vc.description,
                                        previousScreenDescription: currentState.currentScreenDescription,
                                        transitionType: creator.routingAction.route.transitionForState)
       
         return newState
      }
   }
}

