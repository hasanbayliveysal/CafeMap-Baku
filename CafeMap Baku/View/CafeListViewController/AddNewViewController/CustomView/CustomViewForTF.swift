//
//  CustomViewForTF.swift
//  CafeMap Baku
//
//  Created by Veysal Hasanbayli on 07.04.24.
//

import UIKit

class CustomTextFieldView: UIView {
    
    var customTF: UITextField = {
        var tf = UITextField()
        return tf
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addSubview(customTF)
        customTF.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(8)
            make.right.equalTo(snp.right).offset(-8)
            make.bottom.equalTo(snp.bottom).offset(-8)
            make.top.equalTo(snp.top).offset(8)
        }
        layer.borderColor = UIColor.blue.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 6
    }
    
}
