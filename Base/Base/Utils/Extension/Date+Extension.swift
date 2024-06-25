//
//  Date+Extension.swift
//  Base
//
//  Created by Тигран Гарибян on 25.06.2024.
//

import Foundation
import UIKit

extension Date {

    func fullDistance(from date: Date, resultIn component: Calendar.Component, calendar: Calendar = .current) -> Int? {
        calendar.dateComponents([component], from: self, to: date).value(for: component)
    }

    func distance(from date: Date, only component: Calendar.Component, calendar: Calendar = .current) -> Int {
        let days1 = calendar.component(component, from: self)
        let days2 = calendar.component(component, from: date)
        return days1 - days2
    }

    func hasSame(_ component: Calendar.Component, as date: Date) -> Bool {
        distance(from: date, only: component) == 0
    }
    
    func scheduleLocal(_ title: String) -> String? {
        guard self.timeIntervalSince1970 - Date.now.timeIntervalSince1970 > 20 else { return nil }
        let content = UNMutableNotificationContent()
        content.title = "Event"
        content.subtitle = title
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: self.timeIntervalSince1970 - Date.now.timeIntervalSince1970,
            repeats: false
        )
//        let dateComponets = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        return uuidString

    }
}
