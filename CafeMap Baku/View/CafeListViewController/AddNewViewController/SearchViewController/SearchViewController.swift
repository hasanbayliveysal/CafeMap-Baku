//
//  SearchViewController.swift
//  CafeMap Baku
//
//  Created by Veysal Hasanbayli on 07.04.24.
//

import UIKit
import MapKit

class SearchViewController: BaseViewController<SearchVM> {
    var delegate: SearchViewControllerDelegate?
    private let searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        return searchBar
    }()
    private let locationTableView: UITableView = {
        var tv = UITableView()
        tv.register(TitleSubtitleTableViewCell.self, forCellReuseIdentifier: TitleSubtitleTableViewCell.identifier)
        return tv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
    }
}
extension SearchViewController {
    private func configureUIElements() {
        view.backgroundColor = .white
        searchBar.searchTextField.autocorrectionType = .no
        searchBar.becomeFirstResponder()
        self.view.addSubview(searchBar)
        self.view.addSubview(locationTableView)
        searchBar.delegate = vm
        locationTableView.delegate = vm
        locationTableView.dataSource = vm
        setupConstraint()
        vm.reloadTableViewClosure = { [weak self] in
            self?.locationTableView.reloadData()
        }
        vm.didSelectLocation = { [weak self] name, location in
            print(name, location.latitude)
            self?.delegate?.didSelectSearchedLocation(cafeName: name, cafeLocation: location)
            self?.dismiss(animated: true)
        }
    }
    private func setupConstraint() {
        searchBar.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview().inset(8)
        }
        locationTableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(8)
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-50)
        }
    }
 
}

