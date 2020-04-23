//
//  SearchViewController.swift
//  iTunesSearch
//
//  Created by Ryan on 4/21/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit
import CoreData

private enum Constants {
    static let cellIdentifier = "Cell"
    static let recentSearchesHeaderCellIdentifier = "RecentSearchesHeader"
}

/// View controller class for the Search page
final class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var recentSearchesTableView: UITableView!
    
    var viewModel: SearchViewModeling = SearchViewModel()
    let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "iTunes Search"
        
        setupTable()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchRecentSearches()
        self.recentSearchesTableView.reloadData()
    }
}

// MARK: - Private Setup Methods
private extension SearchViewController {
    func setupTable() {
        recentSearchesTableView.dataSource = self
        recentSearchesTableView.delegate = self
        
        registerTableViewCells()
    }
    
    func registerTableViewCells() {
        // MARK: - Recent Searches Header Cell
        let bundle = Bundle(for: RecentSearchesHeaderCell.self)
        let nib = UINib(nibName: "RecentSearchesHeaderCell", bundle: bundle)
        recentSearchesTableView.register(nib, forCellReuseIdentifier: Constants.recentSearchesHeaderCellIdentifier)
        
        // MARK: - Recent Searches Cell
        recentSearchesTableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: Constants.cellIdentifier
        )
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        searchBar.enablesReturnKeyAutomatically = true
    }
}

// MARK: - Table view data source
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recentSearches.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.recentSearchesHeaderCellIdentifier) as? RecentSearchesHeaderCell else { return nil }
        cell.delegate = self
        return cell
    }
     

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIdentifier,
            for: indexPath
        )
        cell.textLabel?.text = viewModel.recentSearches[indexPath.row] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let navController = navigationController,
            let searchTerm = viewModel.recentSearches[indexPath.row] as? String else { return }
        viewModel.showSearchResultsPage(navigationController: navController, searchTerm: searchTerm)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let navController = navigationController,
            let searchTerm = searchBar.text,
            !searchTerm.isEmpty else { return }
        searchBar.resignFirstResponder()
        searchBar.text = ""
        viewModel.showSearchResultsPage(navigationController: navController, searchTerm: searchTerm)
    }
}

// MARK: - RecentSearchesHeaderCellDelegate
extension SearchViewController: RecentSearchesHeaderCellDelegate {
    func didPressClearRecentSearches() {
        guard viewModel.recentSearches.count != 0 else { return }
        viewModel.clearRecentSearches { [weak self] in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.recentSearchesTableView.reloadData()
            }
        }
    }
}
