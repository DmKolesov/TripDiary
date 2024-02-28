//
//  TripsRelmMapper.swift
//  TripDiary
//
//  Created by TX 3000 on 18.07.2023.
//

import Foundation

struct TripsRealmMapper {
    
    func mapToRealmModel(dataModel: TripsDataModel) -> Trips {
        let realmModel = Trips()
        realmModel.id = dataModel.id
        realmModel.location = dataModel.location
        realmModel.date = dataModel.date
        realmModel.descriptionText = dataModel.descriptionText
        realmModel.photos.append(objectsIn: dataModel.pathToPhotos)
        return realmModel
    }
    
    func mapToDataModel(realmModel: Trips) -> TripsDataModel {
        return TripsDataModel(
            id: realmModel.id,
            location: realmModel.location,
            date: realmModel.date,
            descriptionText: realmModel.descriptionText,
            pathToPhotos: Array(realmModel.photos)
        )
    }
}
