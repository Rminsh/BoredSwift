//
//  Activity.swift
//  Core
//
//  Created by armin on 8/1/21.
//

import Foundation

struct Activity: Codable {
    let activity, type: String
    let participants: Int
    let price: Double
    let link, key: String?
    let accessibility: Double
}

enum ActivityType: String, CaseIterable, Identifiable, CustomStringConvertible {
    case education
    case recreational
    case social
    case diy
    case all
    case charity
    case cooking
    case relaxation
    case music
    case busyWork
    
    var id: String { self.rawValue }
    var description: String { self.rawValue.localizedCapitalized }
}
