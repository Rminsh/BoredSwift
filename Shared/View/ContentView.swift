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
        VStack {
            // Header content
            #if os(macOS)
            header
                .frame(minWidth: 250)
                .padding(.top, 100)
                .padding(.bottom, 50)
            #else
            Spacer()
            
            header
            
            Spacer()
                .frame(maxHeight: 50)
            #endif
            
            // Activity content
            #if os(macOS)
            content
                .frame(maxWidth: .infinity)
            
            if dataModel.isLoading {
                ProgressView()
            }
            #else
            content
            
            if dataModel.isLoading && dataModel.activity == nil {
                ProgressView()
            }
            
            Spacer()
            #endif
            
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
