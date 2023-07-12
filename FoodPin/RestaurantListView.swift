//
//  RestaurantListView.swift
//  FoodPin
//
//  Created by CRLHL-KHANNSOH2 on 11/07/2023.
//

import SwiftUI

struct RestaurantListView: View {
    let resturants: [Restaurant] = [
        Restaurant(name: "Cafe Deadend", image: "cafedeadend", location: "Hong Kong", type: "Coffee & Tea Shop"),
        Restaurant(name: "Homei", image: "homei", location: "Hong Kong", type: "Cafe"),
        Restaurant(name: "Teakha", image: "teakha", location: "Hong Kong", type: "Tea House"),
        Restaurant(name: "Cafe Loisl", image: "cafeloisl", location: "Hong Kong", type: "Austrian / Causual Drink"),
        Restaurant(name: "Petite Oyster", image: "petiteoyster", location: "Hong Kong", type: "French"),
        Restaurant(name: "For Kee Restaurant", image: "forkee", location: "Hong Kong", type: "Bakery"),
        Restaurant(name: "Po's Atelier", image: "posatelier", location: "Hong Kong", type: "Bakery"),
        Restaurant(name: "Bourke Street Bakery", image: "bourkestreetbakery", location: "Sydney", type: "Chocolate"),
        Restaurant(name: "Haigh's Chocolate", image: "haigh", location: "Sydney", type: "Cafe"),
        Restaurant(name: "Palomino Espresso", image: "palomino", location: "Sydney", type: "American / Seafood"),
        Restaurant(name: "Upstate", image: "upstate", location: "New York", type: "American"),
        Restaurant(name: "Traif", image: "traif", location: "New York", type: "American"),
        Restaurant(name: "Graham Avenue Meats", image: "graham", location: "New York", type: "Breakfast & Brunch"),
        Restaurant(name: "Waffle & Wolf", image: "waffleandwolf", location: "New York", type: "Coffee & Tea"),
        Restaurant(name: "Five Leaves", image: "fiveleaves", location: "New York", type: "Coffee & Tea"),
        Restaurant(name: "Cafe Lore", image: "cafelore", location: "New York", type: "Latin American"),
        Restaurant(name: "Confessional", image: "confessional", location: "New York", type: "Spanish"),
        Restaurant(name: "Barrafina", image: "barrafina", location: "London", type: "Spanish"),
        Restaurant(name: "Donostia", image: "donostia", location: "London", type: "Spanish"),
        Restaurant(name: "Royal Oak", image: "royaloak", location: "London", type: "British"),
        Restaurant(name: "CASK Pub and Kitchen", image: "cask", location: "London", type: "Thai")]
    
    var body: some View {
        List {
            ForEach(resturants, id: \.self) { resturant in
                BasicTextImageRow(resturant: resturant)
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
                .frame(width: .infinity)
                .cornerRadius(20)
                .aspectRatio(contentMode: .fit)
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
    var resturant: Restaurant
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
        }
    }
}
