//
//  AddNewViewController.swift
//  CafeMap Baku
//
//  Created by Veysal Hasanbayli on 07.04.24.
//

import UIKit
import MapKit

class AddNewViewController: BaseViewController<AddNewCafeVM> {
    var cafeLocationCoordinate: CLLocationCoordinate2D? = nil
    private var nameTextFieldView: CustomTextFieldView = {
        var view = CustomTextFieldView()
        view.customTF.placeholder = "Restaurant name"
        return view
    }()
    private var descTextFieldView: CustomTextFieldView = {
        var view = CustomTextFieldView()
        view.customTF.placeholder = "Descripton"
        return view
    }()
    private var webSiteTextFieldView: CustomTextFieldView = {
        var view = CustomTextFieldView()
        view.customTF.placeholder = "Website URL (If restaurant has)"
        return view
    }()
    var locationTextFieldView: CustomTextFieldView = {
        var view = CustomTextFieldView()
        view.customTF.placeholder = "Restaurant location"
        view.customTF.addTarget(self, action: #selector(didTapLocationTF), for: .allEditingEvents )
        return view
    }()
    private var stackView: UIStackView = {
        var sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 16
        return sv
    }()
    
    private var saveButton: UIButton = {
        var button = UIButton()
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 6
        return button
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
extension AddNewViewController {
    private func configureUIElements() {
        view.backgroundColor = .white
        setupConstraint()
    }
    private func setupConstraint() {
        view.addSubview(stackView)
        [nameTextFieldView,descTextFieldView,webSiteTextFieldView,locationTextFieldView,saveButton].forEach {
            stackView.addArrangedSubview($0)
            $0.snp.makeConstraints { make in
                make.height.equalTo(48)
            }
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.right.equalToSuperview().inset(16)
        }
    }
    
    @objc
    func didTapLocationTF() {
        let vc = router.searchVC() as! SearchViewController
        vc.delegate = self
        self.present(vc, animated: true)
    }
    @objc
    func didTapSaveButton() {
        guard let name = nameTextFieldView.customTF.text, !name.isEmpty,
              let description = descTextFieldView.customTF.text, !description.isEmpty,
              let locationName = locationTextFieldView.customTF.text, !locationName.isEmpty,
              let locationCoordinate = cafeLocationCoordinate
        else {
            return
        }
        var websiteUrl: String? = nil
        if let url = webSiteTextFieldView.customTF.text, !url.isEmpty {
            websiteUrl = url
        }
        let myItem = Cafe(
            name: name,
            locationName: locationName,
            locationCoordinate: locationCoordinate,
            desc: description,
            websiteUrl: websiteUrl)
        vm.saveNewCafe(with: myItem)
        navigationController?.popViewController(animated: true)
    }
}

extension AddNewViewController: SearchViewControllerDelegate {
    func didSelectSearchedLocation(cafeName: String, cafeLocation: CLLocationCoordinate2D) {
        locationTextFieldView.customTF.text = cafeName
        cafeLocationCoordinate = cafeLocation
    }
}
