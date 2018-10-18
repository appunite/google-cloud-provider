//
//  CalendarClient.swift
//  GoogleCloud
//
//  Created by Emil Wojtaszek on 16/10/2018.
//

import Vapor

enum GoogleCalendarClientError: Error {
    case projectIdMissing
    case unknownError
}

public protocol CalendarClient: ServiceType {
    var events: CalendarEventsAPI { get set }
}

public final class GoogleCalendarClient: CalendarClient {
    public var events: CalendarEventsAPI
    
    init(providerconfig: GoogleCloudProviderConfig, client: Client) throws {
        let env = ProcessInfo.processInfo.environment
        
        // Locate the credentials to use for this client. In order of priority:
        // - Environment Variable Specified Credentials (GOOGLE_APPLICATION_CREDENTIALS)
        // - GoogleCloudProviderConfig's .serviceAccountCredentialPath (optionally configured)
        // - Application Default Credentials, located in the constant
        let preferredCredentialPath = env["GOOGLE_APPLICATION_CREDENTIALS"] ??
            providerconfig.serviceAccountCredentialPath ??
        "~/.config/gcloud/application_default_credentials.json"

        // define scope
        let scope = [CalendarScope.readWriteEvents]
            .map { $0.rawValue }

        // A token implementing OAuthRefreshable. Loaded from credentials defined above.
        let refreshableToken = try OAuthCredentialLoader
            .getRefreshableToken(credentialFilePath: preferredCredentialPath, withClient: client, scope: scope)
        
        // Set the projectId to use for this client. In order of priority:
        // - Environment Variable (PROJECT_ID)
        // - GoogleCloudProviderConfig's .project (optionally configured)
        guard let projectId = env["PROJECT_ID"] ?? providerconfig.project ?? (refreshableToken as? OAuthServiceAccount)?.credentials.projectId else {
            throw GoogleCalendarClientError.projectIdMissing
        }
        
        let calendarRequest = GoogleCalendarRequest(httpClient: client, oauth: refreshableToken, project: projectId)
        
        events = GoogleCalendarEventsAPI(request: calendarRequest)
    }
    
    public static var serviceSupports: [Any.Type] { return [CalendarClient.self] }
    
    public static func makeService(for worker: Container) throws -> GoogleCalendarClient {
        let client = try worker.make(Client.self)
        let providerConfig = try worker.make(GoogleCloudProviderConfig.self)
        
        return try GoogleCalendarClient(providerconfig: providerConfig, client: client)
    }
}

