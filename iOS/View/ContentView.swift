//
//  ContentView.swift
//  Bored (iOS)
//
//  Created by armin on 7/30/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataModel: ActivityStore
    
    var body: some View {
        VStack {
            Spacer()
            
            HeaderView()
            
            Spacer()
                .frame(maxHeight: 50)
            
            ActivityView()
                .environmentObject(dataModel)
            
            if dataModel.isLoading && dataModel.activity == nil {
                ProgressView()
            }
            
            Spacer()
            
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
        .frame(maxWidth: .infinity)
        .padding()
        .onAppear { dataModel.fetchData() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
