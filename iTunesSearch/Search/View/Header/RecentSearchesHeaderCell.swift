//
//  RecentSearchesHeaderCell.swift
//  iTunesSearch
//
//  Created by Ryan on 4/22/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

/**
 Delegate protocol to handle the user pressing the "CLEAR" button
 in the Recent Searches header
 */
protocol RecentSearchesHeaderCellDelegate: class {
    /// Handles the user pressing the "CLEAR" button
    func didPressClearRecentSearches()
}

/// The header for the Recent Searches shown on the Search page
class RecentSearchesHeaderCell: UITableViewCell {
    weak var delegate: RecentSearchesHeaderCellDelegate?
    
    @IBAction func didPressClear(_ sender: Any) {
        delegate?.didPressClearRecentSearches()
    }
}
