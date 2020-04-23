//
//  ImageService.swift
//  iTunesSearch
//
//  Created by Ryan on 4/22/20.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

final class ImageService {
    /**
    This method is used to fetch the image data from the given image URL.
    If we get valid data back from the API, we then create a UIImage object
    and pass the image to the completion block. If we get an error when
    fetching the image data, then we pass the error to the completion block
    - parameter imageUrl: the URL of the image
    - parameter completion: the completion block to be called once HTTP request is complete or if there are errors when making the request
    */
    class func getImage(imageUrl: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        if let image = GlobalCache.shared.imageCache.object(forKey: imageUrl as NSString) {
            completion(.success(image))
            return
        }
        guard let url = URL(string: imageUrl) else {
            completion(.failure(NetworkError.badUrl))
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) {
            data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.badResponse))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.httpError(code: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            guard let image = UIImage(data: data) else {
                completion(.failure(NetworkError.badData))
                return
            }
            GlobalCache.shared.imageCache.setObject(image, forKey: imageUrl as NSString)
            completion(.success(image))
            return
        }
        task.resume()
    }
}
