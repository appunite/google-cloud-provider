//
//  Event.swift
//  GoogleCloud
//
//  Created by Emil Wojtaszek on 18/10/2018.
//

import Vapor

// docs: https://developers.google.com/calendar/v3/reference/events
public struct CalendarEvent: GoogleCloudModel {
    public var kind: String
    public var id: String
    public var status: String?
    public var htmlLink: URL?
    public var summary: String?
    public var creator: EventActor
    public var organizer: EventActor?
    public var attendees: [EventActor]?
    public var start: EventDate
    public var end: EventDate

    public struct EventActor: GoogleCloudModel {
        public var email: String?
        public var displayName: String?
    }

    public struct EventDate: GoogleCloudModel {
        public var date: String?
        public var dateTime: String?
    }
}
