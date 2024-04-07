//
//  MainViewController.swift
//  CafeMap Baku
//
//  Created by Veysal on 04.04.24.
//

import UIKit

class MainViewController: BaseViewController<MainViewVM> {
    
    private var backgroundImage: UIImageView = {
        var image = UIImageView()
        return image
    }()
    
    private var buttonsStackView: UIStackView = {
        var sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 32
        return sv
    }()
    
    private var restaurantListButton: MainViewCustomButton = {
        var button = MainViewCustomButton()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setTitle("Restaurants List", for: .normal)
        return button
    }()
    
    private var showRestaurantOnMapButton: MainViewCustomButton = {
        var button = MainViewCustomButton()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.setTitle("Restaurants On The Map", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraint()
    }

}
extension MainViewController {
    private func setupConstraint(){
        view.addSubview(backgroundImage)
        backgroundImage.image = vm.backgroundImage
        self.view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(restaurantListButton)
        buttonsStackView.addArrangedSubview(showRestaurantOnMapButton)
        backgroundImage.snp.makeConstraints { make in
            make.centerX.centerY.height.width.equalToSuperview()
        }
        buttonsStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().offset(-view.bounds.height/4)
        }
    }
    
    @objc
    func didTapButton(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "Restaurants List":
            navigationController?.pushViewController(router.cafeListVC(), animated: true)
        case "Restaurants On The Map":
            navigationController?.pushViewController(router.cafeListVC(), animated: true)
        default:
            break
        }
    }
    
}

