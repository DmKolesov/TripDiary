//
//  TripTableViewCell.swift
//  TripDiary
//
//  Created by TX 3000 on 08.07.2023.
//

import UIKit

class TripTableViewCell: UITableViewCell {

    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    func configure(with trip: TripsDataModel) {
        locationNameLabel.text = trip.location
        dateLabel.text = trip.date
    }
}
