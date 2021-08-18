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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text("Let's")
                .font(.title2)
                .fontWeight(.light)
            
            Text(entry.activity.activity)
                .font(.title3)
                .fontWeight(.medium)
                .padding(.horizontal)
            
            HStack {
                
                ItemViewSmall(
                    icon: "circle.hexagongrid.fill",
                    header: "Type",
                    title: entry.activity.type.capitalizingFirstLetter()
                )
                
                Spacer()
                
                ItemViewSmall(
                    icon: "figure.wave.circle.fill",
                    header: "Accessibility",
                    title: "\(entry.activity.accessibility * 100)%"
                )
                
                Spacer()
                
                ItemViewSmall(
                    icon: "person.2.circle.fill",
                    header: "Participants",
                    title: "\(entry.activity.participants)"
                )
                
                Spacer()
            }
        }
        .padding()
    }
}

struct MediumWidget_Previews: PreviewProvider {
    
    static var dataModel = ActivityStore()
    
    static var previews: some View {
        MediumWidget(
            entry: ActivityData(
                activity: dataModel.testData(),
                configuration: ConfigurationIntent()
            )
        )
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
