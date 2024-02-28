//
//  MapViewController.swift
//  TripDiary
//
//  Created by TX 3000 on 09.07.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UISearchBarDelegate {

    var presenter: MapPresenterProtocol!

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else { return }
        presenter.mapService.viewController = self
        presenter.convertedSearchText(searchText: searchText)
        displayAlert(message: searchText)
      
    }
}
extension MapViewController: MapViewControllerProtocol {
    func displayAlert(message: String) {
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            self?.presenter.dismissView()
//            self?.dismiss(animated: true)
        }
       presentConfirmAlert(from: self, title: "Confirmation", message: "Are you sure you want to select \(message)?", actions: [cancelAction, confirmAction])
    }
}
