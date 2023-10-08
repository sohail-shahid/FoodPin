//
//  ReviewView.swift
//  FoodPin
//
//  Created by Sohail Khan on 01/08/2023.
//

import SwiftUI

struct ReviewView: View {
    var restaurant: Restaurant
    @Binding var isDisplayed: Bool
    @State var showRating: Bool = false
    
    var body: some View {
        ZStack {
            Image(restaurant.image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea()
            Color.black
                .opacity(0.5)
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        withAnimation(.easeOut(duration: 0.3)) {
                            self.isDisplayed = false
                        }
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 30.0))
                            .foregroundColor(.white)
                            .padding()
                    })
                    Spacer()
                }
                .padding(.top, 20)
            }
            VStack (alignment: .leading) {
                ForEach (Rating.allCases, id: \.self) { rating in
                    HStack {
                        Image(rating.image)
                        Text(rating.rawValue.capitalized)
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .opacity(showRating ? 1.0 : 0.0)
                    .offset(x: showRating ? 0 : 1000)
                    .animation(.easeOut.delay(Double(Rating.allCases.firstIndex(of: rating)!) * 0.05), value: showRating)
                    .onTapGesture {
                        restaurant.rating = rating
                        isDisplayed = false
                    }
                }
            }
        }
        .onAppear() {
            showRating.toggle()
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(restaurant: Restaurant(name: "Cafe Deadend", image: "cafedeadend", location: "Hong Kong", type: "Coffee & Tea Shop", isFavorite: false, phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", rating: .awesome), isDisplayed: .constant(true))
    }
}
