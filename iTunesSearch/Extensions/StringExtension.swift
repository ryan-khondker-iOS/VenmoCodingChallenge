//
//  StringExtension.swift
//  iTunesSearch
//
//  Created by Ryan on 4/22/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import Foundation

extension String {
    func addPercentEncodingForSearchTerm() -> String? {
        let allowedCharacterString = "*-._ "
        let allowedCharacterSet = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: allowedCharacterString))
        
        return addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)?.replacingOccurrences(of: " ", with: "+")
    }
}
