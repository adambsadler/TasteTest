//
//  ContentView.swift
//  TasteTest
//
//  Created by Adam Sadler on 9/17/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    enum SortType {
        case name, averageRating, mostRecentReview
    }
    
    var restaurantViewModel: RestaurantViewModel
    @Query private var restaurants: [Restaurant]
    @State var isCreatingRestauruant: Bool = false
    @State var isEditingRestaurant: Bool = false
    @State var restaurantToEdit: Restaurant?
    @State var sortType: SortType = .averageRating

    var sortedRestaurants: [Restaurant] {
        switch sortType {
        case .name:
            return restaurants.sorted(by: {$0.name < $1.name})
        case .averageRating:
            return restaurants.sorted(by: {$0.averageRating > $1.averageRating})
        case .mostRecentReview:
            return restaurants.sorted(by: { (lhs, rhs) in
                guard let lhsDate = lhs.lastReview else { return false }
                guard let rhsDate = rhs.lastReview else { return true }
                return lhsDate > rhsDate
            })
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text("Taste Test")
                        .font(.largeTitle)
                        .fontDesign(.serif)
                    Spacer()
                }
                .overlay (
                    HStack {
                        Spacer()
                        Button {
                            isCreatingRestauruant.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundStyle(Color.cyan)
                        }
                        .padding(.trailing)
                        .font(.title)
                    }
                )
                .padding(.vertical)
                
                ZStack {
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(Color.gray)
                    
                    Text("Sort By:")
                        .font(.footnote)
                        .foregroundStyle(Color.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal)
                        .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(Color.gray))
                }
                
                HStack(spacing: 10) {
                    Button {
                        sortType = .averageRating
                    } label: {
                        Text("Avg Rating")
                            .foregroundStyle(sortType == .averageRating ? Color.white : Color.black)
                    }
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(sortType == .averageRating ? Color.cyan : Color.clear))
                    
                    Button {
                        sortType = .name
                    } label: {
                        Text("Name")
                            .foregroundStyle(sortType == .name ? Color.white : Color.black)
                    }
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(sortType == .name ? Color.cyan : Color.clear))
                    
                    Button {
                        sortType = .mostRecentReview
                    } label: {
                        Text("Most Recent Review")
                            .foregroundStyle(sortType == .mostRecentReview ? Color.white : Color.black)
                    }
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(sortType == .mostRecentReview ? Color.cyan : Color.clear))
                    
                }
                .padding(.vertical, 5)
                .padding(.bottom)
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(Color.gray)
                
                List {
                    ForEach(sortedRestaurants) { restaurant in
                        NavigationLink {
                            ReviewsView(restaurantViewModel: restaurantViewModel, restaurant: restaurant)
                        } label: {
                            RestaurantListView(restaurant: restaurant)
                                .swipeActions(edge: .trailing) {
                                    Button {
                                        withAnimation {
                                            restaurantViewModel.deleteRestaurant(restaurant: restaurant)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.red)
                                }
                                .swipeActions(edge: .trailing) {
                                    Button {
                                        restaurantToEdit = restaurant
                                        isEditingRestaurant.toggle()
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                    .tint(.gray)
                                }
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            }
            .sheet(isPresented: $isCreatingRestauruant) {
                CreateRestaurantView(restaurantViewModel: restaurantViewModel, isCreatingRestaurant: $isCreatingRestauruant)
            }
            .sheet(isPresented: $isEditingRestaurant) {
                if let restaurant = restaurantToEdit {
                    EditRestaurantView(restaurantViewModel: restaurantViewModel, restaurant: restaurant, isEditingRestaurant: $isEditingRestaurant)
                }
            }
        }
    }
}

#Preview {
    let previewContainer = PreviewContainer([Restaurant.self, Review.self])
    
    ContentView(restaurantViewModel: RestaurantViewModel(modelContainer: previewContainer.container))
        .modelContainer(previewContainer.container)
}
