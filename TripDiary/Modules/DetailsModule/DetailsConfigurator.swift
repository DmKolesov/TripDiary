//
//  DetailsConfigurator.swift
//  TripDiary
//
//  Created by TX 3000 on 26.07.2023.
//

import Foundation

protocol DetailsConfiguratorProtocol {
    func configureDetailsViewController(with model: TripsDataModel) -> DetailsViewControllerProtocol
}

class DetailsConfigurator: DetailsConfiguratorProtocol {
    func configureDetailsViewController(with model: TripsDataModel) -> DetailsViewControllerProtocol {
        let viewController = DetailsViewController()
        let imageAdapter = ImageURLAdapter()
        let weatherService = OpenWeatherMapService()
        let presenter = DetailsPresenter(view: viewController, model: model, imageAdapter: imageAdapter, weatherService: weatherService)
        viewController.presenter = presenter
        return viewController
    }
}
