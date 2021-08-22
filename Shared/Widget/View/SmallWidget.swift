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
            
            ItemView(
                size: .small,
                icon: "Type",
                header: "Type",
                title: entry.activity.type.capitalizingFirstLetter()
            )
            
            HStack {
                ItemView(
                    size: .small,
                    icon: "Accessibility",
                    header: "Accessibility",
                    title: "\(entry.activity.accessibility * 100)%"
                )
                
                Spacer()
                
                ItemView(
                    size: .small,
                    icon: "Participants",
                    header: "Participants",
                    title: "\(entry.activity.participants)"
                )
            }
        }
        .padding()
    }
}

struct SmallWidget_Previews: PreviewProvider {
    
    static var dataModel = ActivityStore()
    
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
