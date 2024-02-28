//
//  DetailsViewController.swift
//  TripDiary
//
//  Created by TX 3000 on 26.07.2023.
//

import UIKit

protocol DetailsViewControllerProtocol: AnyObject {
    var presenter: DetailsPresenterProtocol! { get set }
    func updateView(location: String, date: String, temperature: String, description: String, photos: UIImage)
    func showActivityIndicator()
    func hideActivityIndicator()
}

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photoFromTrip: UIImageView!
    
    private var activityIndicator: UIActivityIndicatorView!
    
    var presenter: DetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        presenter.configureView()
    }
}
extension DetailsViewController: DetailsViewControllerProtocol {
    
    func updateView(location: String, date: String, temperature: String, description: String, photos: UIImage) {
        locationLabel.text = "Your travel destination: \(location)"
        dateLabel.text = "Your were in \(location) with: \(date)"
        temperatureLabel.text = "Today's temperature in \(location) is \(temperature) degrees"
        descriptionLabel.text = "Your impressions of the trip: \(description)"
        photoFromTrip.image = photos
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
}
extension DetailsViewController {
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        if let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }) {
            if let mainWindow = windowScene.windows.first {
           
                mainWindow.addSubview(activityIndicator)

                NSLayoutConstraint.activate([
                    activityIndicator.centerXAnchor.constraint(equalTo: mainWindow.centerXAnchor),
                    activityIndicator.centerYAnchor.constraint(equalTo: mainWindow.centerYAnchor)
                ])
            }
        }
    }
}
