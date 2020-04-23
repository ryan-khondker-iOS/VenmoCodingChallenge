//
//  SearchResultsViewController.swift
//  iTunesSearch
//
//  Created by Ryan on 4/22/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

private enum Constants {
    static let cellIdentifier = "ResultsCell"
}

/// View controller class for the Search Results page
final class SearchResultsViewController: UITableViewController {
    var viewModel: SearchResultsViewModeling?
    
    /// Loading indicator to be displayed while we are fetching the search results
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel?.searchTerm
        
        setupLoadingIndicator()
        setupTable()
        
        self.loadingIndicator.startAnimating()
        
        guard let viewModel = viewModel else {
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
            }
            return
        }
        viewModel.performSearch()
    }
}

// MARK: - Private Setup Methods
private extension SearchResultsViewController {
    func setupLoadingIndicator() {
        loadingIndicator.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        tableView.addSubview(loadingIndicator)
    }
    
    func setupTable() {
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        
        registerTableViewCell()
    }
    
    func registerTableViewCell() {
        let bundle = Bundle(for: SearchResultsTableViewCell.self)
        let nib = UINib(nibName: "SearchResultsTableViewCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: Constants.cellIdentifier)
    }
}

// MARK: - Table view data source
extension SearchResultsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let songs = viewModel?.songs else { return 0 }
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let resultsCell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? SearchResultsTableViewCell else {
            fatalError("ResultsCell does not exist")
        }
        guard let song = viewModel?.songs[indexPath.row] else {
            return resultsCell
        }
        resultsCell.setCell(song: song)
        return resultsCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let navController = navigationController,
            let song = viewModel?.songs[indexPath.row] else { return }
        viewModel?.showDetailPage(navigationController: navController, song: song)
    }
}

extension SearchResultsViewController: SearchResultsViewModelDelegate {
    func didGetSearchResults() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func didGetError(error: Error) {
        let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(okAction)
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.present(alertVC, animated: true)
        }
    }
}
