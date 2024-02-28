//
//  ImageService.swift
//  TripDiary
//
//  Created by TX 3000 on 31.07.2023.
//

import Foundation
import Alamofire
import UIKit

class ImageAPIService {
    
    static let shared = ImageAPIService()
    private let session: Session
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(memoryCapacity: 100 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: "imageCache")
        self.session = Session(configuration: configuration)
    }
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedResponse = session.sessionConfiguration.urlCache?.cachedResponse(for: URLRequest(url: url)) {
            let image = UIImage(data: cachedResponse.data)
            completion(image)
        } else {
            session.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    let image = UIImage(data: data)
                    completion(image)
                case .failure(let error):
                    print("Error loading image: \(error)")
                    completion(nil)
                }
            }
        }
    }
}
