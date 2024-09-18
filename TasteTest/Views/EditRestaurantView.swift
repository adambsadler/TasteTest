//
//  EditRestaurantView.swift
//  TasteTest
//
//  Created by Adam Sadler on 9/17/24.
//

import SwiftUI

struct EditRestaurantView: View {
    var restaurantViewModel: RestaurantViewModel
    var restaurant: Restaurant
    @State var restaurantName: String = ""
    @State var cuisineType: Cuisine = .italian
    @Binding var restaurantToEdit: Restaurant?
    
    var body: some View {
        VStack {
            Text("Edit restaurant")
                .font(.largeTitle)
                .fontDesign(.rounded)
                .padding(.top)
            
            TextField("Restaurant name", text: $restaurantName)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Picker("Cuisine type", selection: $cuisineType) {
                ForEach(Cuisine.allCases, id: \.self) { choice in
                    Text(choice.rawValue)
                }
            }
            .pickerStyle(.wheel)
            .padding()
            
            Button {
                restaurantViewModel.updateRestaurant(restaurant: restaurant, name: restaurantName, cuisineType: cuisineType.rawValue)
                restaurantToEdit = nil
            } label: {
                Text("Update restaurant")
                    .padding()
                    .padding(.horizontal)
                    .foregroundStyle(Color.white)
                    .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(restaurantName == "" ? Color.gray : Color.cyan))
            }
            .disabled(restaurant.name == "")
            
            Spacer()
        }
        .onAppear {
            restaurantName = restaurant.name
        }
    }
}

#Preview {
    let previewContainer = PreviewContainer([Restaurant.self, Review.self])
    
    EditRestaurantView(restaurantViewModel: RestaurantViewModel(modelContainer: previewContainer.container), restaurant: Restaurant(name: "Olive Garden", cuisineType: Cuisine.italian.rawValue), restaurantToEdit: .constant(Restaurant(name: "Olive Garden", cuisineType: Cuisine.italian.rawValue)))
        .modelContainer(previewContainer.container)
}
