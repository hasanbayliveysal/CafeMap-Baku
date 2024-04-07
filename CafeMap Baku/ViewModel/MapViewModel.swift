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
    func getCafesLocation() -> [Cafe] {
        return DataBaseManager.shared.loadDataFromRealm()
    }
    
    
    func addAnnotationsToMap(to mapView: MKMapView) {
        let cafes = getCafesLocation()
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
        if let title = annotation.title {
            print("\(String(describing: title))")
        }
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let annotationTitle = view.annotation?.title {
                didTapDetailDisclosure?(annotationTitle ?? "")
            }
        }
    }
}
