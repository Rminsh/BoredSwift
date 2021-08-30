//
//  IntroView.swift
//  Bored
//
//  Created by armin on 8/28/21.
//

import SwiftUI

struct IntroView: View {
    
    @State private var currentTab = 0
    @AppStorage("firstRun") private var firstRun = true
    
    #if os(iOS)
    init() {
        UIPageControl
            .appearance()
            .currentPageIndicatorTintColor = UIColor(Color.accentColor)
        
        UIPageControl
            .appearance()
            .pageIndicatorTintColor = UIColor(Color.accentColor).withAlphaComponent(0.2)
    }
    #endif
    
    var body: some View {
        TabView(
            selection: $currentTab,
            content:  {
                IntroPage(
                    imageName: "intro_bored",
                    title: "Welcome to bored",
                    subtitle: "Discover activities suitable for you"
                )
                .tag(0)
                
                IntroPage(
                    imageName: "intro_devices",
                    title: "Multiple devices",
                    subtitle: "Access bored via all of your devices and widgets"
                )
                .tag(1)
                
                IntroPage(
                    imageName: "intro_mask",
                    title: "Last suggestion!",
                    subtitle: "Be careful about all the suggested outdoor activities, wear your mask and keep your distance from each other ♥️✌🏻"
                )
                .tag(2)
            }
        )
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .overlay(
            ZStack {
                if currentTab == 2 {
                    Button(action: {
                        firstRun = false
                    }) {
                        Text("Got it")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.accentColor)
                            )
                    }
                    .padding(.bottom)
                }
            },
            alignment: .bottom
        )
        

    }
}

struct IntroPage: View {
    
    var imageName: String
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                
            
            Spacer()
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            
            Text(subtitle)
                .font(.body)
                .padding(.horizontal)
            
            
            Spacer()
        }
        .padding(.all, 40)
        .padding(.bottom, 20)
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IntroView()
                .preferredColorScheme(.dark)
            IntroView()
                .previewDevice("iPhone 6s")
                
        }
    }
}
