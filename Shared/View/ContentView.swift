//
//  ContentView.swift
//  Shared
//
//  Created by armin on 7/30/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataModel: ActivityStore
    
    var body: some View {
        #if os(macOS)
        ZStack(alignment: .center) {
            
            VisualEffectBlur(material: .popover, blendingMode: .behindWindow)
            
            context
                .padding(.top, 30)
                .padding(.horizontal)
        }
        .edgesIgnoringSafeArea(.all)
        .frame(width: 450)
        #else
        context
        #endif
    }
    
    #if os(watchOS)
    var context: some View {
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
    #endif
    
    #if os(macOS)
    var context: some View {
        VStack {
            // Header content
            header
                .frame(minWidth: 250)
                .padding(.top, 100)
                .padding(.bottom, 50)

            
            // Activity content
            content
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
        .frame(maxWidth: .infinity)
        .padding()
        .onAppear { dataModel.fetchData() }
    }
    #endif
    
    #if os(iOS)
    var context: some View {
        VStack {
            // Header content
            Spacer()
            
            header
            
            Spacer()
                .frame(maxHeight: 50)
            
            // Activity content
            content
            
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
    #endif
    
    // MARK: - Header
    var header: some View {
        VStack {
            Text("Are you bored?")
                .font(.largeTitle)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
            
            Text("Let's find you something to do")
                .font(.body)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
        }
    }
    
    // MARK: - Content
    var content: some View {
        ZStack {
            if let activity = dataModel.activity {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Let's")
                        .font(.title2)
                        .fontWeight(.light)
                    
                    
                    Text(activity.activity)
                        .font(.title2)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                        .frame(maxWidth: .infinity)
                    
                    ItemView(
                        icon: "Accessibility",
                        header: "Accessibility",
                        title: "\(activity.accessibility * 100)%"
                    )
                    
                    ItemView(
                        icon: "Participants",
                        header: "Participants",
                        title: "\(activity.participants)"
                    )
                    
                    ItemView(
                        icon: "Type",
                        header: "Type",
                        title: activity.type.capitalizingFirstLetter()
                    )
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
