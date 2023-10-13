//
//  RestaurantCloudStore.swift
//  FoodPin
//
//  Created by Sohail Khan on 13/10/2023.
//

import CloudKit
import SwiftUI

class RestaurantCloudStore: ObservableObject {
    @Published var restaurants: [CKRecord] = []
    @Published var inProgressQuery: Bool = false
    
    func fetchRestaurants() async throws {
        let cloudContainer = CKContainer.default()
        let publicDatabase = cloudContainer.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Restaurant", predicate: predicate)
        inProgressQuery = true;
        let results = try await publicDatabase.records(matching: query)
        inProgressQuery = false;
        for record in results.matchResults {
            self.restaurants.append(try record.1.get())
        }
    }
    
    func fetchRestaurantsWithOperational() {
        let cloudContainer = CKContainer.default()
        let publicDatabase = cloudContainer.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Restaurant", predicate: predicate)
        
        let queryOperation = CKQueryOperation(query: query)
        // queryOperation.desiredKeys = ["name", "image", "type"]
        queryOperation.queuePriority = .veryHigh
        queryOperation.resultsLimit = 50
        queryOperation.recordMatchedBlock = { [weak self] (recordID, result) -> Void in
            if let restaurant = try? result.get() {
                if let _ = self?.restaurants.first(where: {$0.recordID == recordID}) {
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    self?.restaurants.append(restaurant)
                }
            }
        }
        queryOperation.queryResultBlock = { [weak self] result -> Void in
            switch result {
            case .success(_): print("Successfully retrieve the data from iCloud.")
            case .failure(let error): print("Failed to get data from iCloud -\(error.localizedDescription)")
            }
            DispatchQueue.main.async { [weak self] in
                self?.inProgressQuery = false
            }
        }
        // Execute the query
        inProgressQuery = true;
        publicDatabase.add(queryOperation)
    }
    
    func saveRecordToCloud(restaurant: Restaurant) {
        inProgressQuery = true
        let record = CKRecord(recordType: "Restaurant")
        record.setValue(restaurant.name, forKey: "name")
        record.setValue(restaurant.type, forKey: "type")
        record.setValue(restaurant.location, forKey: "location")
        record.setValue(restaurant.phone, forKey: "phone")
        record.setValue(restaurant.summary, forKey: "description")
        let imageData = restaurant.image as Data
        // Resize the image
        let originalImage = UIImage(data: imageData)!
        let scalingFactor = (originalImage.size.width > 1024) ? 1024 / originalImage.size.width : 1.0
        let scaledImage = UIImage(data: imageData, scale: scalingFactor)!
        // Write the image to local file for temporary use
        let imageFilePath = NSTemporaryDirectory() + restaurant.name
        let imageFileURL = URL(fileURLWithPath: imageFilePath)
        try? scaledImage.jpegData(compressionQuality: 0.8)?.write(to: imageFileURL)
        // Create image asset for upload
        let imageAsset = CKAsset(fileURL: imageFileURL)
        record.setValue(imageAsset, forKey: "image")
        // Get the Public iCloud Database
        let publicDatabase = CKContainer.default().publicCloudDatabase
        // Save the record to iCloud
        publicDatabase.save(record, completionHandler: { [weak self] (record, error) -> Void  in
            if error != nil {
                print(error.debugDescription)
            }
            // Remove temp file
            try? FileManager.default.removeItem(at: imageFileURL)
            DispatchQueue.main.async { [weak self] in
                self?.inProgressQuery = false
            }
        })
    }
}
