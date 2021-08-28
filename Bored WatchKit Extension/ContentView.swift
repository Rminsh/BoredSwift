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
                    VStack {
                        Text("Are you bored?")
                            .font(.title2)
                            .fontWeight(.light)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity)
                        
                        Text("Let's find you something to do")
                            .font(.body)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity)
                        
                        ProgressView()
                    }
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
                        if let activity = dataModel.activity {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(activity.activity)
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(maxWidth: .infinity)
                                
                                ItemView(
                                    size: .small,
                                    icon: "Type",
                                    header: "Type",
                                    title: activity.type.capitalizingFirstLetter()
                                )
                                .padding(.horizontal)
                                
                                HStack {
                                    ItemView(
                                        size: .small,
                                        icon: "Accessibility",
                                        header: "Accessibility",
                                        title: "\(activity.accessibility * 100)%"
                                    )
                                    
                                    Spacer()
                                    
                                    ItemView(
                                        size: .small,
                                        icon: "Participants",
                                        header: "Participants",
                                        title: "\(activity.participants)"
                                    )
                                }
                                .padding(.horizontal)
                            }
                        }
                        
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
