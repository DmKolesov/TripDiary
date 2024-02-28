//
//  DescriptionConfigurator.swift
//  TripDiary
//
//  Created by TX 3000 on 14.07.2023.
//

import Foundation
import UIKit

protocol DescriptionConfiguratorProtocol {
    func configureDescriptionViewController() -> DescriptionViewControllerProtocol
}

class DescriptionConfigurator: DescriptionConfiguratorProtocol {
    func configureDescriptionViewController() -> DescriptionViewControllerProtocol {
        let viewController: DescriptionViewControllerProtocol = DescriptionViewController()
        let router = Router()
        let presenter = DescriptionPresenter(view: viewController, router: router)
        router.viewController = viewController as? UIViewController
        viewController.presenter = presenter
        return viewController
    }
}
