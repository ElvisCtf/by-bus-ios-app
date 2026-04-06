//
//  Date+Ext.swift
//  ByBus
//
//  Created by Elvis Cheng on 10/3/2025.
//

import Foundation

extension Date {
    func hhmm() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
}
