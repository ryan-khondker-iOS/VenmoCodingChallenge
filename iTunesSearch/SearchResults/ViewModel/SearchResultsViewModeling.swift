//
//  SearchResultsViewModeling.swift
//  iTunesSearch
//
//  Created by Ryan on 4/23/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

/// Search Results view model protocol
protocol SearchResultsViewModeling: class {
    /// The search term entered by the user
    var searchTerm: String { get }
    
    /// The songs that were returned for the given search term
    var songs: [Song] { get set }
    
    /// Delegate object to handle the iTunes API response/results retrieval
    var delegate: SearchResultsViewModelDelegate? { get set }
    
    /// Performing a search with the given search term
    func performSearch()
    
    /**
    Showing the Detail page for the selected song
    - parameter navigationController: the UINavigationController where the view will be pushed
    - parameter song: the selected song
    */
    func showDetailPage(navigationController: UINavigationController, song: Song)
}

/// Delegate protocol to handle the iTunes API response/results retrieval
protocol SearchResultsViewModelDelegate: class {
    /// Called when we received search results that can be displayed
    func didGetSearchResults()
    
    /**
     Called when we get an error fetching the search results
     - parameter error: the received error
     */
    func didGetError(error: Error)
}
