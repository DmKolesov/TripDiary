//
//  DescriptionPresenter.swift
//  TripDiary
//
//  Created by TX 3000 on 14.07.2023.
//

import Foundation

protocol DescriptionViewControllerDelegate: AnyObject {
    func didEnterDescription(text: String?)
}

protocol DescriptionViewControllerProtocol: AnyObject {
    var presenter: DescriptionPresenterProtocol! { get set }
    func displayAlert()
}

protocol DescriptionPresenterProtocol {
    init(view: DescriptionViewControllerProtocol, router: RouterProtocol)
    var delegate: DescriptionViewControllerDelegate? { get set }
    func dismissView()
}

class DescriptionPresenter: DescriptionPresenterProtocol {
    
    private let router: RouterProtocol
    private weak var view: DescriptionViewControllerProtocol?
    weak var delegate: DescriptionViewControllerDelegate?
    
    required init(view: DescriptionViewControllerProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func dismissView() {
        router.dismissView() 
    }
}
