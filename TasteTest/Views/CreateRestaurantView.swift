//
//  CreateRestaurantView.swift
//  TasteTest
//
//  Created by Adam Sadler on 9/17/24.
//

import SwiftUI

struct CreateRestaurantView: View {
    var restaurantViewModel: RestaurantViewModel
    @State var restaurantName: String = ""
    @State var cuisineType: Cuisine = .italian
    @Binding var isCreatingRestaurant: Bool
    
    var body: some View {
        VStack {
            Text("Add a restaurant")
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
                restaurantViewModel.addRestaurant(name: restaurantName, cuisineType: cuisineType.rawValue)
                isCreatingRestaurant.toggle()
            } label: {
                Text("Add restaurant")
                    .padding()
                    .padding(.horizontal)
                    .foregroundStyle(Color.white)
                    .background(RoundedRectangle(cornerRadius: 8).foregroundStyle(restaurantName == "" ? Color.gray : Color.cyan))
            }
            .disabled(restaurantName == "")

            
            Spacer()
        }
    }
}

#Preview {
    let previewContainer = PreviewContainer([Restaurant.self, Review.self])
    
    CreateRestaurantView(restaurantViewModel: RestaurantViewModel(modelContainer: previewContainer.container), isCreatingRestaurant: .constant(true))
        .modelContainer(previewContainer.container)
}
