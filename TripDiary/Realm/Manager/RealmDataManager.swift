//
//  RealmDataManager.swift
//  TripDiary
//
//  Created by TX 3000 on 18.07.2023.


import Foundation

protocol DataManagerProtocol {
    func saveTrip(_ trip: TripsDataModel, photoURLs: [String]) throws
    func getAllTrips() -> [TripsDataModel]
    func deleteTrip(_ tripID: String) throws
}

class RealmDataManager: DataManagerProtocol {
    private let realmService: RealmService
    private let mapper: TripsRealmMapper
    
    init(realmService: RealmService, mapper: TripsRealmMapper) {
        self.realmService = realmService
        self.mapper = mapper
    }
    
    func saveTrip(_ trip: TripsDataModel, photoURLs: [String]) throws {
           let realmModel = mapper.mapToRealmModel(dataModel: trip)
           realmModel.photos.append(objectsIn: photoURLs)
           realmService.saveTrip(realmModel)
       }
    
    func getAllTrips() -> [TripsDataModel] {
        let trips = realmService.getAllTrips()
        return trips.map { mapper.mapToDataModel(realmModel: $0) }
    }
    
    func deleteTrip(_ tripID: String) throws {
        realmService.deleteTrip(tripID)
    }
}
