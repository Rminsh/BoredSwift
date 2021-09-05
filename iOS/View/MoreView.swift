//
//  MoreView.swift
//  Bored (iOS)
//
//  Created by armin on 9/5/21.
//

import SwiftUI

struct MoreView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            content
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle("More", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { presentationMode.wrappedValue.dismiss() }) {
                            Image(systemName: "xmark")
                        }
                    }
                }
        }
    }
    
    var content: some View {
        List {
            Section {
                
                /// Contribute in BoredAPI
                Link(destination: URL(string: "https://www.boredapi.com/contributing")!, label: {
                    SettingsItemView(
                        icon: "lightbulb.fill",
                        color: .yellow,
                        title: "Contribute in Suggestions",
                        chevronIcon: "arrow.up.right"
                    )
                })
                
                /// Contribute in BoredSwift
                Link(destination: URL(string: "https://github.com/Rminsh/BoredSwift")!, label: {
                    SettingsItemView(
                        icon: "macwindow",
                        color: .orange,
                        title: "Contribute in App",
                        chevronIcon: "arrow.up.right"
                    )
                })
                
                /// Contribute in BoredAPI
                Link(destination: URL(string: "https://github.com/drewthoennes/Bored-API")!, label: {
                    SettingsItemView(
                        icon: "server.rack",
                        color: .green,
                        title: "Contribute in BoredAPI",
                        chevronIcon: "arrow.up.right"
                    )
                })
                
                /// FAQ
                Link(destination: URL(string: "https://www.boredapi.com/about")!, label: {
                    SettingsItemView(
                        icon: "questionmark",
                        color: .blue,
                        title: "FAQ",
                        chevronIcon: "arrow.up.right"
                    )
                })
                
                /// Terms of service
                Link(destination: URL(string: "https://github.com/Rminsh/BoredSwift/blob/master/LICENSE")!, label: {
                    SettingsItemView(
                        icon: "checkmark.seal.fill",
                        color: .white,
                        title: "Terms & Conditions",
                        chevronIcon: "arrow.up.right"
                    )
                })
                
                /// Privacy policy
                Link(destination: URL(string: "https://github.com/Rminsh/BoredSwift/blob/master/PrivacyPolicy.md")!, label: {
                    SettingsItemView(
                        icon: "lock.shield.fill",
                        color: .blue,
                        title: "Privacy Policy",
                        chevronIcon: "arrow.up.right"
                    )
                })
            }
        }
    }
}

struct SettingsItemView: View {
    var icon: String
    var color: Color
    var title: LocalizedStringKey
    var rotation: Double = 0
    var chevronIcon: String?
    
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                Image(systemName: icon)
                    .rotationEffect(.degrees(rotation))
                    .font(.body)
                    .foregroundColor(color == .white ? .blue : .white)
            }
            .frame(width: 28, height: 28)
            .background(color)
            .cornerRadius(6)
            .shadow(radius: 0.5)
            
            Text(title)
                .foregroundColor(.primary)
            
            if let chevron = chevronIcon {
                Spacer()
                Image(systemName: chevron)
                    .font(Font.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
            }
        }
        .contentShape(Rectangle())
        /// Spacer not working with onTapGesture
        /// workaround: https://stackoverflow.com/questions/57191013/swiftui-cant-tap-in-spacer-of-hstack
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
