//
//  RestaurantListView.swift
//  FoodPin
//
//  Created by Sohail Khan on 11/07/2023.
//

import SwiftUI

struct RestaurantListView: View {
    
    @Environment(\.managedObjectContext) var context
    @AppStorage("hasViewedWalkthrough") var hasViewedWalkthrough: Bool = false

    @FetchRequest(entity: Restaurant.entity(), sortDescriptors: [])
    var resturants: FetchedResults<Restaurant>
    @State var showNewRestaurant: Bool = false
    @State var searchText: String = ""
    @State private var showWalkthrough = false
    
    var body: some View {
        NavigationStack {
            List {
                if resturants.isEmpty {
                    Image("emptydata")
                        .resizable()
                        .scaledToFit()
                } else {
                    ForEach(resturants.indices, id: \.self) { index in
                        NavigationLink (destination: RestaurantDetailView (restaurant: resturants[index])) {
                            BasicTextImageRow(restaurant: resturants[index])
                                .swipeActions(edge: .leading, allowsFullSwipe: false, content: {
                                    Button {
                                    } label: {
                                        Image(systemName: "heart")
                                    }
                                    .tint(.green)
                                    Button {
                                    } label: {
                                        Image(systemName: "square.and.arrow.up")
                                    }
                                    .tint(.orange)
                                })
                        }
                    }
                    .onDelete(perform: deleteRecord)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Food Pin")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.showNewRestaurant = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .accentColor(.primary)
        .onAppear() {
            showWalkthrough = hasViewedWalkthrough ? false : true
        }
        .sheet(isPresented: $showWalkthrough) {
            TutorialView()
        }
        .sheet(isPresented: $showNewRestaurant) {
            NewRestaurantView()
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search restaurants...", suggestions: {
            Text("Thai").searchCompletion("Thai")
            Text("Cafe").searchCompletion("Cafe")
        })
        .onChange(of: searchText) { _ in
            let valueTrue = NSPredicate(value: true)
            let namePredicate = NSPredicate(format: "name CONTAINS[c] %@", searchText)
            let locationPredicate = NSPredicate(format: "location CONTAINS[c] %@", searchText)
            let predicate = searchText.isEmpty ? valueTrue : NSCompoundPredicate(orPredicateWithSubpredicates: [namePredicate, locationPredicate])
            resturants.nsPredicate = predicate
        }
        .onOpenURL { url in
            switch url.path {
            case "/NewRestaurant": showNewRestaurant = true
            default: return
            }
        }
        .task {
            prepareNotification()
        }
    }
    
    private func deleteRecord(indexSet: IndexSet) {
        for index in indexSet {
            let itemToDelete = resturants[index]
            context.delete(itemToDelete)
        }
        DispatchQueue.main.async {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    private func prepareNotification() {
        if resturants.count <= 0 {
            return
        }
        
        let randomIndex = Int.random(in: 0 ..< resturants.count)
        let suggestedRestaurant = resturants[randomIndex]
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Restaurant Recommendation"
        notificationContent.subtitle = "Try new food today"
        notificationContent.body = "I recommend you to check out \(suggestedRestaurant.name). The restaurant is one of your favorites. It is located at \(suggestedRestaurant.location). Would you like to give it a try?"
        notificationContent.sound = .default
        
        let tempDirURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let tempFileURL = tempDirURL.appendingPathComponent("suggested-restaurant.jpg")
        if let image = UIImage(data: suggestedRestaurant.image as Data) {
            try? image.jpegData(compressionQuality: 1.0)?.write(to: tempFileURL)
            if let restaurantImage = try? UNNotificationAttachment(identifier: Constants.LOCAL_NOTIFICATION_ATTACHMENT_ID, url: tempFileURL, options: nil) {
                notificationContent.attachments = [restaurantImage]
            }
        }
        notificationContent.userInfo = ["phone": suggestedRestaurant.phone]
        // Adding actions
        let categoryIdentifer = Constants.CATEGORY_ACTION_ID
        let makeReservationAction = UNNotificationAction(identifier:Constants.RESERVATION_ACTION_ID, title: "Reserve a table", options: [.foreground])
        let cancelAction = UNNotificationAction(identifier: "foodpin.cancel", title: "Later", options: [])
        let category = UNNotificationCategory(identifier: categoryIdentifer, actions: [makeReservationAction, cancelAction], intentIdentifiers: [], options:[])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        notificationContent.categoryIdentifier = categoryIdentifer
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let notificationRequest = UNNotificationRequest(identifier: "foodpin.restaurantSuggestion", content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(notificationRequest)
    }
}

struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView()
            .preferredColorScheme(.light)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct FullImageRow: View {
    var restaurant: Restaurant
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            Image(uiImage: UIImage(data: restaurant.image) ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .cornerRadius(20)
            VStack (alignment: .leading) {
                Text(restaurant.name)
                    .font(.system(.title2, design: .rounded))
                Text(restaurant.type)
                    .font(.system(.body, design: .rounded))
                Text(restaurant.location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
        }
    }
}

struct BasicTextImageRow: View {
    
    // MARK: - State
    @State private var showOptions = false
    @State private var showError = false
    
    // MARK: - @ObservedObject
    @ObservedObject var restaurant: Restaurant
    
    var body: some View {
        HStack (alignment: .top, spacing: 20) {
            Image(uiImage: UIImage(data: restaurant.image) ?? UIImage())
                .resizable()
                .frame(width: 120, height: 118)
                .cornerRadius(20)
            VStack (alignment: .leading) {
                Text(restaurant.name)
                    .font(.system(.title2, design: .rounded))
                Text(restaurant.type)
                    .font(.system(.body, design: .rounded))
                Text(restaurant.location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
            if restaurant.isFavorite {
                Spacer()
                Image(systemName: "heart.fill")
                    .foregroundColor(.yellow)
            }
        }
        .contextMenu {
            Button( action: {
                self.showError.toggle()
            }) {
                HStack {
                    Text("Reserve a table")
                    Image(systemName: "phone")
                }
            }
            
            Button( action: {
                restaurant.isFavorite.toggle()
            }) {
                HStack {
                    Text(restaurant.isFavorite ? "Remove from favorites" : "Mark as favorite")
                    Image(systemName: "heart")
                }
            }
            
            Button ( action: {
                self.showOptions.toggle()
            }) {
                HStack {
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .alert("Not yet available", isPresented: $showError) {
            Button("OK") {
            }
        } message: {
            Text("Sorry, this feature is not available yet. Please retry later.")
        }
        .sheet(isPresented: $showOptions) {
            let defaultText = "Just checking in at \(restaurant.name)"
            if let imageToShare = UIImage(data: restaurant.image) {
                ActivityView(activityItems: [defaultText, imageToShare])
            } else {
                ActivityView(activityItems: [defaultText])
            }
        }
    }
}
