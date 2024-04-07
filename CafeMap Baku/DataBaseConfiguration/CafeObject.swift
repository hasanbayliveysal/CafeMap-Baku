//
//  CafeObject.swift
//  CafeMap Baku
//
//  Created by Veysal on 04.04.24.
//

import RealmSwift
import CoreLocation

class Cafe: Object , Decodable{
    @Persisted var name: String = ""
    @Persisted var locationName: String = ""
    @Persisted var locationCoordinateLatitude: Double = 0.0
    @Persisted var locationCoordinateLongitude: Double = 0.0
    @Persisted var desc: String = ""
    @Persisted var websiteUrl: String?

    convenience init(name: String, locationName: String, locationCoordinate: CLLocationCoordinate2D, desc: String, websiteUrl: String?) {
        self.init()
        self.name = name
        self.locationName = locationName
        self.locationCoordinateLatitude = locationCoordinate.latitude
        self.locationCoordinateLongitude = locationCoordinate.longitude
        self.desc = desc
        self.websiteUrl = websiteUrl
    }
}
