//
//  GlobalCache.swift
//  iTunesSearch
//
//  Created by Ryan on 4/22/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

final class GlobalCache {
    static let shared = GlobalCache()
    
    /// Using a Global Cache to cache images
    var imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
}
