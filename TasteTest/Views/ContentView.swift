//
//  ContentView.swift
//  TasteTest
//
//  Created by Adam Sadler on 9/17/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var restaurantViewModel: RestaurantViewModel
    @Query private var restaurants: [Restaurant]
    @State var isCreatingRestauruant: Bool = false

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
                        }
                        .padding(.trailing)
                        .font(.title)
                    }
                )
                .padding(.vertical)
                
                Rectangle()
                    .frame(height: 2)
                
                List {
                    ForEach(restaurants) { restuarant in
                        NavigationLink {
                            Text(restuarant.name)
                        } label: {
                            RestaurantListView(restaurant: restuarant)
                                .swipeActions(edge: .trailing) {
                                    Button {
                                        withAnimation {
                                            restaurantViewModel.deleteRestaurant(restaurant: restuarant)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.red)
                                }
                                .swipeActions(edge: .trailing) {
                                    Button {
                                        // edit
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
        }
    }
}

#Preview {
    let previewContainer = PreviewContainer([Restaurant.self, Review.self])
    
    ContentView(restaurantViewModel: RestaurantViewModel(modelContainer: previewContainer.container))
        .modelContainer(previewContainer.container)
}
