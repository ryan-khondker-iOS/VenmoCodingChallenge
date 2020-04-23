//
//  DetailViewController.swift
//  iTunesSearch
//
//  Created by Ryan on 4/23/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit
import AVFoundation

/// View controller class for the Song Details page
class DetailViewController: UIViewController {
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    
    var viewModel: DetailViewModeling?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Song Details"
        setupView()
    }
    
    private func setupView() {
        guard let song = viewModel?.song else { return }
        
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
