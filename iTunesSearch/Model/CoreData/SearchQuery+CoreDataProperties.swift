//
//  SearchQuery+CoreDataProperties.swift
//  iTunesSearch
//
//  Created by Ryan on 4/23/20.
//  Copyright © 2020 Ryan. All rights reserved.
//
//

import Foundation
import CoreData

extension SearchQuery {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchQuery> {
        return NSFetchRequest<SearchQuery>(entityName: "SearchQuery")
    }
    
    @NSManaged public var term: String
    @NSManaged public var searchResults: Set<SearchResult>
}

// MARK: Generated accessors for searchResults
extension SearchQuery {
    @objc(addSearchResultsObject:)
    @NSManaged public func addToSearchResults(_ value: SearchResult)
    
    @objc(removeSearchResultsObject:)
    @NSManaged public func removeFromSearchResults(_ value: SearchResult)
    
    @objc(addSearchResults:)
    @NSManaged public func addToSearchResults(_ values: Set<SearchResult>)
    
    @objc(removeSearchResults:)
    @NSManaged public func removeFromSearchResults(_ values: Set<SearchResult>)
}
