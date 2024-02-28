//
//  Trips.swift
//  TripDiary
//
//  Created by TX 3000 on 11.07.2023.
//

import Foundation
import RealmSwift

class Trips: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var location: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var descriptionText: String = ""
    let photos = List<String>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
