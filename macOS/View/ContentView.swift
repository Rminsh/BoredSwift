//
//  ContentView.swift
//  Bored (macOS)
//
//  Created by armin on 7/30/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataModel: ActivityStore
    
    var body: some View {
        ZStack(alignment: .center) {
            
            VisualEffectBlur(material: .popover, blendingMode: .behindWindow)
            
            context
                .padding(.top, 30)
                .padding(.horizontal)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var context: some View {
        VStack {
            // Header content
            HeaderView()
                .frame(minWidth: 350)
                .padding(.bottom, 50)

            
            // Activity content
            ActivityView()
                .environmentObject(dataModel)
                .frame(maxWidth: .infinity)
            
            if dataModel.isLoading && dataModel.activity == nil {
                ProgressView()
            }
            
            // Get another activity
            if !dataModel.isLoading && dataModel.activity != nil {
                ActionView(
                    title: "Not satisfied?",
                    subtitle: "Try another one",
                    action: { dataModel.fetchData() }
                )
                .frame(maxWidth: .infinity)
                .frame(height: 80)
            } else if dataModel.isLoading && dataModel.activity != nil {
                ProgressView()
                    .frame(height: 80)
            }
            
            // Empty state for network error (if activity is nil)
            if !dataModel.isLoading && dataModel.hasError && dataModel.activity == nil {
                ActionView(
                    title: dataModel.errorTitle,
                    subtitle: "Try again",
                    action: { dataModel.fetchData() }
                )
            }
        }
        .frame(maxWidth: 450, maxHeight: 550)
        .padding()
        .onAppear { dataModel.fetchData() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ActivityStore())
    }
}
