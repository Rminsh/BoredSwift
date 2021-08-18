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
        WindowGroup {
            ContentView()
                .environmentObject(dataModel)
        }
    }
}
