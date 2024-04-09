//
//  DetailsViewController.swift
//  CafeMap Baku
//
//  Created by Veysal Hasanbayli on 05.04.24.
//

import UIKit
import SafariServices

class DetailsViewController: BaseViewController<DetailsVM> {
    private var websiteUrl: String? = nil
    var distance: String? = nil
    var cafeItem: Cafe? = nil
    var cafeName: String? = nil
    private var descLabel: UITextField = {
        var label = UITextField()
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 16
        label.isUserInteractionEnabled = false
        label.textAlignment = .center
        return label
    }()
    
    private var nameLabel: UILabel = {
        var label = UILabel()
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.borderWidth = 2
        label.numberOfLines = 0
        label.layer.cornerRadius = 16
        label.textAlignment = .center
        return label
    }()
    
    private var locationName: UILabel = {
        var label = UILabel()
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 16
        label.textAlignment = .center
        return label
    }()
    
    private var visitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Visit Website", for: .normal)
        button.addTarget(self, action: #selector(didTapVisitButton), for: .touchUpInside)
        button.backgroundColor = .red
        button.layer.cornerRadius = 16
        return button
    }()
    private var editLabel: UILabel = {
        let label = UILabel()
        label.text = "edit description"
        label.textColor = .systemBlue
        label.textAlignment = .right
        return label
    }()
    private var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 16
        return sv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViewItems()
    }
}

extension DetailsViewController {
    private func configureViewItems() {
        setupConstraint()
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(didTapEditButton))
        editLabel.isUserInteractionEnabled = true
        editLabel.addGestureRecognizer(gestureRec)
        [nameLabel,locationName,descLabel,visitButton,editLabel].forEach({
            stackView.addArrangedSubview($0)
            $0.snp.makeConstraints { make in
                make.height.greaterThanOrEqualTo(48)
            }
        })
    }
    private func setupConstraint(){
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.right.equalToSuperview().inset(16)
        }
        guard let cafeItem else {
            return
        }
        cafeName = cafeItem.name
        if let distance {
            nameLabel.text = "Restaurant: \(cafeItem.name) \n \(distance)"
        } else {
            nameLabel.text = "Restaurant: \(cafeItem.name)"
        }
        descLabel.text = cafeItem.desc
        locationName.text = cafeItem.locationName
        websiteUrl = cafeItem.websiteUrl
        guard let websiteUrl else {
            visitButton.isHidden = true
            return
        }
        self.websiteUrl = websiteUrl
        visitButton.isHidden = false
    }
    
    @objc
    func didTapVisitButton() {
        guard let text = websiteUrl else {return}
        vm.openCafeWebsite(with: text, and: self)
    }
    
    @objc
    func didTapEditButton() {
        switch editLabel.text {
        case "edit description":
            descLabel.isUserInteractionEnabled = true
            descLabel.becomeFirstResponder()
            editLabel.text = "save changes"
        case "save changes":
            guard let name = cafeName, !name.isEmpty,
                  let desc = descLabel.text, !desc.isEmpty
            else {
                descLabel.becomeFirstResponder()
                emptyDescriptionAlert(title: "It cannot be empty, please write something")
                return
            }
            descLabel.isUserInteractionEnabled = false
            descLabel.resignFirstResponder()
            vm.updateData(with: name, and: desc)
            editLabel.text = "edit description"
        default :
            break
        }
       
        
    }
    
    private func emptyDescriptionAlert(title: String) {
        AlertManager.shared.makeAlertAction(on: self, with: title, and: nil)
    }
}

