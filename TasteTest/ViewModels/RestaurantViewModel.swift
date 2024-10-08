//
//  RestaurantViewModel.swift
//  TasteTest
//
//  Created by Adam Sadler on 9/17/24.
//

import Foundation
import SwiftData

@Observable
class RestaurantViewModel {
    var modelContainer: ModelContainer
    
    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }
    
    @MainActor
    func addRestaurant(name: String, cuisineType: String) {
        let newRestaurant = Restaurant(name: name, cuisineType: cuisineType)
        modelContainer.mainContext.insert(newRestaurant)
    }
    
    @MainActor
    func deleteRestaurant(restaurant: Restaurant) {
        for review in restaurant.reviews {
            modelContainer.mainContext.delete(review)
        }
        modelContainer.mainContext.delete(restaurant)
    }
    
    @MainActor
    func updateRestaurant(restaurant: Restaurant, name: String, cuisineType: String) {
        restaurant.name = name
        restaurant.cuisineType = cuisineType
    }
    
    @MainActor
    func addReview(restaurant: Restaurant, rating: Int, reviewText: String, reviewDate: Date) {
        let newReview = Review(stars: rating, date: reviewDate, notes: reviewText, restaurant: restaurant)
        modelContainer.mainContext.insert(newReview)
        updateRestaurantRating(restaurant: restaurant, review: newReview)
    }
    
    @MainActor
    func updateRestaurantRating(restaurant: Restaurant, review: Review) {
        restaurant.reviews.append(review)
        restaurant.averageRating = Double(restaurant.reviews.reduce(0) { $0 + $1.stars }) / Double(restaurant.reviews.count)
        
        guard let date = restaurant.lastReview else {
            restaurant.lastReview = review.date
            return
        }
        
        if date < review.date {
            restaurant.lastReview = review.date
        }
    }
}
