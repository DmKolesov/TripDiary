//
//  DescriptionViewController.swift
//  TripDiary
//
//  Created by TX 3000 on 11.07.2023.
//

import UIKit

class DescriptionViewController: UIViewController   {
    
    var presenter: DescriptionPresenterProtocol!

    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.delegate = self
    }
}

extension DescriptionViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            guard let description = textView.text else { return true } 
            presenter.delegate?.didEnterDescription(text: description)
            displayAlert()
            return false
        }
        return true
    }
}
extension DescriptionViewController: DescriptionViewControllerProtocol {
    func displayAlert() {
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            self?.presenter.dismissView()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            presentConfirmAlert(from: self, title: "Success", message: "You have successfully added a description to the trip", actions: [okAction, cancelAction])
    }
}
