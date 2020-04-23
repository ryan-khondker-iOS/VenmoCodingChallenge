//
//  NetworkError.swift
//  iTunesSearch
//
//  Created by Ryan on 4/22/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case badResponse
    case httpError(code: Int)
    case noData
    case badData
    case noResults(searchTerm: String)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .noResults(searchTerm):
            return NSLocalizedString(
                "We're sorry, no results found for \"\(searchTerm)\"",
                comment: ""
            )
        default:
            return NSLocalizedString(
                "Error fetching results",
                comment: ""
            )
        }
    }
}
