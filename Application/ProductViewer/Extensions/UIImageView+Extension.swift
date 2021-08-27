//
//  UIImageView+Extension.swift
//  ProductViewer
//
//  Created by David Truong on 8/26/21.
//  Copyright © 2021 Target. All rights reserved.
//

import UIKit

extension UIImageView {
    
    static var imageCache = NSCache<AnyObject, AnyObject>()
    
    func loadImageFrom(_ imageUrl: String) -> URLSessionDataTask? {
        self.image = nil
        
        if let cacheImage = UIImageView.imageCache.object(forKey: imageUrl as AnyObject) as? UIImage {
            self.image = cacheImage
            return nil
        }
        
        guard let url = URL(string: imageUrl) else { return nil }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                //print("Error downloading image: \(error?.localizedDescription)") // Prints if cancelled task due to cell reuse
                return
            }

            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    UIImageView.imageCache.setObject(image, forKey: imageUrl as AnyObject)
                    self.image = image
                }
            }
        }
        task.resume()
        return task
    }
    
}
