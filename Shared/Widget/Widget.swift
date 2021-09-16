//
//  Widget.swift
//  Widget
//
//  Created by armin on 8/10/21.
//

import WidgetKit
import SwiftUI
import Intents
import BoredSDK

struct Provider: TimelineProvider {
    
    @StateObject private var dataModel = ActivityStore()
    
    // MARK: - Placeholder
    func placeholder(in context: Context) -> ActivityData {
        dataModel.fetchData()
        return ActivityData(activity: dataModel.testData())
    }
    
    // MARK: - Snapshot
    func getSnapshot(in context: Context, completion: @escaping (ActivityData) -> ()) {
        dataModel.fetch { activity in
            let entry = ActivityData(activity: activity)
            completion(entry)
        }
    }
    
    // MARK: - Timeline
    func getTimeline(in context: Context, completion: @escaping (Timeline<ActivityData>) -> () /// Weird build bug: The `ActivityData` should be `Entry`
    ) {
        var entries: [ActivityData] = [] /// List of entries
        
        /// Widget will refresh every `1 hour`
        let refresh = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
        
        /// fetching and updating data
        dataModel.fetch { activity in
            entries.append(ActivityData(activity: activity))
            let timeline = Timeline(entries: entries, policy: .after(refresh))
            completion(timeline)
        }
    }
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
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            BoredWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("Activity Suggestions")
        .description("Are you bored? Let's find you something to do")
    }
}

struct Widget_Previews: PreviewProvider {
    
    static var dataModel = ActivityStore()
    
    static var previews: some View {
        Group {
            SmallWidget(entry: ActivityData(activity: dataModel.testData()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            MediumWidget(entry: ActivityData(activity: dataModel.testData()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
