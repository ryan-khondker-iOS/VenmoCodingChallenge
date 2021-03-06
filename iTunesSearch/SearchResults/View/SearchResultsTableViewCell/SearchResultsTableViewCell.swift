//
//  SearchResultsTableViewCell.swift
//  iTunesSearch
//
//  Created by Ryan on 4/22/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

/// Displays each song returned by the iTunes API for the given search term
class SearchResultsTableViewCell: UITableViewCell {
    @IBOutlet weak private var albumImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var artistLabel: UILabel!
    @IBOutlet weak private var albumLabel: UILabel!
    
    func setCell(song: Song) {
        titleLabel.text = song.title
        artistLabel.text = song.artist
        albumLabel.text = song.album
        
        if let albumImageUrl = song.albumUrl {
            ImageService.getImage(imageUrl: albumImageUrl) { [weak self] result in
                guard let strongSelf = self,
                    case let .success(albumImage) = result else { return }
                DispatchQueue.main.async {
                    strongSelf.albumImageView.image = albumImage
                }
            }
        }
    }
}
