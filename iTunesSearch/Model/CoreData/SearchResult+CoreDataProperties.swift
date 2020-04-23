//
//  SearchResult+CoreDataProperties.swift
//  iTunesSearch
//
//  Created by Ryan on 4/23/20.
//  Copyright © 2020 Ryan. All rights reserved.
//
//

import Foundation
import CoreData

extension SearchResult {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchResult> {
        return NSFetchRequest<SearchResult>(entityName: "SearchResult")
    }
    
    @NSManaged public var album: String
    @NSManaged public var albumUrl: String?
    @NSManaged public var artist: String
    @NSManaged public var songTitle: String
    @NSManaged public var searchQueries: Set<SearchQuery>
}

// MARK: Generated accessors for searchQueries
extension SearchResult {
    @objc(addSearchQueriesObject:)
    @NSManaged public func addToSearchQueries(_ value: SearchQuery)
    
    @objc(removeSearchQueriesObject:)
    @NSManaged public func removeFromSearchQueries(_ value: SearchQuery)
    
    @objc(addSearchQueries:)
    @NSManaged public func addToSearchQueries(_ values: Set<SearchQuery>)
    
    @objc(removeSearchQueries:)
    @NSManaged public func removeFromSearchQueries(_ values: Set<SearchQuery>)
}
