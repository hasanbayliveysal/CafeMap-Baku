//
//  MainViewController.swift
//  CafeMap Baku
//
//  Created by Veysal on 04.04.24.
//

import UIKit

class MainViewController: BaseViewController<MainViewVM> {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        vm.writeData()
        vm.fetchData()
        vm.updateCafeDescription(with: "ADA RESTAURANT", and: "Bura ada restorandir")
        vm.fetchData()
        DataBaseManager.shared.writeCustomCafeToRealm(with: Cafe(name: "Veysals'", location: "Quba", desc: "Bura Qubanin en yaxsi restoranidir", websiteUrl: nil))
        vm.fetchData()
    }
}

