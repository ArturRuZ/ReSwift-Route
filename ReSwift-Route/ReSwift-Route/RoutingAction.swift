//
//  NavigationActions.swift
//  ReSwift-Route
//
//  Created by Артур Ружников on 11.12.2021.

import UIKit
import ReSwift

class RoutingAction: Action {
   enum RoutingType {
      case goBack
      case showNext(destination: UIViewController.Type)
      case showSingle(destination: UIViewController.Type)
      
      var transitionForState: NavigationState.TransitionType {
         switch self {
         case .goBack:
            return .goBack
         case .showNext:
            return .showNext
         case .showSingle:
            return .showOne
         }
      }
      
   }
   let route: RoutingType
   
   init(_ route: RoutingType) {
      self.route = route
   }
}

