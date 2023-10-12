//
//  FoodPinApp.swift
//  FoodPin
//
//  Created by Sohail Khan on 11/07/2023.
//

import SwiftUI

@main
struct FoodPinApp: App {
    let persistenceController = PersistenceController.shared
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        let titleColor = UIColor(named: "NavigationBarTitle") ?? UIColor.systemRed
        // UIColor(red: 218.0, green: 96.0, blue: 51.0)
        let fontName = "ArialRoundedMTBold"
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor, .font: UIFont(name: fontName, size: 35)!]
        navBarAppearance.titleTextAttributes = [.foregroundColor: titleColor, .font: UIFont(name: fontName, size: 20)!]
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.backgroundEffect = .none
        navBarAppearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
