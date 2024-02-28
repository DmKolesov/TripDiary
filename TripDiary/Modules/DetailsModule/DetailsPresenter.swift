//
//  DetailsPresenter.swift
//  TripDiary
//
//  Created by TX 3000 on 26.07.2023.
//

import Foundation

protocol DetailsPresenterProtocol {
    init(view: DetailsViewControllerProtocol, model: TripsDataModel, imageAdapter: ImageURLAdapter, weatherService: WeatherService)
    func configureView()
}

class DetailsPresenter: DetailsPresenterProtocol {
    
    private var model: TripsDataModel?
    weak var view: DetailsViewControllerProtocol?
    private var imageAdapter: ImageURLAdapter
    private let imageService = ImageAPIService.shared
    private let weatherService: WeatherService
    
    
    required init(view: DetailsViewControllerProtocol, model: TripsDataModel, imageAdapter: ImageURLAdapter, weatherService: WeatherService) {
        self.view = view
        self.model = model
        self.imageAdapter = imageAdapter
        self.weatherService = weatherService
    }
    func configureView() {
        view?.showActivityIndicator()
        defer {
            view?.hideActivityIndicator()
        }
        
        guard let model = model, let imageDataUrl = imageAdapter.url(from: model.pathToPhotos[0]) else { return }
        
        imageService.loadImage(from: imageDataUrl) { [weak self] image in
            guard let self = self, let image = image else { return }
            
            self.weatherService.fetchWeatherTemperature(for: model.location) { temperature in
                DispatchQueue.main.async {
                    self.view?.updateView(location: model.location, date: model.date, temperature: temperature ?? "", description: model.descriptionText, photos: image)
                }
            }
        }
    }
}
