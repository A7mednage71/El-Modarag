//
//  Sport.swift
//  Whistle
//
//  Created by Ahmed Nageh on 31/05/2026.
//

import Foundation

enum Sport: String, CaseIterable {
    case football   = "football"
    case basketball = "basketball"
    case cricket    = "cricket"
    case tennis     = "tennis"
    
    var title: String {
        switch self {
          case .football:   return AppStrings.Sports.football
          case .basketball: return AppStrings.Sports.basketball
          case .cricket:    return AppStrings.Sports.cricket
          case .tennis:     return AppStrings.Sports.tennis
        }
    }
    
    var imageName: String {
        switch self {
          case .football:   return "foot_ball"
          case .basketball: return "Basket_ball"
          case .cricket:    return "Cricket"
          case .tennis:     return "Tennis"
        }
    }
    
    var pathValue: String {
        switch self {
          case .football:   return "football"
          case .basketball: return "basketball"
          case .cricket:    return "cricket"
          case .tennis:     return "tennis"
        }
    }
}
