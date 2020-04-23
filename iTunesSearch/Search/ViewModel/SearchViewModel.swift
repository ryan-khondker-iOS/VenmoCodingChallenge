//
//  SearchViewModel.swift
//  iTunesSearch
//
//  Created by Ryan on 4/21/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

/// View model for the Search page
final class SearchViewModel: SearchViewModeling {
    var recentSearches = NSMutableArray()
    var documentPlistPath = ""
    
    func fetchRecentSearches() {
        preparePlistForUse()
        guard let plistData = FileManager.default.contents(atPath: documentPlistPath) else { return }
        do {
            guard let plistArray = try PropertyListSerialization.propertyList(from: plistData, options: .mutableContainersAndLeaves, format: nil) as? NSMutableArray else { return }
            recentSearches = plistArray
        }
        catch let error as NSError {
            print("Unable to serialize plist. \(error.localizedDescription)")
        }
    }
    
    func clearRecentSearches(completion: @escaping () -> Void) {
        recentSearches = NSMutableArray()
        recentSearches.write(toFile: documentPlistPath, atomically: true)
        completion()
    }
    
    func showSearchResultsPage(navigationController: UINavigationController, searchTerm: String) {
        updateRecentSearchesArray(searchTerm: searchTerm)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let resultsVC = storyboard.instantiateViewController(withIdentifier: "SearchResultsVC") as? SearchResultsViewController else {
            fatalError("SearchResultsVC does not exist")
        }
        resultsVC.viewModel = SearchResultsViewModel(searchTerm: searchTerm, delegate: resultsVC)
        navigationController.pushViewController(resultsVC, animated: true)
    }
}

// MARK: - Private Helpers
private extension SearchViewModel {
    func preparePlistForUse() {
        guard let rootPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, .userDomainMask, true).first else { return }
        documentPlistPath = rootPath.appending("/RecentSearches.plist")
        
        if !FileManager.default.fileExists(atPath: documentPlistPath) {
            guard let bundlePlistPath = Bundle.main.path(forResource: "RecentSearches", ofType: "plist") else { return }
            do {
                try FileManager.default.copyItem(atPath: bundlePlistPath, toPath: documentPlistPath)
            }
            catch let error as NSError {
                print("Unable to copy plist. \(error.localizedDescription)")
            }
        }
    }
    
    /**
     This method adds the entered search term to the beginning of the list,
     so that the most recently entered search term is at the top of the list.
     Afterwards, we store the recent searches locally
     */
    func updateRecentSearchesArray(searchTerm: String) {
        if recentSearches.count == 0 {
            recentSearches.add(searchTerm)
        }
        else {
            moveSearchTermToBeginningOfArray(searchTerm: searchTerm)
        }
        recentSearches.write(toFile: documentPlistPath, atomically: true)
    }
    
    func moveSearchTermToBeginningOfArray(searchTerm: String) {
        if recentSearches.contains(searchTerm) {
            recentSearches = NSMutableArray(array: recentSearches.filter { $0 as? String != searchTerm })
        }
        recentSearches.insert(searchTerm, at: 0)
    }
}
