//
//  CalendarConfigurator.swift
//  TripDiary
//
//  Created by TX 3000 on 15.07.2023.
//

import Foundation

protocol CalendarConfiguratorProtocol {
    func configureCalendarViewController() -> CalendarViewControllerProtocol
}

class CalendarConfigurator: CalendarConfiguratorProtocol {
    func configureCalendarViewController() -> CalendarViewControllerProtocol {
        let viewController = CalendarViewController()
        let router = Router()
        let dateAdapter = DateAdapter()
        let presenter = CalendarPresenter(view: viewController, router: router, dateAdapter: dateAdapter)
        router.viewController = viewController 
        viewController.presenter = presenter
        return viewController
    }
}
