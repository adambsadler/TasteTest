//
//  Item.swift
//  TasteTest
//
//  Created by Adam Sadler on 9/17/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
