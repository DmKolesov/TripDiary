//
//  UITableViewCell+Ext.swift
//  TripDiary
//
//  Created by TX 3000 on 08.07.2023.
//

import UIKit

protocol ReusableCell {
    static var reuseIdentifier: String { get }
    static var nib: UINib { get }
}

extension UITableViewCell: ReusableCell {
    // MARK: - ReusableCell
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
