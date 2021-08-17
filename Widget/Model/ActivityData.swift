//
//  ActivityData.swift
//  WidgetExtension
//
//  Created by armin on 8/17/21.
//

import WidgetKit

struct ActivityData : TimelineEntry {
    var date =  Date()
    let configuration: ConfigurationIntent
    let activity : Activity
    
    init(activity : Activity, configuration: ConfigurationIntent) {
        self.activity = activity
        self.configuration = configuration
    }
}
