//
//  BaseViewController.swift
//  CafeMap Baku
//
//  Created by Veysal on 04.04.24.
//

import UIKit

class BaseViewController<VM>: UIViewController {

    var vm: VM
    var router: Router
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(vm: VM, router: Router) {
        self.vm = vm
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
