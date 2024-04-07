//
//  SearchViewControllerDelegate.swift
//  CafeMap Baku
//
//  Created by Veysal Hasanbayli on 07.04.24.
//

import Foundation
import MapKit

protocol SearchViewControllerDelegate {
    func didSelectSearchedLocation(cafeName: String, cafeLocation: CLLocationCoordinate2D)
}

