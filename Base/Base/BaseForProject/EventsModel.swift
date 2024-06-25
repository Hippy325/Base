//
//  EventModels.swift
//  Base
//
//  Created by Тигран Гарибян on 23.06.2024.
//

import Foundation
import UIKit

struct SportsModel {
    
    static func saveCustomSports() {
        let sports = [
            "All Sports", "Soccer", "Basketball", "Tennis", "Baseball",
            "American Football", "Rugby", "Cricket", "Golf", "Hockey", "Swimming"
        ]
        UserDefaults.standard.set(sports, forKey: "sports")
    }
    
    static func getAllTypeSports() -> [String] {
        UserDefaults.standard.array(forKey: "sports") as? [String] ?? []
    }
    
    static func setNewSport(sport: String) {
        var sports = UserDefaults.standard.array(forKey: "sports") as! [String]
        if !sports.contains(sport.uppercased()) && !sports.contains(sport) {
            sports.append(sport.uppercased())
            UserDefaults.standard.set(sports, forKey: "sports")
        }
    }
}

struct EventModel {
    let date: Date
    let title: String
    let sportName: String
    let description: String
    
    static func saveCustomEvents() {
        let eventsDate = [Date.now, Date.now, Date.now, Date.now]
        let eventsTitle = ["MatCH 1", "Event SUMMER", "New bats", "Home game"]
        let eventsSportName = ["CRICKET", "NBA", "HOCKEY", "CRICKET"]
        let eventsDescription = ["First time event in the city", "Our field", "New event in our district", "Home game"]
        UserDefaults.standard.set(eventsDate, forKey: "event_date")
        UserDefaults.standard.set(eventsTitle, forKey: "event_title")
        UserDefaults.standard.set(eventsSportName, forKey: "event_sportName")
        UserDefaults.standard.set(eventsDescription, forKey: "event_description")
    }
}

struct EventsModel {
    static func removeEvent(index: Int) {
        var eventsDate = UserDefaults.standard.array(forKey: "event_date") as! [Date]
        var eventsTitle = UserDefaults.standard.array(forKey: "event_title") as! [String]
        var eventsSportName = UserDefaults.standard.array(forKey: "event_sportName") as! [String]
        var eventsDescription = UserDefaults.standard.array(forKey: "event_description") as! [String]
        if let uuidString = UserDefaults.standard.string(forKey: eventsTitle[index]) {
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [uuidString])
        }
        eventsDate.remove(at: index)
        eventsTitle.remove(at: index)
        eventsSportName.remove(at: index)
        eventsDescription.remove(at: index)
        UserDefaults.standard.set(eventsDate, forKey: "event_date")
        UserDefaults.standard.set(eventsTitle, forKey: "event_title")
        UserDefaults.standard.set(eventsSportName, forKey: "event_sportName")
        UserDefaults.standard.set(eventsDescription, forKey: "event_description")
    }
    
    static func addEvent(_ event: EventModel) {
        SportsModel.setNewSport(sport: event.sportName)
        var eventsDate = UserDefaults.standard.array(forKey: "event_date") as! [Date]
        var eventsTitle = UserDefaults.standard.array(forKey: "event_title") as! [String]
        var eventsSportName = UserDefaults.standard.array(forKey: "event_sportName") as! [String]
        var eventsDescription = UserDefaults.standard.array(forKey: "event_description") as! [String]
        eventsDate.append(event.date)
        eventsTitle.append(event.title)
        eventsSportName.append(event.sportName.uppercased())
        eventsDescription.append(event.description)
        UserDefaults.standard.set(eventsDate, forKey: "event_date")
        UserDefaults.standard.set(eventsTitle, forKey: "event_title")
        UserDefaults.standard.set(eventsSportName, forKey: "event_sportName")
        UserDefaults.standard.set(eventsDescription, forKey: "event_description")
        if UserDefaults.standard.bool(forKey: "notifications") {
            guard let id = event.date.scheduleLocal(event.title) else { return }
            UserDefaults.standard.setValue(id, forKey: event.title)
        }
    }
    
    static func getEvents() -> [EventModel] {
        let eventsDate = UserDefaults.standard.array(forKey: "event_date") as! [Date]
        let eventsTitle = UserDefaults.standard.array(forKey: "event_title") as! [String]
        let eventsSportName = UserDefaults.standard.array(forKey: "event_sportName") as! [String]
        let eventsDescription = UserDefaults.standard.array(forKey: "event_description") as! [String]
        var events: [EventModel] = []
        for i in 0...eventsTitle.count - 1 {
            events.append(
                EventModel(
                    date: eventsDate[i],
                    title: eventsTitle[i],
                    sportName: eventsSportName[i],
                    description: eventsDescription[i]
                )
            )
        }
        return events
    }
}
