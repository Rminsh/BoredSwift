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
                
                ItemView(
                    size: .small,
                    icon: "Type",
                    header: "Type",
                    title: entry.activity.type.capitalizingFirstLetter()
                )
                
                Spacer()
                
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
