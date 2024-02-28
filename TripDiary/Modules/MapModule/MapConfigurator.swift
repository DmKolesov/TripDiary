//
//  MapConfigurator.swift
//  TripDiary
//
//  Created by TX 3000 on 15.07.2023.
//

import Foundation

protocol MapConfiguratorProtocol {
    func configureMapViewController() -> MapViewControllerProtocol
}

class MapConfigurator: MapConfiguratorProtocol {
    func configureMapViewController() -> MapViewControllerProtocol {
        let viewController = MapViewController()
        let mapService = MapService()
        let router = Router()
        let presenter = MapPresenter(view: viewController, mapService: mapService, router: router)
        router.viewController = viewController
        viewController.presenter = presenter
        return viewController
    }
}
