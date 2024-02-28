//
//  TripCofigurator.swift
//  TripDiary
//
//  Created by TX 3000 on 12.07.2023.
//

import Foundation
import UIKit

protocol TripConfiguratorProtocol {
    func configureTripViewController() -> TripViewControllerProtocol
}

class TripConfigurator: TripConfiguratorProtocol {
    func configureTripViewController() -> TripViewControllerProtocol {
        let viewController = TripViewController()
        let router = Router()
        let realmService = RealmService()
        let mapper = TripsRealmMapper()
        let dataManager = RealmDataManager(realmService: realmService, mapper: mapper)
        let presenter = TripPresenter(view: viewController, router: router, dataManager: dataManager)
        router.viewController = viewController
        viewController.presenter = presenter
        return viewController
    }
}
