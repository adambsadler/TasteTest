//
//  RestaurantListView.swift
//  TasteTest
//
//  Created by Adam Sadler on 9/17/24.
//

import SwiftUI

struct RestaurantListView: View {
    var restaurant: Restaurant
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 55)
                    .foregroundStyle(Color.yellow)
                    .padding(.horizontal, 10)
                
                Text(String(format: "%.1f", restaurant.averageRating))
                    .font(.title)
                    .fontDesign(.rounded)
            }
            
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.title)
                Text(restaurant.cuisineType)
                    .font(.headline)
            }
             Spacer()
            
            ZStack {
                Circle()
                    .frame(height: 50)
                    .foregroundStyle(Color.cyan)
                Text("\(restaurant.reviews.count)")
                    .font(.headline)
                    .foregroundStyle(Color.white)
            }
            .padding(.trailing)
        }
    }
}

#Preview {
    RestaurantListView(restaurant: Restaurant(name: "Olive Garden", cuisineType: Cuisine.italian.rawValue))
}
