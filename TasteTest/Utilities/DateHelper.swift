//
//  DateHelper.swift
//  TasteTest
//
//  Created by Adam Sadler on 9/18/24.
//

import Foundation

class DateHelper {
    static let sharedFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    static func formattedDate(_ date: Date) -> String {
        return sharedFormatter.string(from: date)
    }
}
