//
//  RouterMain.swift
//  TripDiary
//
//  Created by TX 3000 on 15.07.2023.
//

import Foundation
import UIKit
// MARK: - Router
protocol RouterMainProtocol: AlertRouterProtocol {
    var viewController: UIViewController? { get set }
}

protocol RouterProtocol: RouterMainProtocol {
    func presentAddTrip()
    func presentDescription(delegate: DescriptionViewControllerDelegate)
    func presentCalendar(delegate: CalendarViewControllerDelegate)
    func presentMap(delegate: MapViewControllerDelegate)
    func pushDetailScreen(model: TripsDataModel)
}

class Router: RouterProtocol {
    weak var viewController: UIViewController?
    
    func presentAddTrip() {
        guard let viewController = viewController,
              let navigationController = viewController.navigationController else {
            return
        }
        
        let configurator = AddTripConfigurator()
        let addTripVC = configurator.configureAddTripViewController()
        
        if let addTripViewController = addTripVC as? UIViewController {
            navigationController.pushViewController(addTripViewController, animated: true)
        } else {
            print("Error: Unable to present AddTripViewController")
        }
    }
    
    func presentDescription(delegate: DescriptionViewControllerDelegate) {
        guard let viewController = viewController else { return }
        
        let configurator = DescriptionConfigurator()
        let descriptionVC = configurator.configureDescriptionViewController()
        descriptionVC.presenter.delegate = delegate
        
        if let descriptionViewController = descriptionVC as? UIViewController {
            viewController.present(descriptionViewController, animated: true)
        } else {
            print("Error: Unable to present descriptionViewController")
        }
    }
    
    func presentCalendar(delegate: CalendarViewControllerDelegate) {
        guard let viewController = viewController else { return }
        
        let configurator = CalendarConfigurator()
        let calendarVC = configurator.configureCalendarViewController()
        calendarVC.presenter.delegate = delegate
        if let calendarViewController = calendarVC as? UIViewController {
            viewController.present(calendarViewController, animated: true)
        } else {
            print("Error: Unable to present calendarViewController")
        }
    }
    
    func presentMap(delegate: MapViewControllerDelegate) {
        guard let viewController = viewController else { return }
        
        let configurator = MapConfigurator()
        let mapVC = configurator.configureMapViewController()
        mapVC.presenter.delegate = delegate
        if let mapViewController = mapVC as? UIViewController {
            viewController.present(mapViewController, animated: true)
        } else {
            print("Error: Unable to present mapViewController")
        }
    }
    func pushDetailScreen(model: TripsDataModel) {
        guard let viewController = viewController else { return }
        
        let configurator = DetailsConfigurator()
        let detailsVc = configurator.configureDetailsViewController(with: model)
        if let detailViewController = detailsVc as? UIViewController {
            viewController.navigationController?.pushViewController(detailViewController, animated: true)
        } else {
            print("Error: Unable to present detailViewController")
        }
    }
    
}

extension RouterProtocol {
    func dismissView() {
        guard let viewController = viewController else { return }
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func popToRoot() {
        guard let viewController = viewController else { return }
        viewController.navigationController?.popToRootViewController(animated: true)
    }
}
