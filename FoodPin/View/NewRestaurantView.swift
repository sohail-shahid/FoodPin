//
//  NewRestaurantView.swift
//  FoodPin
//
//  Created by Sohail khan on 08/10/2023.
//

import SwiftUI


struct NewRestaurantView: View {
    @State var restaurantName = ""
    @State private var restaurantImage = UIImage(named: "newphoto") ?? UIImage()
    @State private var showPhotoOption: Bool = false
    @State private var photoSource: PhotoSource?
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    Image(uiImage: restaurantImage)
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
                    FormTextField(label: "NAME", placeholder: "Fill in the restaurant name", value: .constant(""))
                    FormTextField(label: "TYPE", placeholder: "Fill in the restaurant type", value: .constant(""))
                    FormTextField(label: "ADDRESS", placeholder: "Fill in the restaurant address", value: .constant(""))
                    
                    FormTextField(label: "PHONE", placeholder: "Fill in the restaurant phone", value: .constant(""))
                    FormTextView(label: "DESCRIPTION", value: .constant(""), height: 100)
                }
                .padding()
            }
            .navigationTitle("New Restaurant")
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
                ImagePicker(sourceType: .photoLibrary, selectedImage: $restaurantImage)
                    .ignoresSafeArea()
            case .camera:
                ImagePicker(sourceType: .camera, selectedImage: $restaurantImage)
                    .ignoresSafeArea()
            }
        }
        .toolbar {
            ToolbarItem (placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(Color("NavigationBarTitle"))
                
            })
        }
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
    @Binding var value: String
    var height: CGFloat = 200.0
    
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
