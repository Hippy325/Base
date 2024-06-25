//
//  Models.swift
//  Base
//
//  Created by Тигран Гарибян on 22.06.2024.
//

import Foundation

struct CalendarDays {
    private static func calendar() -> [String] {
        [
            "JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"
        ]
    }
    
    static func getClandarForEvents(sport: String) -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        var events: [EventModel]
        if sport == "All Sports" {
            events = EventsModel.getEvents()
        } else {
            events = EventsModel.getEvents().filter({ $0.sportName == sport })
        }
        var set: Set<String> = []
        events.forEach({
            let month = Int(formatter.string(from: $0.date))!
            set.insert(CalendarDays.calendar()[month - 1])
        })
        return Array(set)
    }
    
    static func getEventIndexFromDate(monthName: String) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let events = EventsModel.getEvents()
        for i in 0...events.count - 1 {
            if CalendarDays.calendar()[Int(formatter.string(from: events[i].date))! - 1] == monthName {
                return i
            }
        }
        return 0
    }
}

struct BonusModel {
    static func getImagesName(index: Int) -> String {
        switch index {
        case 0:
            return "jordan"
        case 1:
            return "hockey"
        case 2:
            return "kobe"
        case 3:
            return "snouboard"
        default: return ""
        }
    }
    
    static func setDay() {
        if let date = (UserDefaults.standard.object(forKey: "firstDay")) as? Date {
            let nowDate = Date.now
            if let distance = date.fullDistance(from: nowDate, resultIn: .day) {
                var days = UserDefaults.standard.array(forKey: "days") as! [Int]
                if distance + 1 == days.last! { return }
                if distance == days.last! {
                    days.append(distance + 1)
                    UserDefaults.standard.set(days, forKey: "days")
                } else {
                    UserDefaults.standard.setValue(Date.now, forKey: "firstDay")
                    UserDefaults.standard.set([1], forKey: "days")
                }
            }
        } else {
            UserDefaults.standard.setValue(Date.now, forKey: "firstDay")
            UserDefaults.standard.set([1], forKey: "days")
        }
    }
    
    static func getDays() -> [Int] {
        UserDefaults.standard.array(forKey: "days") as! [Int]
    }
    
    static func newWeak() {
        UserDefaults.standard.setValue(Date.now, forKey: "firstDay")
        UserDefaults.standard.set([1], forKey: "days")
    }
}
