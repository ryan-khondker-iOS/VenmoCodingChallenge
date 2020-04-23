//
//  SongResults.swift
//  iTunesSearch
//
//  Created by Ryan on 4/22/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import Foundation

struct SongResults: Codable {
    var songs: [Song]
    
    enum CodingKeys: String, CodingKey {
        case songs = "results"
    }
}
