//
//  AddTripPresenter.swift
//  TripDiary
//
//  Created by TX 3000 on 09.07.2023.
//

import Foundation

enum AddTripNavigation {
    case mapView
    case calendarView
    case descriptionView
    case popToRoot
}


protocol AddTripViewControllerProtocol: AnyObject {
    var presenter: AddTripPresenterProtocol! { get set }
    func displayAlert(type: AlertType, message: String)
    func updateLocationButton(with title: String)
    func updateDateButton(with title: String)
    func userJourneyDescription(text: String)
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol AddTripPresenterProtocol {
    init(view: AddTripViewControllerProtocol, router: RouterProtocol, dataManager: DataManagerProtocol, storage: FireBaseStorageProtocol, imageUploadService: ImageUploadServiceProtocol)
    func saveTrip(location: String, date: String, descriptionText: String, photos: [ImageDataProtocol])
    func navigate(to navigation: AddTripNavigation)
}

class AddTripPresenter: AddTripPresenterProtocol {
    
    private weak var view: AddTripViewControllerProtocol?
    private let router: RouterProtocol
    private let dataManager: DataManagerProtocol
    private let storage: FireBaseStorageProtocol
    private let imageUploadService: ImageUploadServiceProtocol
    private var photoURLs: [String] = []
    
    required init(view: AddTripViewControllerProtocol, router: RouterProtocol, dataManager: DataManagerProtocol, storage: FireBaseStorageProtocol, imageUploadService: ImageUploadServiceProtocol) {
        self.view = view
        self.router = router
        self.dataManager = dataManager
        self.storage = storage
        self.imageUploadService = imageUploadService
    }
    
    func saveTrip(location: String, date: String, descriptionText: String, photos: [ImageDataProtocol]) {
        
        let photoDataArray = photos.compactMap { $0.imageData() }
        
        view?.showActivityIndicator()
        defer {
            view?.hideActivityIndicator()
        }
        imageUploadService.uploadImages(photoDataArray) { [weak self] result in
            switch result {
            case .success(let downloadURLs):
                self?.saveTripToRealm(location: location, date: date, descriptionText: descriptionText, photoURLs: downloadURLs)
            case .failure(let error):
                assertionFailure("Error uploading images: \(error)")
                print("-> !!!!!!!!Error uploading images: \(error)")
            }
        }
    }
    
    private func saveTripToRealm(location: String, date: String, descriptionText: String, photoURLs: [URL]) {
        let tripDataModel = TripsDataModel(
            id: UUID().uuidString,
            location: location,
            date: date,
            descriptionText: descriptionText,
            pathToPhotos: photoURLs.map { $0.absoluteString }
        )
        
        do {
            try dataManager.saveTrip(tripDataModel, photoURLs: tripDataModel.pathToPhotos)
        } catch {
            print("-> !!!!!Failed to save trip to Realm: \(error)")
        }
    }
    
    func navigate(to navigation: AddTripNavigation) {
           switch navigation {
           case .mapView:
               router.presentMap(delegate: self)
           case .calendarView:
               router.presentCalendar(delegate: self)
           case .descriptionView:
               router.presentDescription(delegate: self)
           case .popToRoot:
               router.popToRoot()
           }
       }
}
extension AddTripPresenter: MapViewControllerDelegate {
    func didEnterLocation(_ location: String?) {
        guard let location = location else { return }
        DispatchQueue.main.async { [weak self] in
            self?.view?.updateLocationButton(with: location)
        }
    }
}
extension AddTripPresenter: CalendarViewControllerDelegate {
    func didSelectDateInterval(_ startDate: String, _ endDate: String) {
        let dateInterval = "\(startDate) - \(endDate)"
        DispatchQueue.main.async { [weak self] in
            self?.view?.updateDateButton(with: dateInterval)
        }
    }
}
extension AddTripPresenter: DescriptionViewControllerDelegate {
    func didEnterDescription(text: String?) {
        guard let text = text else { return }
        self.view?.userJourneyDescription(text: text)
    }
}
