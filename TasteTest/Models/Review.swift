//
//  Review.swift
//  TasteTest
//
//  Created by Adam Sadler on 9/17/24.
//

import Foundation
import SwiftData

@Model
final class Review {
    var stars: Int
    var date: Date
    var notes: String
    var restaurant: Restaurant
    
    init(stars: Int, date: Date, notes: String, restaurant: Restaurant) {
        self.stars = stars
        self.date = date
        self.notes = notes
        self.restaurant = restaurant
    }
}
