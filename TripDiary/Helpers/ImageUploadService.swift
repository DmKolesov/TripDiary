//
//  ImageUploadService.swift
//  TripDiary
//
//  Created by TX 3000 on 01.08.2023.
//

import Foundation

protocol ImageUploadServiceProtocol {
    func uploadImages(_ imageDataArray: [Data], completion: @escaping (Result<[URL], Error>) -> Void)
}

class ImageUploadService: ImageUploadServiceProtocol {
    
    private let firebaseStorageManager: FireBaseStorageProtocol
    
    init(firebaseStorageManager: FireBaseStorageProtocol) {
        self.firebaseStorageManager = firebaseStorageManager
    }

    func uploadImages(_ imageDataArray: [Data], completion: @escaping (Result<[URL], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        var downloadURLs: [URL] = []

        for imageData in imageDataArray {
            dispatchGroup.enter()
            firebaseStorageManager.uploadImage(data: imageData) { result in
                switch result {
                case .success(let downloadURL):
                    downloadURLs.append(downloadURL)
                case .failure(let error):
                    completion(.failure(error))
                    return
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(.success(downloadURLs))
        }
    }
}
