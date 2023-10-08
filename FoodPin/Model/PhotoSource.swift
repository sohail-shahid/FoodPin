//
//  PhotoSource.swift
//  FoodPin
//
//  Created by Sohail khan on 08/10/2023.
//

import UIKit

//extension UIImagePickerController.SourceType: Identifiable {
//    public var id: Int {
//        hashValue
//    }
//}
//
// typealias PhotoSource = UIImagePickerController.SourceType

enum PhotoSource: Identifiable {
    case photoLibrary
    case camera

    var id: Int {
        hashValue
    }
}
