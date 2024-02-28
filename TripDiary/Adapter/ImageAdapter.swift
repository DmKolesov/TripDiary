//
//  ImageAdapter.swift
//  TripDiary
//
//  Created by TX 3000 on 20.07.2023.
//

import Foundation
import UIKit
import Alamofire

struct ImageURLAdapter {
    /// Convert UIImage to URL
    func imageURL(from image: UIImage, compressionQuality: CGFloat = 0.8) -> URL? {
        guard let imageData = image.jpegData(compressionQuality: compressionQuality) else {
            return nil
        }
        
        let fileName = "\(UUID().uuidString).jpg"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            try imageData.write(to: fileURL)
            return fileURL
        } catch {
            print("Error saving image to file: \(error)")
            return nil
        }
    }
    
    /// Convert UIImage to Data
    func imageData(from image: UIImage, compressionQuality: CGFloat = 0.8) -> Data? {
        return image.jpegData(compressionQuality: compressionQuality)
    }
    
    /// Convert URL to UIImage
    func image(from url: URL, completion: @escaping (UIImage?) -> Void) {
            AF.download(url).responseData { response in
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
    
    /// Convert Data to UIImage
    func image(from data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
    /// Convert URL to String
    func urlString(from url: URL) -> String {
        return url.absoluteString
    }
    
    /// Convert String to URL
    func url(from urlString: String) -> URL? {
        return URL(string: urlString)
    }
}
