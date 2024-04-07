//
//  DetailsViewController.swift
//  CafeMap Baku
//
//  Created by Veysal Hasanbayli on 05.04.24.
//

import UIKit

class DetailsViewController: BaseViewController<DetailsVM> {
    let descLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        configureViewItems()
    }
}

extension DetailsViewController {
    private func configureViewItems() {
        setupConstraint()
    }
    private func setupConstraint(){
        view.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
