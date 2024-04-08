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
    func makeAlertAction(on vc: UIViewController, with title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
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
}
