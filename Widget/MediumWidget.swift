//
//  MediumWidget.swift
//  Bored
//
//  Created by armin on 8/17/21.
//

import SwiftUI

import WidgetKit
import SwiftUI
import Intents

struct MediumWidget : View {
    var entry: Provider.Entry
    
    @AppStorage("activityTitle") var activityTitle: String = ""
    @AppStorage("activityAccessibility") var activityAccessibility: Double = 0.0
    @AppStorage("activityParticipants") var activityParticipants: Int = 0
    @AppStorage("activityType") var activityType: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
                .frame(minHeight: 0, maxHeight: .infinity)
            
            Text("Let's")
                .font(.title2)
                .fontWeight(.light)
            
            Text(activityTitle)
                .font(.title3)
                .fontWeight(.medium)
                .padding(.horizontal)
            
            Spacer()
                .frame(minHeight: 0, maxHeight: .infinity)
            
            HStack {
                
                ItemViewSmall(
                    icon: "circle.hexagongrid.fill",
                    header: "Type",
                    title: activityType.capitalizingFirstLetter()
                )
                
                Spacer()
                
                ItemViewSmall(
                    icon: "figure.wave.circle.fill",
                    header: "Accessibility",
                    title: "\(activityAccessibility * 100)%"
                )
                
                Spacer()
                
                ItemViewSmall(
                    icon: "person.2.circle.fill",
                    header: "Participants",
                    title: "\(activityParticipants)"
                )
                
                Spacer()
            }
        }
        .padding()
    }
}

struct MediumWidget_Previews: PreviewProvider {
    static var previews: some View {
        MediumWidget(
            entry: ActivityEntry(
                date: Date(),
                configuration: ConfigurationIntent()
            ),
            activityTitle: "Resolve a problem you've been putting off",
            activityAccessibility: 0,
            activityParticipants: 1,
            activityType: "busywork"
        )
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
