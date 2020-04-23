//
//  SearchResultsViewModeling.swift
//  iTunesSearch
//
//  Created by Ryan on 4/23/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

protocol SearchResultsViewModeling: class {
    var searchTerm: String { get }
    var songs: [Song] { get set }
    var delegate: SearchResultsViewModelDelegate? { get set }
    
    func performSearch()
    func showDetailPage(navigationController: UINavigationController, song: Song)
}
