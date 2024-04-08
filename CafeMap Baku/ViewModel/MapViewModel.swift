//
//  MapViewModel.swift
//  CafeMap Baku
//
//  Created by Veysal Hasanbayli on 07.04.24.
//

import UIKit
import MapKit

class MapViewModel: NSObject {
    var didTapDetailDisclosure: ((String)->())? = nil
    var didTapCafeAnnotation: ((CLLocation)->())? = nil
    var regionAndAnnotaion: ((MKCoordinateRegion)->())? = nil
    func getCafesLocation() -> [Cafe] {
        return DataBaseManager.shared.loadDataFromRealm()
    }
    func addAnnotationToMap(to mapView: MKMapView, with cafes: [Cafe]) {
        LocationManager.shared.addAnnotationsToMap(to: mapView, with: cafes)
    }
    
    func zoomToFitAnnotations(in mapView: MKMapView) {
        LocationManager.shared.zoomToFitAnnotations(in: mapView)
    }
    func updateLocation(locationManager: CLLocationManager, cafeLocation: CLLocation) {
        LocationManager.shared.updateLocation(locationManager: locationManager, cafeLocation: cafeLocation)
    }
    
    func getLocationName(from latitude: Double, and longitude: Double, completion: @escaping (String)->()) {
        LocationManager.shared.reverseGeocode(from: latitude, and: longitude) { location in
            completion(location)
        }
    }
    
}

extension MapViewModel: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "cafeAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView?.canShowCallout = true
        let button = UIButton(type: .detailDisclosure)
        annotationView?.rightCalloutAccessoryView = button
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        let location = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        didTapCafeAnnotation?(location)
    }

    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let annotationTitle = view.annotation?.title {
                didTapDetailDisclosure?(annotationTitle ?? "")
            }
        }
    }
    
}


extension MapViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        let userCoordinate = userLocation.coordinate
        let region = MKCoordinateRegion(center: userCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        regionAndAnnotaion?(region)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Location manager failed with error: \(error.localizedDescription)")
    }
}

