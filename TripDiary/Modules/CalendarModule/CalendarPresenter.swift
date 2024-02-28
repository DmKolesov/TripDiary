//
//  CalendarPresenter.swift
//  TripDiary
//
//  Created by TX 3000 on 09.07.2023.
//

import Foundation

protocol CalendarViewControllerProtocol: AnyObject {
    var presenter: CalendarPresenterProtocol! { get set }
    func displayAlert()
}

protocol CalendarViewControllerDelegate: AnyObject {
    func didSelectDateInterval(_ startDate: String, _ endDate: String)
}

protocol CalendarPresenterProtocol {
    init(view: CalendarViewControllerProtocol, router: RouterProtocol, dateAdapter: DateAdapterProtocol)
    var dateAdapter: DateAdapterProtocol { get set }
    var delegate: CalendarViewControllerDelegate? { get set }
    func dismissView()
    
}

class CalendarPresenter: CalendarPresenterProtocol {
  
    private weak var view: CalendarViewControllerProtocol?
    private let router: RouterProtocol
    var dateAdapter: DateAdapterProtocol
    weak var delegate: CalendarViewControllerDelegate?
    
    required init(view: CalendarViewControllerProtocol, router: RouterProtocol, dateAdapter: DateAdapterProtocol) {
            self.view = view
            self.router = router
            self.dateAdapter = dateAdapter
        }

    func dismissView() {
        router.dismissView()
    }
}
