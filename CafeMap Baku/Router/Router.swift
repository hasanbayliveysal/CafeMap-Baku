//
//  Router.swift
//  CafeMap Baku
//
//  Created by Veysal on 04.04.24.
//

import UIKit

protocol RouterProtocol {
    func mainVC () -> UIViewController
    func cafeListVC () -> UIViewController
    func detailsVC () -> UIViewController
    func addNewVC () -> UIViewController
    func searchVC() -> UIViewController
}

class Router: RouterProtocol {
    public func mainVC() -> UIViewController {
        return MainViewController(vm: MainViewVM(), router: self)
    }
    public func cafeListVC() -> UIViewController {
        return CafeListViewController(vm: CafeListVM(), router: self)
    }
    public func detailsVC() -> UIViewController {
        return DetailsViewController(vm: DetailsVM(), router: self)
    }
    func addNewVC() -> UIViewController {
        return AddNewViewController(vm: AddNewCafeVM(), router: self)
    }
    func searchVC() -> UIViewController {
        return SearchViewController(vm: SearchVM(), router: self)
    }
}
