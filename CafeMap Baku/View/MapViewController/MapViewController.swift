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
    private var mapView: MKMapView = {
        var mapView = MKMapView()
        return mapView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
    }
    override func viewDidAppear(_ animated: Bool) {
        vm.zoomToFitAnnotations(in: mapView)
    }
}

extension MapViewController {
    private func configureUIElements() {
        view.addSubview(mapView)
        mapView.delegate = vm
        setupConstraint()
        vm.addAnnotationsToMap(to: mapView)
        vm.didTapDetailDisclosure = { [weak self] title in
            let vc = self?.router.detailsVC() as! DetailsViewController
            let index = self?.vm.getCafesLocation().firstIndex(where: {$0.name == title})
            if let index {
                vc.cafeItem = self?.vm.getCafesLocation()[index]
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    private func setupConstraint() {
        mapView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

