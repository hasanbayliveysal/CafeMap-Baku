//
//  LocationManager.swift
//  CafeMap Baku
//
//  Created by Veysal Hasanbayli on 08.04.24.
//

import UIKit
import CoreLocation
import MapKit

protocol LocationManagerProtocol {
    func updateLocation(locationManager: CLLocationManager, cafeLocation: CLLocation)
    func addAnnotationsToMap(to mapView: MKMapView, with cafes: [Cafe])
    func zoomToFitAnnotations(in mapView: MKMapView)
    func reverseGeocode(from latitude: Double, and longitude: Double, completion: @escaping (String)->())
}

class LocationManager: LocationManagerProtocol {

    static let shared = LocationManager()
    private var distance: ((String)->())? = nil
    private let geocoder = CLGeocoder()
    
    func getDistanceBetweenUserAndCafe(with mapView: MKMapView, and cafeLocation: CLLocation) -> String {
        guard let userLocation = mapView.userLocation.location else {return "0.0"}
        let distanceInMeters = userLocation.distance(from: cafeLocation)
        return String(format: "%.2f km", distanceInMeters/1000.0)
    }
    
    func updateLocation(locationManager: CLLocationManager, cafeLocation: CLLocation) {
        locationManager.requestLocation()
        guard let userLocation = locationManager.location else { return }
        let distanceInMeters = userLocation.distance(from: cafeLocation)
        let formattedDistance = String(format: "%.2f", distanceInMeters/1000.0)
        distance?(formattedDistance)
        print("Distance to cafe: \(formattedDistance) km")
    }
    
    func addAnnotationsToMap(to mapView: MKMapView, with cafes: [Cafe]) {
        for cafe in cafes {
            let annotation = MKPointAnnotation()
            annotation.title = cafe.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: cafe.locationCoordinateLatitude, longitude: cafe.locationCoordinateLongitude)
            mapView.addAnnotation(annotation)
        }
    }
    
    func zoomToFitAnnotations(in mapView: MKMapView) {
        guard let annotations = mapView.annotations as? [MKPointAnnotation],
              !annotations.isEmpty
        else {
            return
        }
        var zoomRect = MKMapRect.null
        for annotation in annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0, height: 0)
            zoomRect = zoomRect.union(pointRect)
        }
        
        mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
    }
    
    func reverseGeocode(from latitude: Double, and longitude: Double, completion: @escaping (String)->()) {
            let location = CLLocation(latitude: latitude, longitude: longitude)
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                guard error == nil, let placemark = placemarks?.first else {
                    print("Reverse geocoding error: \(error?.localizedDescription ?? "")")
                    return
                }
                completion((placemark.name ?? "") + ", " + (placemark.locality ?? ""))
            }
        }
}
