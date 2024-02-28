//
//  Alert.swift
//  TripDiary
//
//  Created by TX 3000 on 09.07.2023.
//

import UIKit

// MARK: - AlertType Enumeration

enum AlertType {
    case error
    case success
    case warning
    
    var title: String {
        switch self {
        case .error:
            return "Error"
        case .success:
            return "Success"
        case .warning:
            return "Warning"
        }
    }
}

// MARK: - AlertRouter Protocol

protocol AlertRouterProtocol {
    func presentInfoAlert(on viewController: UIViewController, title: String?, message: String?, type: AlertType, handler: (() -> Void)?)
    func presentConfirmAlert(from controller: UIViewController, title: String, message: String?, actions: [UIAlertAction])
}

// MARK: - AlertRouter Implementation

extension AlertRouterProtocol {
    func presentInfoAlert(on viewController: UIViewController,
                          title: String?,
                          message: String? = nil,
                          type: AlertType, handler: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var actionTitle = ""
        switch type {
        case .error:
            actionTitle = "Dismiss"
        case .success:
            actionTitle = "OK"
        case .warning:
            actionTitle = "Got it"
        }
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default) { _ in
            handler?()
        })
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func presentConfirmAlert(from controller: UIViewController, title: String, message: String?, actions: [UIAlertAction]) {
        let confirm = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            confirm.addAction(action)
        }
        
        controller.present(confirm, animated: true)
    }
}

extension UIViewController: AlertRouterProtocol {
    
}
