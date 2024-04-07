//
//  MainViewCustomButton.swift
//  CafeMap Baku
//
//  Created by Veysal Hasanbayli on 07.04.24.
//

import UIKit

class MainViewCustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        setTitleColor(.white, for: .normal)
        backgroundColor = .red
        layer.cornerRadius = 12
        snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
}
