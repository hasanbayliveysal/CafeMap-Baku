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
//    func writeData() {
//        DataBaseManager.shared.writeDataToRealm()
//    }
//    func fetchData() {
//        let cafes = DataBaseManager.shared.loadDataFromRealm()
//        for cafe in cafes {
//            print(cafe.name, cafe.desc)
//        }
//    }
//
//    func updateCafeDescription(with cafeName: String, and description: String) {
//        DataBaseManager.shared.updateDescription(with: cafeName, and: description)
//    }
}
