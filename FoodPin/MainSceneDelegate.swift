//
//  MainSceneDelegate.swift
//  FoodPin
//
//  Created by Sohail Khan on 17/10/2023.
//

import UIKit
import SwiftUI

final class MainSceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    @Environment(\.openURL) private var openURL: OpenURLAction
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(handleQuickAction(shortcutItem: shortcutItem))
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let shortcutItem = connectionOptions.shortcutItem else {
            return
    }
        handleQuickAction(shortcutItem: shortcutItem)
    }
    
    @discardableResult private func handleQuickAction(shortcutItem: UIApplicationShortcutItem)-> Bool {
        let shortcutType = shortcutItem.type
        guard let shortcutIdentifier = shortcutType.components(separatedBy: ".").last else {
            return false
        }
        guard let url = URL(string: "foodpinapp://actions/" + shortcutIdentifier) else {
            print("Failed to initiate the url")
            return false
        }
        openURL(url)
        return true
    }
}
