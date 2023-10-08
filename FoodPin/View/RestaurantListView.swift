//
//  RestaurantListView.swift
//  FoodPin
//
//  Created by Sohail Khan on 11/07/2023.
//

import SwiftUI

struct RestaurantListView: View {
    @State var resturants: [Restaurant] = [
        Restaurant(name: "Cafe Deadend", image: "cafedeadend", location: "Hong Kong", type: "Coffee & Tea Shop", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Homei", image: "homei", location: "Hong Kong", type: "Cafe", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Teakha", image: "teakha", location: "Hong Kong", type: "Tea House", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Cafe Loisl", image: "cafeloisl", location: "Hong Kong", type: "Austrian / Causual Drink", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Petite Oyster", image: "petiteoyster", location: "Hong Kong", type: "French", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "For Kee Restaurant", image: "forkee", location: "Hong Kong", type: "Bakery", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Po's Atelier", image: "posatelier", location: "Hong Kong", type: "Bakery", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Bourke Street Bakery", image: "bourkestreetbakery", location: "Sydney", type: "Chocolate", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Haigh's Chocolate", image: "haigh", location: "Sydney", type: "Cafe", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Palomino Espresso", image: "palomino", location: "Sydney", type: "American / Seafood", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Upstate", image: "upstate", location: "New York", type: "American", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Traif", image: "traif", location: "New York", type: "American", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Graham Avenue Meats", image: "graham", location: "New York", type: "Breakfast & Brunch", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Waffle & Wolf", image: "waffleandwolf", location: "New York", type: "Coffee & Tea", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Five Leaves", image: "fiveleaves", location: "New York", type: "Coffee & Tea", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Cafe Lore", image: "cafelore", location: "New York", type: "Latin American", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Confessional", image: "confessional", location: "New York", type: "Spanish", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Barrafina", image: "barrafina", location: "London", type: "Spanish", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Donostia", image: "donostia", location: "London", type: "Spanish", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "Royal Oak", image: "royaloak", location: "London", type: "British", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal."),
        Restaurant(name: "CASK Pub and Kitchen", image: "cask", location: "London", type: "Thai", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.")]
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(resturants.indices, id: \.self) { index in
                    NavigationLink (destination: RestaurantDetailView (restaurant: resturants[index])) {
                        BasicTextImageRow(restaurant: $resturants[index])
                            .swipeActions(edge: .leading, allowsFullSwipe: false, content: {
                                Button {
                                } label: {
                                    Image(systemName: "heart")
                                }
                                .tint(.green)
                                Button {
                                } label: {
                                    Image(systemName: "square.and.arrow.up")
                                }
                                .tint(.orange)
                            })
                    }
                }
                .onDelete(perform: { index in
                    resturants.remove(atOffsets: index)
                })
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Food Pin")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .accentColor(.white)
    }
}

struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
            .preferredColorScheme(.light)
    }
}

struct FullImageRow: View {
    var resturant: Restaurant
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            Image(resturant.image)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .cornerRadius(20)
            VStack (alignment: .leading) {
                Text(resturant.name)
                    .font(.system(.title2, design: .rounded))
                Text(resturant.type)
                    .font(.system(.body, design: .rounded))
                Text(resturant.location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
        }
    }
}

struct BasicTextImageRow: View {
    
    // MARK: - State
    @State private var showOptions = false
    @State private var showError = false
    
    // MARK: - Binding
    @Binding var restaurant: Restaurant
    
    var body: some View {
        HStack (alignment: .top, spacing: 20) {
            Image(restaurant.image)
                .resizable()
                .frame(width: 120, height: 118)
                .cornerRadius(20)
            VStack (alignment: .leading) {
                Text(restaurant.name)
                    .font(.system(.title2, design: .rounded))
                Text(restaurant.type)
                    .font(.system(.body, design: .rounded))
                Text(restaurant.location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
            if restaurant.isFavorite {
                Spacer()
                Image(systemName: "heart.fill")
                    .foregroundColor(.yellow)
            }
        }
        .contextMenu {
            Button( action: {
                self.showError.toggle()
            }) {
                HStack {
                    Text("Reserve a table")
                    Image(systemName: "phone")
                }
            }
            
            Button( action: {
                restaurant.isFavorite.toggle()
            }) {
                HStack {
                    Text(restaurant.isFavorite ? "Remove from favorites" : "Mark as favorite")
                    Image(systemName: "heart")
                }
            }
            
            Button ( action: {
                self.showOptions.toggle()
            }) {
                HStack {
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .alert("Not yet available", isPresented: $showError) {
            Button("OK") {
            }
        } message: {
            Text("Sorry, this feature is not available yet. Please retry later.")
        }
        .sheet(isPresented: $showOptions) {
            let defaultText = "Just checking in at \(restaurant.name)"
            if let imageToShare = UIImage(named: restaurant.image) {
                ActivityView(activityItems: [defaultText, imageToShare])
            } else {
                ActivityView(activityItems: [defaultText])
            }
        }
    }
}
