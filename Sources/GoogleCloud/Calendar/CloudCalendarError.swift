import Vapor

// https://cloud.google.com/storage/docs/json_api/v1/status-codes
public struct CalendarError: GoogleCloudModel, Error, Debuggable {
    public var identifier: String {
        return "\(self.error.code)-\(self.error.message)"
    }
    
    public var reason: String {
        return self.error.message
    }
    
    public var error: CalendarErrorBody
}

public struct CalendarErrorBody: Content {
    public var errors: [CalendarErrors]
    public var code: Int
    public var message: String
}

public struct CalendarErrors: Content {
    public var domain: String?
    public var reason: String?
    public var message: String?
    public var locationType: String?
    public var location: String?
}
