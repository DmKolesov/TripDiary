//
//  UIImageImageData.swift
//  TripDiary
//
//  Created by TX 3000 on 20.07.2023.
//

import Foundation
import UIKit

protocol ImageDataProtocol {
    func imageURL() -> URL?
    func imageData() -> Data?
}

class UIImageData: ImageDataProtocol {
    private let image: UIImage
    private let adapter: ImageURLAdapter
    
    init(image: UIImage, adapter: ImageURLAdapter) {
        self.image = image
        self.adapter = adapter
    }
    
    convenience init(image: UIImage) {
        self.init(image: image, adapter: ImageURLAdapter())
    }

    func imageURL() -> URL? {
        return adapter.imageURL(from: image)
    }

    func imageData() -> Data? {
        return adapter.imageData(from: image)
    }
}

extension Data: ImageDataProtocol {
    func imageURL() -> URL? {
        return nil
    }
    
    func imageData() -> Data? {
        return self
    }
}
