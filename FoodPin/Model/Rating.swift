//
//  Rating.swift
//  FoodPin
//
//  Created by Sohail Khan on 02/08/2023.
//

import Foundation

enum Rating: String, CaseIterable {
    case awesome, good, okay, bad, trrible
    
    var image: String {
        switch self {
        case .awesome:
            return "love"
        case .good:
            return "cool"
        case .okay:
            return "happy"
        case .bad:
            return "sad"
        case .trrible:
            return "angry"
        }
    }
}
