//
//  MainView.swift
//  FoodPin
//
//  Created by Sohail Khan on 12/10/2023.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTabIndex = 0
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            RestaurantListView()
                .tabItem {
                    Label("Favorites", systemImage: "tag.fill")
                }
                .tag(0)
            DiscoverView()
                .tabItem {
                    Label("Discover", systemImage: "wand.and.rays")
                }
                .tag(1)
            
            AboutView()
                .tabItem {
                    Label("About", systemImage: "square.stack")
                }
                .tag(2)
        }
        .onOpenURL(perform: { url in
            switch url.path {
                case "/OpenFavorites": selectedTabIndex = 0
                case "/OpenDiscover": selectedTabIndex = 1
                case "/NewRestaurant": selectedTabIndex = 0
                default: return
                }
        })
        .accentColor(Color("NavigationBarTitle"))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environment(\.locale, .init(identifier: "de"))
    }
}
