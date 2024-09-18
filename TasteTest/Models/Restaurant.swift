//
//  Item.swift
//  TasteTest
//
//  Created by Adam Sadler on 9/17/24.
//

import Foundation
import SwiftData

@Model
final class Restaurant {
    var id: Int
    var name: String
    var cuisineType: String
    var reviews: [Review] = []
    var averageRating: Double = 0.0
    
    init(name: String, cuisineType: String) {
        self.id = UUID().hashValue
        self.name = name
        self.cuisineType = cuisineType
    }
}
