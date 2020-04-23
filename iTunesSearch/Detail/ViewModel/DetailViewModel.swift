//
//  DetailViewModel.swift
//  iTunesSearch
//
//  Created by Ryan on 4/23/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import Foundation

/// View model for the Song Details page
final class DetailViewModel: DetailViewModeling {
    let song: Song
    
    init(song: Song) {
        self.song = song
    }
}
