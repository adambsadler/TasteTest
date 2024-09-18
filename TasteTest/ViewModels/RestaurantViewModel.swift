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
        print("NEW RESTAURANT ID: \(newRestaurant.id)")
        modelContainer.mainContext.insert(newRestaurant)
    }
    
    @MainActor
    func deleteRestaurant(restaurant: Restaurant) {
        modelContainer.mainContext.delete(restaurant)
    }
    
    @MainActor
    func updateRestaurant(restaurant: Restaurant, name: String, cuisineType: String) {
        restaurant.name = name
        restaurant.cuisineType = cuisineType
    }
}
