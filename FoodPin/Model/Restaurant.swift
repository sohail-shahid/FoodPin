//
//  Restaurant.swift
//  FoodPin
//
//  Created by Sohail Khan on 12/07/2023.
//

import Foundation
import Combine
import CoreData

class Restaurant: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var image: Data
    @NSManaged var location: String
    @NSManaged var type: String
    @NSManaged var isFavorite: Bool
    @NSManaged var phone: String
    @NSManaged var summary: String
    @NSManaged var ratingText: String?
    
}

extension Restaurant {
    var rating: Rating? {
        get {
            guard let ratingText = ratingText else {
                return nil
            }
            return Rating(rawValue: ratingText)
        }
        set {
            self.ratingText = newValue?.rawValue
        }
    }
}
