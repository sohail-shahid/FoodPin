//
//  RestaurantDetailView.swift
//  FoodPin
//
//  Created by CRLHL-KHANNSOH2 on 16/07/2023.
//

import SwiftUI

struct RestaurantDetailView: View {
    var restaurant: Restaurant
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                Image(restaurant.image)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 445)
                    .overlay() {
                        Image(systemName: restaurant.isFavorite ? "heart.fill" : "heart")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topTrailing)
                            .padding()
                            .font(.system(size: 30.0))
                            .foregroundColor(.white)
                            .padding(.top, 40)
                        VStack (alignment: .leading, spacing: 5.0) {
                            Text(restaurant.name)
                                .font(.custom("Nunito-Regular", size: 35.0, relativeTo: .largeTitle))
                                .bold()
                            Text(restaurant.type)
                                .font(.system(.headline, design: .rounded))
                                .padding(.all, 5)
                                .background(Color.black)
                                .padding(.bottom)
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
                        .foregroundColor(.white)
                        .padding()
                    }
                Text(restaurant.description)
                    .padding()
                HStack (alignment: .top) {
                    VStack (alignment: .leading) {
                        Text("ADDRESS")
                            .font(.system(.headline, design: .rounded))
                        Text(restaurant.location)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    VStack (alignment: .leading) {
                        Text("PHONE")
                            .font(.system(.headline, design: .rounded))
                        Text(restaurant.phone)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding(.horizontal)
            }
            .foregroundColor(.black)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Text("\(Image(systemName: "chevron.left")) \(restaurant.name)")
                }
            }
        }
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(restaurant: Restaurant(name: "Cafe Deadend", image: "cafedeadend", location: "Hong Kong", type: "Coffee & Tea Shop", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."))
    }
}