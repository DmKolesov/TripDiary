//
//  CalendarViewController.swift
//  TripDiary
//
//  Created by TX 3000 on 09.07.2023.
//

import UIKit

class CalendarViewController: UIViewController {
    
    var presenter: CalendarPresenterProtocol!
  
    private var endDateSelected = false
    private let dateAdapter = DateAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCalendar()
    }
}

extension CalendarViewController: UICalendarSelectionMultiDateDelegate {
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        guard let startDate = selection.selectedDates.first,
              let endDate = selection.selectedDates.last else { return }

        guard let startDateString = presenter.dateAdapter.getString(from: startDate, format: .formatteDayMonthYear),
              let endDateString = presenter.dateAdapter.getString(from: endDate, format: .formatteDayMonthYear)
        else { return }

        if endDateSelected {
            displayAlert()
            presenter.delegate?.didSelectDateInterval(startDateString, endDateString)
        } else {
            endDateSelected = true
        }
    }

    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        endDateSelected = false
    }
}

extension CalendarViewController: CalendarViewControllerProtocol {
    func displayAlert() {
        let confirmAction = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
            self?.presenter.dismissView()
        }
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        presentConfirmAlert(from: self, title: "Confirmation", message:  "Are you sure you want to select this date?", actions: [cancelAction, confirmAction])
    }
}

extension CalendarViewController: UICalendarViewDelegate {
    private func configureCalendar() {
        let calendarView = UICalendarView()
    
        calendarView.calendar = .current
        calendarView.locale = .current
        
        calendarView.visibleDateComponents = DateComponents(calendar: .current, year: 2023)
        calendarView.fontDesign = .rounded
        
        let dateSelection = UICalendarSelectionMultiDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
        calendarView.delegate = self
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            calendarView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

