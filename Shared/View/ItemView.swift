//
//  ItemView.swift
//  ItemView
//
//  Created by armin on 8/1/21.
//

import SwiftUI

struct ItemView: View {
    var icon: String
    var header: String
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .renderingMode(.original)           // Multicolor icon (iOS 14+ , macOS 11+)
                //.symbolRenderingMode(.multicolor) // Multicolor icon (iOS 15+ , macOS 12+)
                .font(.largeTitle)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(header)
                    .font(.body)
                    .fontWeight(.light)
                    //.foregroundStyle(.secondary) // Text style (iOS 15+ , macOS 12+)
                
                Text(title)
                    .font(.title3)
                    .fontWeight(.regular)
                    //.foregroundStyle(.primary) // Text style (iOS 15+ , macOS 12+)
            }
        }
    }
}

struct ItemViewSmall: View {
    var icon: String
    var header: String
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .renderingMode(.original)           // Multicolor icon (iOS 14+ , macOS 11+)
                //.symbolRenderingMode(.multicolor) // Multicolor icon (iOS 15+ , macOS 12+)
                .font(.body)
                .foregroundColor(.blue)
            
            Text(title)
                .font(.footnote)
                .fontWeight(.regular)
                //.foregroundStyle(.primary)        // Text style (iOS 15+ , macOS 12+)
        }
    }
}


struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(
            icon: "circle.hexagongrid.fill",
            header: "Type",
            title: "Busy work"
        )
    }
}
