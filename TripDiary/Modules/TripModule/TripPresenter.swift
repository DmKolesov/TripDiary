//
//  TripPresenter.swift
//  TripDiary
//
//  Created by TX 3000 on 08.07.2023.
//

import Foundation

protocol TripViewControllerProtocol: AnyObject {
    var presenter: TripPresenterProtocol! { get set }
    func reloadTableView()
}

protocol TripPresenterProtocol {
    init(view: TripViewControllerProtocol, router: RouterProtocol, dataManager: DataManagerProtocol)
    func setUpModels()
    var models: [TripsDataModel]? { get set }
    func deleteTrip(tripID: String) throws
    func didPressedAddTrip()
    func didSelectItem(at index: Int)
}

class TripPresenter: TripPresenterProtocol {
   
    private weak var view: TripViewControllerProtocol?
    private var router: RouterProtocol
    private var dataManager: DataManagerProtocol
    var models: [TripsDataModel]?

    
    required init(view: TripViewControllerProtocol, router: RouterProtocol, dataManager: DataManagerProtocol) {
        self.view = view
        self.router = router
        self.dataManager = dataManager
    }
    
    func setUpModels() {
        DispatchQueue.main.async { 
            self.models = self.dataManager.getAllTrips()
            self.view?.reloadTableView()
            
        }
    }
    
    func deleteTrip(tripID: String) throws {
        do {
            try dataManager.deleteTrip(tripID)
            self.models?.removeAll(where: { tripModel in
                tripID == tripModel.id
            })
            self.view?.reloadTableView()
            
        } catch {
            throw error
        }
    }
    
    func didPressedAddTrip() {
        router.presentAddTrip()
    }
    
    func didSelectItem(at index: Int) {
        guard let models = models else { return }
        let model = models[index]
        router.pushDetailScreen(model: model)
    }
}
