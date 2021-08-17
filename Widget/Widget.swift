//
//  Widget.swift
//  Widget
//
//  Created by armin on 8/10/21.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    @StateObject private var dataModel = ActivityDataModel()
    
    // MARK: - Placeholder
    func placeholder(in context: Context) -> ActivityEntry {
        dataModel.fetchData()
        return ActivityEntry(date: Date(), configuration: ConfigurationIntent())
    }
    
    // MARK: - Snapshot
    func getSnapshot(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (ActivityEntry) -> ()
    ) {
        dataModel.fetchData()
        let entry = ActivityEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    
    // MARK: - Timeline
    func getTimeline(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> ()
    ) {
        let currentDate = Date()
        let nextDate = Calendar.current.date(byAdding: .minute, value: 45, to: currentDate)!
        
        let entry = ActivityEntry(date: Date(), configuration: configuration)
        
        dataModel.fetchData()

        let timeline = Timeline(
            entries: [entry],
            policy: .after(nextDate)
        )
        completion(timeline)
    }
}

struct ActivityEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct BoredWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry
    
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            SmallWidget(entry: entry)
        case .systemMedium:
            MediumWidget(entry: entry)
        default:
            MediumWidget(entry: entry)
        }
    }
}

@main
struct BoredWidget: Widget {
    let kind: String = "Activity Suggestions"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: ConfigurationIntent.self,
            provider: Provider()
        ) { entry in
            
            BoredWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("Activity Suggestions")
        .description("Are you bored? Let's find you something to do")
    }
}

struct Widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SmallWidget(
                entry: ActivityEntry(
                    date: Date(),
                    configuration: ConfigurationIntent()
                )
            )
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            MediumWidget(
                entry: ActivityEntry(
                    date: Date(),
                    configuration: ConfigurationIntent()
                )
            )
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
