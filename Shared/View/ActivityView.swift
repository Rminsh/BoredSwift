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

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
