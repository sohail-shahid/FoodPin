//
//  TutorialView.swift
//  FoodPin
//
//  Created by Sohail Khan on 11/10/2023.
//

import SwiftUI

struct TutorialView: View {
    let tutorialPageModels: [TutorialPageModel] = [TutorialPageModel(image: "onboarding-1", heading: "CREATE YOUR OWN FOOD GUIDE", subHeading: "Pin your favorite restaurants and create your own food guide"), TutorialPageModel(image: "onboarding-2", heading: "SHOW YOU THE LOCATION", subHeading: "Search and locate your favorite restaurant on Maps"), TutorialPageModel(image: "onboarding-3", heading: "DISCOVER GREAT RESTAURANTS", subHeading: "Find restaurants shared by your friends and other foodies")]
    
    @AppStorage("hasViewedWalkthrough") var hasViewedWalkthrough: Bool = false
    @Environment(\.dismiss) var dissmiss
    @State private var currentPage = 0
      
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemIndigo
        UIPageControl.appearance().pageIndicatorTintColor = .lightGray
    }
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach (tutorialPageModels.indices, id: \.self) { index in
                    TutorialPageView(tutorialPageModel: tutorialPageModels[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
            .animation(.default, value: currentPage)
            
            VStack(spacing: 20) {
                Button {
                    if currentPage < tutorialPageModels.count - 1 {
                        currentPage = currentPage + 1
                    } else {
                        hasViewedWalkthrough = true
                        dissmiss()
                    }
                } label: {
                    Text(currentPage == tutorialPageModels.count - 1 ? "GET STARTED" : "Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal,50)
                        .background(Color(.systemIndigo))
                        .cornerRadius(25)
                }
                
                Button {
                    hasViewedWalkthrough = true
                    dissmiss()
                } label: {
                    Text("Skip")
                        .font(.headline)
                        .foregroundColor(Color(.darkGray))
                }
            }
        }
        .padding(.bottom)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
