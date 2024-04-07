//
//  TitleSubtitleTableViewCell.swift
//  CafeMap Baku
//
//  Created by Veysal on 04.04.24.
//

import UIKit
import MapKit

class TitleSubtitleTableViewCell: UITableViewCell {
    private var nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    private var locationLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    private var labelsStackView: UIStackView = {
       var sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .leading
        sv.spacing = 4
        return sv
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWihtRestaurant(with model: Cafe) {
        nameLabel.text = model.name
        locationLabel.text = model.location
    }
    
    func configureWihtSearchItems(with list: MKMapItem) {
        nameLabel.text = list.name
        locationLabel.text = list.placemark.title
    }
    
    func configureConstraint() {
        contentView.addSubview(labelsStackView)
        [nameLabel,locationLabel].forEach {
            labelsStackView.addArrangedSubview($0)
        }
        labelsStackView.snp.makeConstraints { make in
            make.centerY.equalTo(snp.centerY)
            make.left.equalTo(snp.left).offset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
    }
}
