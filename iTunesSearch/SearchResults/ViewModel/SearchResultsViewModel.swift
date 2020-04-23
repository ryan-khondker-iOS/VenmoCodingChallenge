//
//  SearchResultsViewModel.swift
//  iTunesSearch
//
//  Created by Ryan on 4/22/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit
import CoreData

/// View model for the Search Results page
final class SearchResultsViewModel: SearchResultsViewModeling {
    let searchTerm: String
    var songs: [Song] = []
    
    weak var delegate: SearchResultsViewModelDelegate?
    
    init(searchTerm: String, delegate: SearchResultsViewModelDelegate?) {
        self.searchTerm = searchTerm
        self.delegate = delegate
    }
    
    func performSearch() {
        // Get results from CoreData first if they exist
        let searchResults = CoreDataService.fetchSearchResults(searchTerm: searchTerm)
        songs = searchResults.map { searchResult in
            return Song(
                title: searchResult.songTitle,
                artist: searchResult.artist,
                album: searchResult.album,
                albumUrl: searchResult.albumUrl
            )
        }
        
        if !songs.isEmpty {
            delegate?.didGetSearchResults()
            return
        }
        
        // If no results from CoreData, then get the results from the API
        ApiService.getResults(searchTerm: searchTerm) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case let .failure(error):
                strongSelf.delegate?.didGetError(error: error)
            case let .success(songResults):
                guard !songResults.songs.isEmpty else {
                    strongSelf.delegate?.didGetError(error: NetworkError.noResults(searchTerm: strongSelf.searchTerm))
                    return
                }
                strongSelf.songs = songResults.songs
                CoreDataService.saveSearchResults(searchTerm: strongSelf.searchTerm, songs: songResults.songs)
                strongSelf.delegate?.didGetSearchResults()
            }
        }
    }
    
    func showDetailPage(navigationController: UINavigationController, song: Song) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController else {
            fatalError("DetailVC does not exist")
        }
        detailVC.viewModel = DetailViewModel(song: song)
        navigationController.pushViewController(detailVC, animated: true)
    }
}
