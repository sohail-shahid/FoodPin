//
//  Restaurant.swift
//  FoodPin
//
//  Created by Sohail Khan on 12/07/2023.
//

import Foundation
import Combine

class Restaurant: ObservableObject {
    var name: String
    var image: String
    var location: String
    var type: String
    var isFavorite: Bool = false
    var phone: String
    var description: String
    @Published var rating : Rating?
    
    init(name: String, image: String, location: String, type: String, isFavorite: Bool = false, phone: String,  description: String, rating: Rating?
         = nil) {
        self.name = name
        self.type = type
        self.location = location
        self.phone = phone
        self.description = description
        self.image = image
        self.isFavorite = isFavorite
        self.rating = rating
        
    }
}
