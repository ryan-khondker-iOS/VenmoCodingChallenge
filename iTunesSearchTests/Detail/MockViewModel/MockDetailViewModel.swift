//
//  MockDetailViewModel.swift
//  iTunesSearchTests
//
//  Created by Ryan on 4/23/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import Foundation
@testable import iTunesSearch

final class MockDetailViewModel: DetailViewModeling {
    var song: Song
    
    init(song: Song) {
        self.song = song
    }
}
