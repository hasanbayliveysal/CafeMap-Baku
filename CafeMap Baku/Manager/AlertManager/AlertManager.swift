//
//  AlertManager.swift
//  CafeMap Baku
//
//  Created by Veysal Hasanbayli on 08.04.24.
//

import UIKit

class AlertManager {
    static let shared = AlertManager()
    var yesButtonTapped: (()->())? = nil
    func makeAlertAction(on vc: UIViewController, with title: String, and message: String?) {
        let  alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(cancelButton)
        if ((vc as? DetailsViewController) == nil) {
            let yesButton    = UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
                self?.yesButtonTapped?()
            }
            alert.addAction(yesButton)
        }
        vc.present(alert, animated: true)
    }
    
    func showBottomAlert(message: String, view: UIView) {
        let bottomAlertView = BottomAlertView()
        bottomAlertView.setMessage(message)
        view.addSubview(bottomAlertView)
        bottomAlertView.layer.cornerRadius = 12
        bottomAlertView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(140)
        }
        bottomAlertView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bottomAlertView.alpha = 1
        }) { _ in
            bottomAlertView.removeFromSuperview()
        }
    }
}
