//
//  CreateReviewView.swift
//  TasteTest
//
//  Created by Adam Sadler on 9/18/24.
//

import SwiftUI

struct CreateReviewView: View {
    var restaurantViewModel: RestaurantViewModel
    var restaurant: Restaurant
    @Binding var isCreatingReview: Bool
    @State var rating: Int = 0
    @State var reviewText: String = ""
    
    var body: some View {
        VStack {
            Text("Review for \(restaurant.name)")
                .font(.title)
                .fontDesign(.rounded)
                .padding(.top)
            
            HStack {
                ForEach(1..<6) { index in
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(index <= rating ? Color.yellow : Color.gray)
                        .opacity(index <= rating ? 1 : 0.25)
                        .onTapGesture {
                            if index == 1 && rating == 1 {
                                rating = 0
                            } else {
                                rating = index
                            }
                        }
                }
            }
            .padding(.vertical)
            
            TextEditor(text: $reviewText)
                .frame(height: 200)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal)
            
            Button {
                restaurantViewModel.addReview(restaurant: restaurant, rating: rating, reviewText: reviewText)
                isCreatingReview.toggle()
            } label: {
                Text("Add review")
                    .padding()
                    .padding(.horizontal)
                    .foregroundStyle(Color.white)
                    .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(reviewText == "" ? Color.gray : Color.cyan))
            }
            .disabled(reviewText == "")
            .padding(.vertical)
            
            Spacer()
        }
    }
}

#Preview {
    let previewContainer = PreviewContainer([Restaurant.self, Review.self])
    
    CreateReviewView(restaurantViewModel: RestaurantViewModel(modelContainer: previewContainer.container), restaurant: Restaurant(name: "Olive Garden", cuisineType: Cuisine.italian.rawValue), isCreatingReview: .constant(true))
        .modelContainer(previewContainer.container)
}
