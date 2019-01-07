//
//  CalendarObject.swift
//  GoogleCloud
//
//  Created by Emil Wojtaszek on 07/01/2019.
//

import Vapor

public struct CalendarObject: GoogleCloudModel {
    public var kind: String
    public var etag: String
    public var summary: String
    public var timeZone: String
    public var nextSyncToken: String
    public var items: [CalendarEvent]
}
