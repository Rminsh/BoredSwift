//
//  ActionView.swift
//  ActionView
//
//  Created by armin on 8/1/21.
//

import SwiftUI

struct ActionView: View {
    @State var size: ItemSize = .normal
    @State var icon: String = ""
    @State var title: String
    @State var subtitle: String
    @State var action: () -> Void
    
    var body: some View {
        VStack {
            if size == .normal {
                
                if icon != "" {
                    Image(systemName: icon)
                        .font(.title)
                        .foregroundColor(.accentColor)
                        .padding()
                }
                
                Text(title)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Button(action: action) {
                Text(subtitle)
                    .font(.body)
            }
        }
        .padding()
    }
}

struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        ActionView(
            title: "Not satisfied?",
            subtitle: "Try another one",
            action: {}
        )
    }
}
