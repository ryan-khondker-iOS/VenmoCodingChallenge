//
//  CoreDataService.swift
//  iTunesSearch
//
//  Created by Ryan on 4/23/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit
import CoreData

private enum Constants {
    // Entities
    static let searchQueryEntity = "SearchQuery"
    
    // SearchQuery Keys
    static let termKey = "term"
}

final class CoreDataService {
    static let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    /**
     Class method used to fetch the search results from CoreData
     for a given search term if they exist
     - parameter searchTerm: the search term entered by the user
     */
    class func fetchSearchResults(searchTerm: String) -> [SearchResult] {
        guard let context = managedContext else { return [] }
        
        let fetchRequest = NSFetchRequest<SearchQuery>(entityName: Constants.searchQueryEntity)
        fetchRequest.predicate = NSPredicate(format: "\(Constants.termKey) == %@", searchTerm)
        var results: [SearchResult] = []
        do {
            let queries = try context.fetch(fetchRequest)
            queries.forEach { query in
                results.append(contentsOf: query.searchResults)
            }
        }
        catch let error as NSError {
            print("Unable to fetch. \(error.localizedDescription)")
        }
        return results
    }
    
    /**
    Class method used to save the search results/songs
    for a given search term in CoreData
    - parameter searchTerm: the search term entered by the user
    - parameter songs: the songs/search results returned for the given search term
    */
    class func saveSearchResults(searchTerm: String, songs: [Song]) {
        guard let context = managedContext else { return }
        
        let searchQuery = SearchQuery(context: context)
        searchQuery.term = searchTerm
        
        songs.forEach { song in
            let searchResult = SearchResult(context: context)
            
            searchResult.songTitle = song.title
            searchResult.artist = song.artist
            searchResult.album = song.album
            searchResult.albumUrl = song.albumUrl
            
            searchQuery.addToSearchResults(searchResult)
        }
        context.insert(searchQuery)
        
        do {
            try context.save()
        }
        catch let error as NSError {
            print("Unable to save context. \(error.localizedDescription)")
        }
    }
}
