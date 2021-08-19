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
    
    var body: some Scene {
        #if os(macOS)
        WindowGroup {
            ContentView()
                .environmentObject(dataModel)
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        #else
        WindowGroup {
            ContentView()
                .environmentObject(dataModel)
        }
        #endif
    }
}
