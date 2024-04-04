//
//  Router.swift
//  CafeMap Baku
//
//  Created by Veysal on 04.04.24.
//

import UIKit

protocol RouterProtocol {
    func mainVC () -> UIViewController
}

class Router: RouterProtocol {
    public func mainVC() -> UIViewController {
        return MainViewController(vm: MainViewVM(), router: self)
    }
}
