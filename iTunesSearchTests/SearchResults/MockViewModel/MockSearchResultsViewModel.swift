//
//  MockSearchResultsViewModel.swift
//  iTunesSearchTests
//
//  Created by Ryan on 4/23/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit
@testable import iTunesSearch

final class MockSearchResultsViewModel: SearchResultsViewModeling {
    var searchTerm: String
    var songs: [Song] = []
    
    weak var delegate: SearchResultsViewModelDelegate?
    
    init(searchTerm: String, delegate: SearchResultsViewModelDelegate?) {
        self.searchTerm = searchTerm
        self.delegate = delegate
    }
    
    func performSearch() {
        songs = [
            Song(title: "Title1", artist: "Artist1", album: "Album1", albumUrl: "AlbumURL1"),
            Song(title: "Title2", artist: "Artist2", album: "Album2", albumUrl: "AlbumURL2"),
            Song(title: "Title3", artist: "Artist3", album: "Album3", albumUrl: "AlbumURL3"),
            Song(title: "Title4", artist: "Artist4", album: "Album4", albumUrl: "AlbumURL4")
        ]
        delegate?.didGetSearchResults()
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
