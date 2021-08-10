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
