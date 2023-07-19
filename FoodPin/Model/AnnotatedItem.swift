//
//  AnnotatedItem.swift
//  FoodPin
//
//  Created by Sohail Khan on 19/07/2023.
//

import Foundation
import MapKit

struct AnnotatedItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}
