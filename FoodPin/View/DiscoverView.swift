//
//  DiscoverView.swift
//  FoodPin
//
//  Created by Sohail Khan on 13/10/2023.
//

import SwiftUI
import CloudKit

struct DiscoverView: View {
    
    @StateObject private var cloudStore: RestaurantCloudStore = RestaurantCloudStore()

    var body: some View {
        NavigationStack {
            ZStack {
                List(cloudStore.restaurants, id: \.recordID) { restaurant in
                    VStack(alignment: .leading, spacing: 10) {
                        AsyncImage(url: getImageURL(restaurant: restaurant)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.purple.opacity(0.1)
                        }
                        .frame(width: .infinity, height: 200)
                        .cornerRadius(10)
                        
                        VStack(alignment: .leading) {
                            Text(restaurant.object(forKey: "name") as! String)
                                .font(.system(.title2, design: .rounded))

                            Text(restaurant.object(forKey: "type") as! String)
                                .font(.system(.body, design: .rounded))
                            
                            
                            Text(restaurant.object(forKey: "location") as! String)
                                .font(.system(.subheadline, design: .rounded))
                                .foregroundColor(.gray)
                            
                            Text(restaurant.object(forKey: "description") as! String)
                                .font(.system(.subheadline, design: .rounded))
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 10)
                    }
                }
                .listStyle(PlainListStyle())
                .task {
                    cloudStore.fetchRestaurantsWithOperational()
                }
                .navigationTitle("Discover")
                .navigationBarTitleDisplayMode(.automatic)
                .refreshable {
                    cloudStore.fetchRestaurantsWithOperational()
                }
                if cloudStore.inProgressQuery {
                    ProgressView()
                }
            }
        }
    }
    
    private func getImageURL(restaurant: CKRecord) -> URL? {
        guard let image = restaurant.object(forKey: "image"),
              let imageAsset = image as? CKAsset else {
            return nil
        }
        return imageAsset.fileURL
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
