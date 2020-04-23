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
    class func getResults(searchTerm: String, completion: @escaping (SongResults?, Error?) -> ()) {
        let urlString = getFormattedUrl(searchTerm: searchTerm)
        guard let url = URL(string: urlString) else {
            completion(nil, NetworkError.badUrl)
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) {
            data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, NetworkError.badResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                completion(nil, NetworkError.httpError(code: response.statusCode))
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }
            
            do {
                let songResults = try JSONDecoder().decode(SongResults.self, from: data)
                completion(songResults, nil)
                return
            }
            catch let error {
                completion(nil, error)
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
