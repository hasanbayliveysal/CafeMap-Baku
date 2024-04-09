//
//  BottomAlertView.swift
//  CafeMap Baku
//
//  Created by Veysal Hasanbayli on 09.04.24.
//

import UIKit
class BottomAlertView: UIView {
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray.withAlphaComponent(0.7)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(8)
        }
    }
    
    func setMessage(_ message: String) {
        messageLabel.text = message
    }
}
