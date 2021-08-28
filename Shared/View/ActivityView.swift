//
//  ActivityView.swift
//  Bored
//
//  Created by armin on 8/28/21.
//

import SwiftUI

struct ActivityView: View {
    
    @EnvironmentObject var dataModel: ActivityStore
    
    var body: some View {
        ZStack {
            if let activity = dataModel.activity {
                #if os(watchOS)
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
                #else
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
                #endif
            }
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
