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
    @State var isCreatingReview: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
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
                        isCreatingReview.toggle()
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
                .padding(.leading)
                
                VStack(alignment: .leading) {
                    Text(restaurant.name)
                        .font(.title)
                    Text(restaurant.cuisineType)
                        .font(.headline)
                }
                 
                Spacer()
            }
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
                List(filteredReviews) { review in
                    VStack(alignment: .leading) {
                        Text("\(DateHelper.formattedDate(review.date))")
                            .font(.headline)
                        
                        HStack {
                            ZStack {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 55)
                                    .foregroundStyle(Color.yellow)
                                    .padding(.horizontal, 10)
                                
                                Text("\(review.stars)")
                                    .font(.largeTitle)
                                    .fontDesign(.rounded)
                            }
                            
                            Text(review.notes)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            filteredReviews = reviews.filter { $0.restaurant == restaurant }
        }
        .sheet(isPresented: $isCreatingReview) {
            CreateReviewView(restaurantViewModel: restaurantViewModel, restaurant: restaurant, isCreatingReview: $isCreatingReview)
        }
        .onChange(of: isCreatingReview) {
            filteredReviews = reviews.filter { $0.restaurant == restaurant }
        }
    }
}

#Preview {
    let previewContainer = PreviewContainer([Restaurant.self, Review.self])
    
    ReviewsView(restaurantViewModel: RestaurantViewModel(modelContainer: previewContainer.container), restaurant: Restaurant(name: "Olive Garden", cuisineType: Cuisine.italian.rawValue))
        .modelContainer(previewContainer.container)
}
