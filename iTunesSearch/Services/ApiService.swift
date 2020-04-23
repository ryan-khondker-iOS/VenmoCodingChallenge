//
//  ApiService.swift
//  iTunesSearch
//
//  Created by Ryan on 4/22/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import Foundation

private enum Constants {
    static let baseUrl = "https://itunes.apple.com/search?term=[SEARCH_TERM]&media=music&entity=song"
    static let searchTermPlaceholder = "[SEARCH_TERM]"
}

final class ApiService {
    /**
     This method is used to query the iTunes API for a given search term.
     If we get a valid response back from the API, we then convert it to
     a SongResults object and pass the object when we call the completion.
     If we get an error, then we pass the error when we call the completion
     - parameter searchTerm: the search term entered by the user
     - parameter completion: the completion block to be called once the API call is complete or if there are errors when making the API call
     */
    class func getResults(searchTerm: String, completion: @escaping (Result<SongResults, Error>) -> Void) {
        let urlString = getFormattedUrl(searchTerm: searchTerm)
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.badUrl))
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) {
            data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.badResponse))
                return
            }
            
            guard response.statusCode == 200 else {
                completion(.failure(NetworkError.httpError(code: response.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let songResults = try JSONDecoder().decode(SongResults.self, from: data)
                completion(.success(songResults))
                return
            }
            catch let error {
                completion(.failure(error))
                return
            }
        }
        task.resume()
    }
    
    private class func getFormattedUrl(searchTerm: String) -> String {
        let formattedSearchTerm = searchTerm.addPercentEncodingForSearchTerm() ?? searchTerm
        return Constants.baseUrl.replacingOccurrences(of: Constants.searchTermPlaceholder, with: formattedSearchTerm)
    }
}
