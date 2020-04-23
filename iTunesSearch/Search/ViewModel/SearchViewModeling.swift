//
//  SearchViewModeling.swift
//  iTunesSearch
//
//  Created by Ryan on 4/23/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

/// Search page view model protocol
protocol SearchViewModeling: class {
    var recentSearches: NSMutableArray { get set }
    
    /// Fetching persisted recently searched terms
    func fetchRecentSearches()
    
    /**
     Clearing the persisted recently searched terms
     - parameter completion: the completion block to be called when the recent searches is cleared
     */
    func clearRecentSearches(completion: @escaping () -> Void)
    
    /**
     Showing the Search Results page for the given search term
     - parameter navigationController: the UINavigationController where the view will be pushed
     - parameter searchTerm: the search term entered by the user
     */
    func showSearchResultsPage(navigationController: UINavigationController, searchTerm: String)
}
