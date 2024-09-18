//
//  ReviewsView.swift
//  TasteTest
//
//  Created by Adam Sadler on 9/17/24.
//

import SwiftUI
import SwiftData

struct ReviewsView: View {
    @Environment(\.dismiss) var dismiss
    var restaurantViewModel: RestaurantViewModel
    var restaurant: Restaurant
    @Query(sort: [SortDescriptor(\Review.date, order: .reverse)]) private var reviews: [Review]
    @State var filteredReviews: [Review] = []
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Reviews (\(restaurant.reviews.count))")
                    .font(.title)
                Spacer()
            }
            .overlay (
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundStyle(Color.black)
                    }

                    Spacer()
                    Button {
                        // add a new review
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(Color.cyan)
                    }
                    .font(.title)
                }
                .padding(.horizontal)
            )
            .padding(.vertical)
            
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(Color.gray)
            
            if filteredReviews.isEmpty {
                Spacer()
                Text("No reviews yet")
                    .foregroundStyle(Color.gray)
                Spacer()
            } else {
                // list of reviews
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            filteredReviews = reviews.filter { $0.restaurant == restaurant }
        }
    }
}

#Preview {
    let previewContainer = PreviewContainer([Restaurant.self, Review.self])
    
    ReviewsView(restaurantViewModel: RestaurantViewModel(modelContainer: previewContainer.container), restaurant: Restaurant(name: "Olive Garden", cuisineType: Cuisine.italian.rawValue))
        .modelContainer(previewContainer.container)
}
