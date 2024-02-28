//
//  AddTripViewController.swift
//  TripDiary
//
//  Created by TX 3000 on 08.07.2023.
//

import UIKit

class AddTripViewController: UIViewController {
    
 
    @IBOutlet weak var specifyLocationButton: UIButton!
    @IBOutlet weak var addDateButton: UIButton!
    
    var presenter: AddTripPresenterProtocol!
    private var locationTitle: String = ""
    private var date: String = ""
    private var tripDescription: String = ""
    private var selectedImageData: ImageDataProtocol?
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
  
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
    
    @IBAction func specifyLocationTapped(_ sender: Any) {
        presenter.navigate(to: .mapView)
    }
    
    @IBAction func addTripDateTapped(_ sender: Any) {
        presenter.navigate(to: .calendarView)
    }
    
    @IBAction func addPhotoTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func addDescription(_ sender: Any) {
        presenter.navigate(to: .descriptionView)
    }
    
    @IBAction func addTripTapped(_ sender: Any) {
        
        guard !locationTitle.isEmpty, !date.isEmpty, !tripDescription.isEmpty else {
            displayAlert(type: .warning, message: "Please fill in all fields")
            return
        }
        
        presenter.saveTrip(location: locationTitle, date: date, descriptionText: tripDescription, photos: [selectedImageData].compactMap { $0 })
        displayAlert(type: .success, message: "You wanting to add this trip?")
    }
}
extension AddTripViewController: AddTripViewControllerProtocol {
    func displayAlert(type: AlertType, message: String) {
        switch type {
            
        case .error:
            let confirmAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
                self?.presenter.navigate(to: .popToRoot)
            }
            let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            presentConfirmAlert(from: self, title: type.title, message: message, actions: [cancelAction, confirmAction])
            
        case .success:
            let confirmAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
                guard let self = self else { return }
//                self.presenter.saveTrip(location: self.locationTitle, date: self.date, descriptionText: self.description, photos: [self.selectedImageData].compactMap { $0 })
                self.presenter.navigate(to: .popToRoot)
            }
            let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            presentConfirmAlert(from: self, title: type.title, message: message, actions: [cancelAction, confirmAction])
            
        case .warning:
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            presentConfirmAlert(from: self, title: type.title, message: message, actions: [cancelAction])
        }
    }
    
    func userJourneyDescription(text: String) {
        self.tripDescription = text
    }
    
    func updateLocationButton(with title: String) {
        self.locationTitle = title
        self.specifyLocationButton.setTitle(title, for: .normal)
    }
    func updateDateButton(with title: String) {
        self.date = title
        self.addDateButton.setTitle(title, for: .normal)
    }
}
extension AddTripViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            selectedImageData = UIImageData(image: pickedImage)
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
extension AddTripViewController {
    
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



