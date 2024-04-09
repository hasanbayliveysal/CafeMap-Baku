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
    private var distance: String? = nil
    private var userLocation: MKCoordinateRegion?
    private var mapView: MKMapView = {
        var mapView = MKMapView()
        return mapView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        configureGestureRecognizer()
    }
    private var userLocationButton: UIImageView = {
        var button = UIImageView()
        button.image = UIImage(named: "location")
        button.isUserInteractionEnabled = true
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.addAnnotationToMap(to: mapView, with: vm.getCafesLocation())
        vm.zoomToFitAnnotations(in: mapView)
    }
    @objc
    func didTapUserLocationButton() {
        if let userLocation {
            mapView.setRegion(userLocation, animated: true)
        }
        startTracking()
        AlertManager.shared.showBottomAlert(message: "Tracking user", view: self.view)
    }
    
}

extension MapViewController {
    private func configureUIElements() {
        view.addSubview(mapView)
        view.addSubview(userLocationButton)
        mapView.delegate = vm
        locationManager.delegate = vm
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        setupConstraint()
        vm.didTapDetailDisclosure = { [weak self] title in
            self?.pushDetailsViewController(with: title)
        }
        vm.regionAndAnnotaion = {[weak self] region in
            self?.userLocation = region
            self?.mapView.showsUserLocation = true
            self?.vm.zoomToFitAnnotations(in: self?.mapView ?? MKMapView())
        }
        vm.didTapCafeAnnotation = { [weak self] location,annotation in
            self?.distance = self?.getDistance(location: location, annotation: annotation)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapUserLocationButton))
        userLocationButton.addGestureRecognizer(tapGesture)
       
    }
    private func getDistance(location: CLLocation, annotation: MKAnnotation) -> String {
        self.location = location
        let distance = self.vm.getDistanceBetweenUserAndCafe(with: mapView, and: location)
        return distance
    }
    private func setupConstraint() {
        mapView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        userLocationButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.width.height.equalTo(60)
        }
    }
    
    private func pushDetailsViewController(with title: String) {
        let vc = self.router.detailsVC() as! DetailsViewController
        let index = self.vm.getCafesLocation().firstIndex(where: {$0.name == title})
        if let index {
            vc.cafeItem = self.vm.getCafesLocation()[index]
            if let distance {
                vc.distance = "\(distance) away"
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func startTracking() {
        trackingTimer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(tracingUserLocation), userInfo: nil, repeats: true)
    }
    
    @objc
    func tracingUserLocation() {
        vm.requestLocation(locationManager: locationManager)
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
            let distance =
            self?.vm.getDistanceBetweenUserAndCafe(with: self?.mapView ?? MKMapView(),
                                                   and: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
            if let distance {
                self?.pushVC(locationName: location, coordinate: coordinate, message: distance)
            }
        }
    }
    
    func pushVC(locationName: String, coordinate: CLLocationCoordinate2D, message: String) {
        AlertManager.shared.makeAlertAction(on: self, with: "Do you want to add new restaurant?", and: "\(message) away")
        AlertManager.shared.yesButtonTapped = { [weak self] in
            let vc = self?.router.addNewVC() as! AddNewViewController
            vc.locationTextFieldView.customTF.text = locationName
            vc.locationTextFieldView.customTF.isUserInteractionEnabled = false
            vc.cafeLocationCoordinate = coordinate
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

