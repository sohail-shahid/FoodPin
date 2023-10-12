//
//  WebLink.swift
//  FoodPin
//
//  Created by Sohail Khan on 12/10/2023.
//

import Foundation

enum WebLink: String {
    case rateUs = "https://www.apple.com/ios/app-store"
    case feedback = "https://www.appcoda.com/contact"
    case twitter = "https://www.twitter.com/appcodamobile"
    case facebook = "https://www.facebook.com/appcodamobile"
    case instagram = "https://www.instagram.com/appcodadotcom"
}

extension WebLink: Identifiable {
    var id: UUID {
        UUID()
    }
}
