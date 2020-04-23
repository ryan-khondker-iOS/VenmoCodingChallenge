//
//  RecentSearchesHeaderCell.swift
//  iTunesSearch
//
//  Created by Ryan on 4/22/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

protocol RecentSearchesHeaderCellDelegate: class {
    func didPressClearRecentSearches()
}

class RecentSearchesHeaderCell: UITableViewCell {
    weak var delegate: RecentSearchesHeaderCellDelegate?
    
    @IBAction func didPressClear(_ sender: Any) {
        delegate?.didPressClearRecentSearches()
    }
}
