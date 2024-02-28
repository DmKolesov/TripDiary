//
//  MapService.swift
//  TripDiary
//
//  Created by TX 3000 on 10.07.2023.
//

import Foundation
import MapKit
import CoreLocation

class MapService {
    
    weak var viewController: MapViewController?
    
    func performSearch(with searchText: String?) {
        guard let searchText = searchText else { return }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchText) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
            } else if let placemark = placemarks?.first {
                self.updateMapView(with: placemark)
            }
        }
    }
    
    private func updateMapView(with placemark: CLPlacemark) {
        guard let mapView = viewController?.mapView else { return }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.location!.coordinate
        annotation.title = placemark.name
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
}
