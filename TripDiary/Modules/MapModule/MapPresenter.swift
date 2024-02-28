//
//  MapPresenter.swift
//  TripDiary
//
//  Created by TX 3000 on 09.07.2023.
//

import Foundation

protocol MapViewControllerDelegate: AnyObject {
    func didEnterLocation(_ location: String?)
}
protocol MapViewControllerProtocol: AnyObject {
    var presenter: MapPresenterProtocol! { get set }
    func displayAlert(message: String)
}
protocol MapPresenterProtocol {
    init(view: MapViewControllerProtocol, mapService: MapService, router: RouterProtocol)
    var mapService: MapService { get set }
    var delegate: MapViewControllerDelegate? { get set }
    func convertedSearchText(searchText: String?)
    func dismissView()
    
}

class MapPresenter: MapPresenterProtocol {
    
    private weak var view: MapViewControllerProtocol?
    weak var delegate: MapViewControllerDelegate?
    var mapService: MapService
    private let router: RouterProtocol
    
    required init(view: MapViewControllerProtocol, mapService: MapService, router: RouterProtocol) {
        self.view = view
        self.mapService = mapService
        self.router = router
    }
    
    func convertedSearchText(searchText: String?) {
        mapService.performSearch(with: searchText)
        if let location = searchText {
           delegate?.didEnterLocation(location)
        }
    }
    
    func dismissView() {
        router.dismissView()
    }
}
