//
//  CalendarEventsAPI.swift
//  GoogleCloud
//
//  Created by Emil Wojtaszek on 17/10/2018.
//

import Vapor

public protocol CalendarEventsAPI {
    func create(calendar: String, queryParameters: [String: String]?, body: HTTPBody) throws -> Future<CalendarEvent>
    func list(calendar: String, queryParameters: [String: String]?, body: HTTPBody) throws -> Future<CalendarObject>
}

extension CalendarEventsAPI {
    public func create(calendar: String, queryParameters: [String: String]? = nil, body: HTTPBody = .empty) throws -> Future<CalendarEvent> {
        return try create(calendar: calendar, queryParameters: queryParameters)
    }

    func list(calendar: String, queryParameters: [String: String]? = nil, body: HTTPBody = .empty) throws -> Future<CalendarObject> {
        return try list(calendar: calendar, queryParameters: queryParameters)
    }
}

public final class GoogleCalendarEventsAPI: CalendarEventsAPI {
    let endpoint = "https://www.googleapis.com/calendar/v3/calendars"
    let request: GoogleCalendarRequest

    init(request: GoogleCalendarRequest) {
        self.request = request
    }

    public func create(calendar: String, queryParameters: [String: String]? = nil, body: HTTPBody = .empty) throws -> Future<CalendarEvent> {
        return try request
            .send(method: .POST, path: "\(endpoint)/\(calendar)/events", query: queryParameters?.queryParameters ?? "", body: body)
    }

    public func list(calendar: String, queryParameters: [String: String]?, body: HTTPBody) throws -> Future<CalendarObject> {
        return try request
            .send(method: .GET, path: "\(endpoint)/\(calendar)/events", query: queryParameters?.queryParameters ?? "", body: body)
    }
}
