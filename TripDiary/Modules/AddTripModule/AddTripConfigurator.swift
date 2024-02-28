//
//  AddTripConfigurator.swift
//  TripDiary
//
//  Created by TX 3000 on 12.07.2023.
//

import Foundation
import UIKit

protocol AddTripConfiguratorProtocol {
    func configureAddTripViewController() -> AddTripViewControllerProtocol
}

class AddTripConfigurator: AddTripConfiguratorProtocol {
    func configureAddTripViewController() -> AddTripViewControllerProtocol {
        let viewController = AddTripViewController()
        let router = Router()
        let realmService = RealmService()
        let storage = FirebaseStorageManager()
        let mapper = TripsRealmMapper()
        let dataManager = RealmDataManager(realmService: realmService, mapper: mapper)
        let imageUploadService = ImageUploadService(firebaseStorageManager: storage)
        let presenter = AddTripPresenter(view: viewController, router: router, dataManager: dataManager, storage: storage, imageUploadService: imageUploadService)
        router.viewController = viewController
        viewController.presenter = presenter
        return viewController
    }
}
