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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(entry.activity.activity)
                .font(.subheadline)
                .fontWeight(.medium)
            
            ItemViewSmall(
                icon: "circle.hexagongrid.fill",
                header: "Type",
                title: entry.activity.type.capitalizingFirstLetter()
            )
            
            HStack {
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
            }
        }
        .padding()
    }
}

struct SmallWidget_Previews: PreviewProvider {
    
    static var dataModel = ActivityDataModel()
    
    static var previews: some View {
        SmallWidget(
            entry: ActivityData(
                activity: dataModel.testData(),
                configuration: ConfigurationIntent()
            )
        )
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
