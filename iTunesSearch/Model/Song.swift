//
//  Song.swift
//  iTunesSearch
//
//  Created by Ryan on 4/22/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import Foundation

struct Song: Codable {
    var title: String
    var artist: String
    var album: String
    var albumUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case artist = "artistName"
        case album = "collectionName"
        case albumUrl = "artworkUrl100"
    }
}
