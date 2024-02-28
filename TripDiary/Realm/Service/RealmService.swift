//
//  RealmService.swift
//  TripDiary
//
//  Created by TX 3000 on 15.07.2023.
//

import Foundation
import RealmSwift

class RealmService {
    private lazy var realm: Realm = {
        do {
            return try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }()
    
    func saveTrip(_ trip: Trips) {
        do {
            try realm.write {
                realm.add(trip)
            }
        } catch {
            print("Failed to save trip: \(error)")
        }
    }
    
    func getAllTrips() -> [Trips] {
        return Array(realm.objects(Trips.self))
    }
    
    func deleteTrip(_ tripID: String) {
        guard let trip = realm.object(ofType: Trips.self, forPrimaryKey: tripID) else {
            return 
        }
        
        do {
            try realm.write {
                realm.delete(trip)
            }
        } catch {
            print("Failed to delete trip: \(error)")
        }
    }
}
