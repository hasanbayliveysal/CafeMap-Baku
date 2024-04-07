//
//  AddNewCafeVM.swift
//  CafeMap Baku
//
//  Created by Veysal Hasanbayli on 07.04.24.
//

import UIKit
import MapKit

class AddNewCafeVM: NSObject {
    var getLocation: ((String, CLLocationCoordinate2D)->())? = nil
    
    func saveNewCafe(with model: Cafe) {
        DataBaseManager.shared.writeCustomCafeToRealm(with: model)
    }
}


