//
//  TutorialPageView.swift
//  FoodPin
//
//  Created by Sohail Khan on 11/10/2023.
//

import SwiftUI

struct TutorialPageView: View {
    let tutorialPageModel: TutorialPageModel
    
    var body: some View {
        VStack(spacing: 70) {
            Image(tutorialPageModel.image)
                .resizable()
                .scaledToFit()
            VStack(spacing: 10) {
                Text(tutorialPageModel.heading)
                    .font(.headline)
                Text(tutorialPageModel.subHeading )
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 40)
            Spacer()
        }
        .padding(.top)
    }
}

struct TutorialPage_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPageView(tutorialPageModel: TutorialPageModel(image: "onboarding-1", heading: "CREATE YOUR OWN FOOD GUIDE", subHeading: "Pin your favorite restaurants and create your own food guide"))
    }
}
