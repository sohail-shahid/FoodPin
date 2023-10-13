//
//  NewRestaurantView.swift
//  FoodPin
//
//  Created by Sohail khan on 08/10/2023.
//

import SwiftUI


struct NewRestaurantView: View {
    
    @ObservedObject private var restaurantFormViewModel: RestaurantFormViewModel
    @State var restaurantName = ""
    @State private var showPhotoOption: Bool = false
    @State private var photoSource: PhotoSource?
    let cloudStore = RestaurantCloudStore()
    
    @Environment (\.dismiss) var dismiss
    @Environment (\.managedObjectContext) var manageObjectContext
    
    init() {
        let viewModel = RestaurantFormViewModel()
        viewModel.image = UIImage(named: "newphoto")!
        restaurantFormViewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    Image(uiImage: restaurantFormViewModel.image)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 200)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 20.0))
                        .padding(.bottom)
                        .onTapGesture {
                            self.showPhotoOption.toggle()
                        }
                    FormTextField(label: "NAME", placeholder: "Fill in the restaurant name", value: $restaurantFormViewModel.name)
                    FormTextField(label: "TYPE", placeholder: "Fill in the restaurant type", value: $restaurantFormViewModel.type)
                    FormTextField(label: "ADDRESS", placeholder: "Fill in the restaurant address", value: $restaurantFormViewModel.location)
                    
                    FormTextField(label: "PHONE", placeholder: "Fill in the restaurant phone", value: $restaurantFormViewModel.phone)
                    FormTextView(label: "DESCRIPTION", height: 100, value: $restaurantFormViewModel.description)
                }
                .padding()
            }
            .navigationTitle("New Restaurant")
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .tint(.primary)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button {
                        save()
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(Color("NavigationBarTitle"))
                    }
                })
            }
        }
        .accentColor(.primary)
        .actionSheet(isPresented: $showPhotoOption, content: {
            ActionSheet(title: Text("Choose your photo source"),
                        message: nil,buttons: [
                            .default(Text("Camera")) {
                                self.photoSource = .camera
                            },
                            .default(Text("Photo Library")) {
                                self.photoSource = .photoLibrary
                            },
                            .cancel() ])
        })
        .fullScreenCover(item: $photoSource) { source in
            switch source {
            case .photoLibrary:
                ImagePicker(sourceType: .photoLibrary, selectedImage: $restaurantFormViewModel.image)
                    .ignoresSafeArea()
            case .camera:
                ImagePicker(sourceType: .camera, selectedImage: $restaurantFormViewModel.image)
                    .ignoresSafeArea()
            }
        }
    }
    
    private func save() {
        let restaurant = Restaurant(context: manageObjectContext)
        restaurant.name = restaurantFormViewModel.name
        restaurant.type = restaurantFormViewModel.type
        restaurant.location = restaurantFormViewModel.location
        restaurant.phone = restaurantFormViewModel.phone
        restaurant.image = restaurantFormViewModel.image.pngData()!
        restaurant.summary = restaurantFormViewModel.description
        restaurant.isFavorite = false
        do {
            try manageObjectContext.save()
        } catch {
            print("Failed to save the record...")
            print(error.localizedDescription)
        }
        cloudStore.saveRecordToCloud(restaurant: restaurant)
    }
}

struct FormTextField: View {
    var label: String
    var placeholder = ""
    @Binding var value: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.system(.headline, design: .rounded))
                .foregroundColor(Color(.darkGray))
            TextField(placeholder, text: $value)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding(.horizontal)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                )
                .padding(.vertical, 10)
        }
    }
}

struct FormTextView: View {
    var label: String
    var height: CGFloat = 200.0
    @Binding var value: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.system(.headline, design: .rounded))
                .foregroundColor(Color(.darkGray))
            TextEditor(text: $value)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                )
                .padding(.vertical, 10)
        }
    }
}

struct NewRestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NewRestaurantView()
        }
        .accentColor(.primary)
        FormTextField(label: "NAME", placeholder: "Fill in the restaurant name", value: .constant(""))
            .previewLayout(.fixed(width: 300, height: 200))
            .previewDisplayName("FormTextField")
        FormTextView(label: "Description", value: .constant(""))
            .previewLayout(.sizeThatFits)
            .previewDisplayName("FormTextView")
    }
}
