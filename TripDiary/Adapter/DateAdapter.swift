//
//  DateAdapter.swift
//  TripDiary
//
//  Created by TX 3000 on 11.07.2023.
//

import Foundation

protocol DateAdapterProtocol {
    func getString(from dateComponents: DateComponents, format: String) -> String?
}

class DateAdapter: DateAdapterProtocol {
    private let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
    }
    
    func getString(from dateComponents: DateComponents, format: String) -> String? {
        guard let date = dateComponents.date else {
            return nil
        }
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}

extension String {
    /// dateFormatter.dateFormat = "dd.MM.yyyy"
    static let formatteDayMonthYear = "dd.MM.yyyy"
}
