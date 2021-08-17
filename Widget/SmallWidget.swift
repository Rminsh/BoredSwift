//
//  SmallWidget.swift
//  WidgetExtension
//
//  Created by armin on 8/10/21.
//

import WidgetKit
import SwiftUI
import Intents

struct SmallWidget : View {
    var entry: Provider.Entry
    
    @AppStorage("activityTitle") var activityTitle: String = ""
    @AppStorage("activityAccessibility") var activityAccessibility: Double = 0.0
    @AppStorage("activityParticipants") var activityParticipants: Int = 0
    @AppStorage("activityType") var activityType: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(activityTitle)
                .font(.subheadline)
                .fontWeight(.medium)
            
            ItemViewSmall(
                icon: "circle.hexagongrid.fill",
                header: "Type",
                title: activityType.capitalizingFirstLetter()
            )
            
            HStack {
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
            }
        }
        .padding()
    }
}

struct SmallWidget_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidget(
            entry: ActivityEntry(
                date: Date(),
                configuration: ConfigurationIntent()
            ),
            activityTitle: "Resolve a problem you've been putting off",
            activityAccessibility: 0,
            activityParticipants: 1,
            activityType: "busywork"
        )
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
