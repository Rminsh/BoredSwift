//
//  ActivityResource.swift
//  Bored
//
//  Created by armin on 8/7/21.
//

import Foundation

struct ActivityResource: APIResource {
    var key: String?
    
    var type: String?
    
    var participants: String?
    
    var minprice: String?
    
    var maxprice: String?
    
    var accessibility: String?
    
    var minaccessibility: String?
    
    var maxaccessibility: String?
    
    typealias ModelType = Activity
    
}
