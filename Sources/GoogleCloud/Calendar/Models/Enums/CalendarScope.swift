//
//  CalendarScope.swift
//  GoogleCloud
//
//  Created by Emil Wojtaszek on 18/10/2018.
//

import Foundation

public enum CalendarScope: String, CaseIterable {
    /// Allows access to read and change data to Calendars
    case readWriteCalendar = "https://www.googleapis.com/auth/calendar"
    /// Only allows access to read data to Calendars
    case readOnlyCalendar = "https://www.googleapis.com/auth/calendar.readonly"

    /// Allows access to read and change data to Events
    case readWriteEvents = "https://www.googleapis.com/auth/calendar.events"
    /// Only allows access to read data to Events
    case readOnlyEvents = "https://www.googleapis.com/auth/calendar.events.readonly"
    
    /// Only allows access to read Settings
    case readOnlySettings = "https://www.googleapis.com/auth/calendar.settings.readonly"
    /// Allows to run as a Calendar add-on
    case addonsExecute = "https://www.googleapis.com/auth/calendar.addons.execute"
}
