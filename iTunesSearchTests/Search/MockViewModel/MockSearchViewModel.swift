//
//  MockSearchViewModel.swift
//  iTunesSearchTests
//
//  Created by Ryan on 4/23/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit
@testable import iTunesSearch

final class MockSearchViewModel: SearchViewModeling {
    var recentSearches = NSMutableArray()
    
    func fetchRecentSearches() {
        recentSearches = ["search1", "search2", "search3", "search4"]
    }
    
    func clearRecentSearches(completion: @escaping () -> Void) {
        recentSearches = NSMutableArray()
    }
    
    func showSearchResultsPage(navigationController: UINavigationController, searchTerm: String) {
        updateRecentSearchesArray(searchTerm: searchTerm)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let resultsVC = storyboard.instantiateViewController(withIdentifier: "SearchResultsVC") as? SearchResultsViewController else {
            fatalError("SearchResultsVC does not exist")
        }
        resultsVC.viewModel = MockSearchResultsViewModel(searchTerm: searchTerm, delegate: resultsVC)
        navigationController.pushViewController(resultsVC, animated: true)
    }
}

// MARK: - Private Helpers
private extension MockSearchViewModel {
    func updateRecentSearchesArray(searchTerm: String) {
        if recentSearches.count == 0 {
            recentSearches.add(searchTerm)
        }
        else {
            moveSearchTermToBeginningOfArray(searchTerm: searchTerm)
        }
    }
    
    func moveSearchTermToBeginningOfArray(searchTerm: String) {
        if recentSearches.contains(searchTerm) {
            recentSearches = NSMutableArray(array: recentSearches.filter { $0 as? String != searchTerm })
        }
        recentSearches.insert(searchTerm, at: 0)
    }
}
