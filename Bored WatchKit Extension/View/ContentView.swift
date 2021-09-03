//
//  ContentView.swift
//  Bored WatchKit Extension
//
//  Created by armin on 7/30/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataModel: ActivityStore
    
    var body: some View {
        NavigationView {
            
            ZStack {
                // Initial loading (Activity is null)
                if dataModel.isLoading && dataModel.activity == nil {
                    HeaderView()
                }
                
                // Initial loading (if Activity failed to load, network error)
                if dataModel.hasError && dataModel.activity == nil {
                    ActionView(
                        size: .normal,
                        icon: "wifi",
                        title: "Network error",
                        subtitle: "Try again",
                        action: { dataModel.fetchData() }
                    )
                }
                
                ScrollView {
                    VStack {
                        // Content
                        ActivityView()
                            .environmentObject(dataModel)
                        
                        // Get another activity
                        if !dataModel.isLoading && dataModel.activity != nil {
                            ActionView(
                                size: .small,
                                title: "Not satisfied?",
                                subtitle: "Try another one",
                                action: { dataModel.fetchData() }
                            )
                        } else if dataModel.isLoading && dataModel.activity != nil {
                            ProgressView()
                        }
                    }
                    
                    .onAppear { dataModel.fetchData() }
                }
                .navigationTitle("Bored")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
