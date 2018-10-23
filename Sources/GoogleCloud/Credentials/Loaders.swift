//
//  Loaders.swift
//  Async
//
//  Created by Brian Hatfield on 7/17/18.
//

import Foundation

enum CredentialLoadError: Error {
    case fileLoadError
    case noValidFileError
    case missingEnvironmentVariable
}

extension GoogleApplicationDefaultCredentials {
    init(contentsOfFile path: String) throws {
        let decoder = JSONDecoder()
        let filePath = NSString(string: path).expandingTildeInPath

        if let contents = try String(contentsOfFile: filePath).data(using: .utf8) {
            self = try decoder.decode(GoogleApplicationDefaultCredentials.self, from: contents)
        } else {
            throw CredentialLoadError.fileLoadError
        }
    }
}

extension GoogleServiceAccountCredentials {
    init(contentsOfFile path: String) throws {
        let decoder = JSONDecoder()
        let filePath = NSString(string: path).expandingTildeInPath

        if let contents = try String(contentsOfFile: filePath).data(using: .utf8) {
            self = try decoder.decode(GoogleServiceAccountCredentials.self, from: contents)
        } else {
            throw CredentialLoadError.fileLoadError
        }
    }
    
    init(environmentVariable key: String) throws {
        let decoder = JSONDecoder()
        guard let rawString = ProcessInfo.processInfo.environment[key] else { throw CredentialLoadError.missingEnvironmentVariable }
        
        if let contents = rawString.data(using: .utf8) {
            self = try decoder.decode(GoogleServiceAccountCredentials.self, from: contents)
        } else {
            throw CredentialLoadError.fileLoadError
        }
    }
}
