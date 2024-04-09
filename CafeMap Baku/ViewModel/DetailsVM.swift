//
//  DetailsVM.swift
//  CafeMap Baku
//
//  Created by Veysal Hasanbayli on 05.04.24.
//

import UIKit
import SafariServices

class DetailsVM {
    init(){}
    
    func openCafeWebsite(with url :String, and vc: UIViewController) {
        if url.contains("https://") {
            if let cafeURL = URL(string: url) {
                let safariViewController = SFSafariViewController(url: cafeURL)
                vc.present(safariViewController, animated: true, completion: nil)
            }
        } else {
            AlertManager.shared.makeAlertAction(on: vc, with: "Cannot open the website, Error: BAD URL", and: nil)
        }
    }
    
    func updateData(with: String, and: String) {
        DataBaseManager.shared.updateDescription(with: with, and: and)
    }
}
