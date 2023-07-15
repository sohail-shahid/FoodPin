//
//  RestaurantListView.swift
//  FoodPin
//
//  Created by CRLHL-KHANNSOH2 on 11/07/2023.
//

import SwiftUI

struct RestaurantListView: View {
    @State var resturants: [Restaurant] = [
        Restaurant(name: "Cafe Deadend", image: "cafedeadend", location: "Hong Kong", type: "Coffee & Tea Shop", isFavorite: false),
        Restaurant(name: "Homei", image: "homei", location: "Hong Kong", type: "Cafe", isFavorite: false),
        Restaurant(name: "Teakha", image: "teakha", location: "Hong Kong", type: "Tea House", isFavorite: false),
        Restaurant(name: "Cafe Loisl", image: "cafeloisl", location: "Hong Kong", type: "Austrian / Causual Drink", isFavorite: false),
        Restaurant(name: "Petite Oyster", image: "petiteoyster", location: "Hong Kong", type: "French", isFavorite: false),
        Restaurant(name: "For Kee Restaurant", image: "forkee", location: "Hong Kong", type: "Bakery", isFavorite: false),
        Restaurant(name: "Po's Atelier", image: "posatelier", location: "Hong Kong", type: "Bakery", isFavorite: false),
        Restaurant(name: "Bourke Street Bakery", image: "bourkestreetbakery", location: "Sydney", type: "Chocolate", isFavorite: false),
        Restaurant(name: "Haigh's Chocolate", image: "haigh", location: "Sydney", type: "Cafe", isFavorite: false),
        Restaurant(name: "Palomino Espresso", image: "palomino", location: "Sydney", type: "American / Seafood", isFavorite: false),
        Restaurant(name: "Upstate", image: "upstate", location: "New York", type: "American", isFavorite: false),
        Restaurant(name: "Traif", image: "traif", location: "New York", type: "American", isFavorite: false),
        Restaurant(name: "Graham Avenue Meats", image: "graham", location: "New York", type: "Breakfast & Brunch", isFavorite: false),
        Restaurant(name: "Waffle & Wolf", image: "waffleandwolf", location: "New York", type: "Coffee & Tea", isFavorite: false),
        Restaurant(name: "Five Leaves", image: "fiveleaves", location: "New York", type: "Coffee & Tea", isFavorite: false),
        Restaurant(name: "Cafe Lore", image: "cafelore", location: "New York", type: "Latin American", isFavorite: false),
        Restaurant(name: "Confessional", image: "confessional", location: "New York", type: "Spanish", isFavorite: false),
        Restaurant(name: "Barrafina", image: "barrafina", location: "London", type: "Spanish", isFavorite: false),
        Restaurant(name: "Donostia", image: "donostia", location: "London", type: "Spanish", isFavorite: false),
        Restaurant(name: "Royal Oak", image: "royaloak", location: "London", type: "British", isFavorite: false),
        Restaurant(name: "CASK Pub and Kitchen", image: "cask", location: "London", type: "Thai", isFavorite: false)]
    
    
    var body: some View {
        List {
            ForEach(resturants.indices, id: \.self) { index in
                BasicTextImageRow(resturant: $resturants[index])
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
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
    @Binding var resturant: Restaurant
    
    var body: some View {
        HStack (alignment: .top, spacing: 20) {
            Image(resturant.image)
                .resizable()
                .frame(width: 120, height: 118)
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
            if resturant.isFavorite {
                Spacer()
                Image(systemName: "heart.fill")
                    .foregroundColor(.yellow)
            }
        }
        .onTapGesture {
            showOptions.toggle()
        }
        .confirmationDialog("What do you want to do?", isPresented: $showOptions, titleVisibility: .visible) {
            Button("Reserve a table") {
                self.showError.toggle()
            }
            
            Button(resturant.isFavorite  ? "Remove from favorites" : "Mark as favorite")  {
                resturant.isFavorite.toggle()
            }
        }
        .alert("Not yet available", isPresented: $showError) {
            Button("OK") {
            }
        } message: {
            Text("Sorry, this feature is not available yet. Please retry later.")
        }
    }
}