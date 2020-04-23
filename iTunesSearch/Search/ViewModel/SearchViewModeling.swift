//
//  SearchViewModeling.swift
//  iTunesSearch
//
//  Created by Ryan on 4/23/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

protocol SearchViewModeling: class {
    var recentSearches: NSMutableArray { get set }
    
    func fetchRecentSearches()
    func clearRecentSearches(completion: @escaping () -> Void)
    func showSearchResultsPage(navigationController: UINavigationController, searchTerm: String)
}
