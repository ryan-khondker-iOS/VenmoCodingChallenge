//
//  DetailViewModel.swift
//  iTunesSearch
//
//  Created by Ryan on 4/23/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import Foundation

final class DetailViewModel: DetailViewModeling {
    let song: Song
    
    init(song: Song) {
        self.song = song
    }
}
