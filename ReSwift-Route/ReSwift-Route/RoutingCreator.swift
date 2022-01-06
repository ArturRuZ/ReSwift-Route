//
//  RoutingCreater.swift
//  ReSwift-Route
//
//  Created by Артур Ружников on 11.12.2021.

import Foundation
import ReSwift

protocol RoutingCreator: Action {
   static var description: String {get}
   var routingAction: RoutingAction {get}
}
