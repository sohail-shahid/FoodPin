//
//  FoodPinApp.swift
//  FoodPin
//
//  Created by Sohail Khan on 11/07/2023.
//

import SwiftUI

@main
struct FoodPinApp: App {
    // app delegate adaptor
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @Environment(\.scenePhase) var scenePhase
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
                .onChange(of: scenePhase, perform: { phase in
                    createQuickActions()
                    switch phase {
                    case .background:
                        createQuickActions()
                    default:
                        debugPrint("Phase \(phase)")
                    }
                })
        }
    }
    
    func createQuickActions() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            let shortcutItem1 = UIApplicationShortcutItem(type: "\(bundleIdentifier).OpenFavorites", localizedTitle: "Show Favorites", localizedSubtitle : nil, icon: UIApplicationShortcutIcon(systemImageName: "tag"), userInfo: nil)
            let shortcutItem2 = UIApplicationShortcutItem(type: "\(bundleIdentifier).OpenDiscover", localizedTitle: "Discover Restaurants", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(systemImageName: "eyes"), userInfo: nil)
            let shortcutItem3 = UIApplicationShortcutItem(type: "\(bundleIdentifier).NewRestaurant", localizedTitle: "New Restaurant", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .add), userInfo: nil)
            UIApplication.shared.shortcutItems = [shortcutItem1, shortcutItem2, shortcutItem3]
        }
    }
}
