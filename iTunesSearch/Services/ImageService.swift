//
//  ImageService.swift
//  iTunesSearch
//
//  Created by Ryan on 4/22/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

final class ImageService {
    class func getImage(imageUrl: String, completion: @escaping (UIImage?, Error?) -> ()) {
        if let image = GlobalCache.shared.imageCache.object(forKey: imageUrl as NSString) {
            completion(image, nil)
            return
        }
        guard let url = URL(string: imageUrl) else {
            completion(nil, NetworkError.badUrl)
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) {
            data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, NetworkError.badResponse)
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(nil, NetworkError.httpError(code: httpResponse.statusCode))
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }
            guard let image = UIImage(data: data) else {
                completion(nil, NetworkError.badData)
                return
            }
            GlobalCache.shared.imageCache.setObject(image, forKey: imageUrl as NSString)
            completion(image, nil)
            return
        }
        task.resume()
    }
}
