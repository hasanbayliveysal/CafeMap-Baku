//
//  CafeListViewController.swift
//  CafeMap Baku
//
//  Created by Veysal on 04.04.24.
//

import UIKit
import SnapKit
class CafeListViewController: BaseViewController<CafeListVM> {
    lazy var cafeListTableView : UITableView = {
        let tableView = UITableView()
        tableView.dataSource = vm
        tableView.delegate   = vm
        tableView.register(TitleSubtitleTableViewCell.self, forCellReuseIdentifier: TitleSubtitleTableViewCell.identifier)
       return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewItems()
        title = "Restaurant"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cafeListTableView.reloadData()
    }
}
extension CafeListViewController {
    func configureViewItems(){
        setupConstraint()
        vm.writeData()
        vm.didSelectRowAt = { [weak self] cafe in
            let vc = self?.router.detailsVC() as! DetailsViewController
            vc.descLabel.text = cafe.desc
            self?.present(vc, animated: true)
        }
        let addNewCafeButton = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(didTapAddNewCafe))
        navigationItem.rightBarButtonItem = addNewCafeButton
    }
    func setupConstraint(){
        view.addSubview(cafeListTableView)
        cafeListTableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    @objc
    func didTapAddNewCafe() {
         navigationController?.pushViewController(router.addNewVC(), animated: true) 
    }
}
