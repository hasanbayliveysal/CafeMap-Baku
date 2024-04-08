//
//  MapViewController.swift
//  CafeMap Baku
//
//  Created by Veysal Hasanbayli on 07.04.24.
//

import UIKit
import MapKit
import SafariServices

class MapViewController: BaseViewController<MapViewModel> {
    private let locationManager = CLLocationManager()
    private var trackingTimer: Timer?
    private var calledTimerFirstTime = true
    private var location: CLLocation?
    private var mapView: MKMapView = {
        var mapView = MKMapView()
        return mapView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        configureGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.addAnnotationToMap(to: mapView, with: vm.getCafesLocation())
        vm.zoomToFitAnnotations(in: mapView)
    }
}

extension MapViewController {
    private func configureUIElements() {
        view.addSubview(mapView)
        mapView.delegate = vm
        locationManager.delegate = vm
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        setupConstraint()
        vm.didTapDetailDisclosure = { [weak self] title in
            self?.pushDetailsViewController(with: title)
        }
        vm.regionAndAnnotaion = {[weak self] region in
            self?.mapView.showsUserLocation = true
            self?.vm.zoomToFitAnnotations(in: self?.mapView ?? MKMapView())
        }
        vm.didTapCafeAnnotation = { [weak self] location in
            self?.location = location
            self?.startTracking()
        }
        
    }
    
    private func setupConstraint() {
        mapView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    private func pushDetailsViewController(with title: String) {
        let vc = self.router.detailsVC() as! DetailsViewController
        let index = self.vm.getCafesLocation().firstIndex(where: {$0.name == title})
        if let index {
            vc.cafeItem = self.vm.getCafesLocation()[index]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func startTracking() {
        trackingTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)
    }
    
    @objc
    func updateLocation() {
        print("here")
        vm.updateLocation(locationManager: locationManager, cafeLocation: location ?? CLLocation())
        if calledTimerFirstTime {
            calledTimerFirstTime = false
            trackingTimer?.invalidate()
            trackingTimer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)
        }
        if mapView.selectedAnnotations.isEmpty {
            trackingTimer?.invalidate()
            calledTimerFirstTime = true
        }
    }
    
    private func configureGestureRecognizer() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        mapView.addGestureRecognizer(longPressGesture)
    }
    
    @objc
    func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        vm.getLocationName(from: coordinate.latitude, and: coordinate.longitude) { [weak self] location in
            self?.pushVC(locationName: location, coordinate: coordinate)
        }
    }
    
    func pushVC(locationName: String, coordinate: CLLocationCoordinate2D) {
        AlertManager.shared.makeAlertAction(on: self, with: "Do you want to add new restaurant?")
        AlertManager.shared.yesButtonTapped = { [weak self] in
            let vc = self?.router.addNewVC() as! AddNewViewController
            vc.locationTextFieldView.customTF.text = locationName
            vc.locationTextFieldView.customTF.isUserInteractionEnabled = false
            vc.cafeLocationCoordinate = coordinate
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

