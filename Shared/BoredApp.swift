//
//  BoredApp.swift
//  Shared
//
//  Created by armin on 8/7/21.
//

import SwiftUI

@main
struct BoredApp: App {
    @StateObject private var dataModel = ActivityStore()
    @AppStorage("firstRun") private var firstRun = true
    
    var body: some Scene {
        #if os(macOS)
        WindowGroup {
            ContentView()
                .environmentObject(dataModel)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        #else
        WindowGroup {
            #if os(iOS)
            if firstRun {
                IntroView()
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0)))
            } else {
                ContentView()
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.0)))
                    .environmentObject(dataModel)
            }
            #else
            ContentView()
                .environmentObject(dataModel)
            #endif
        }
        #endif
    }
}
