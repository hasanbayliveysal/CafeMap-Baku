//
//  MainViewVM.swift
//  CafeMap Baku
//
//  Created by Veysal on 04.04.24.
//

import UIKit

class MainViewVM {
    init() {}
    var backgroundImage: UIImage {
        guard let image = UIImage(named: "backgroundImage") else {
            return UIImage()
        }
        return image
    }
    func writeData() {
        DataBaseManager.shared.writeDataToRealm()
    }
}
