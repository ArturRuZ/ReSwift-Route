//
//  NavigationState.swift
//  ReSwift-Route
//
//  Created by Артур Ружников on 11.12.2021.

import Foundation
import UIKit

struct NavigationState: Codable {
   enum TransitionType: Codable {
      case goBack
      case showNext
      case showOne
   }
   let currentScreenDescription: String?
   let previousScreenDescription: String?
   let transitionType: TransitionType?
   
   init() {
      currentScreenDescription = nil
      previousScreenDescription = nil
      transitionType = nil
   }
   init(currentScreenDescription: String?, previousScreenDescription: String?, transitionType: NavigationState.TransitionType?) {
      self.currentScreenDescription = currentScreenDescription
      self.previousScreenDescription = previousScreenDescription
      self.transitionType = transitionType
   }
}
