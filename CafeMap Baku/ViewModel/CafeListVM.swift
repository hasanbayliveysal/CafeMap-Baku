//
//  CafeListVM.swift
//  CafeMap Baku
//
//  Created by Veysal on 04.04.24.
//

import UIKit
class CafeListVM: NSObject{
    private var animatedIndexPaths = Set<IndexPath>()
    func writeData() {
        DataBaseManager.shared.writeDataToRealm()
    }
    func fetchData() -> [Cafe] {
        return DataBaseManager.shared.loadDataFromRealm().reversed()
    }
    var didSelectRowAt: ((Cafe)->())? = nil
    
}

extension CafeListVM: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchData().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleSubtitleTableViewCell.identifier, for: indexPath) as! TitleSubtitleTableViewCell
        cell.alpha = 0
        if !animatedIndexPaths.contains(indexPath) {
            cell.alpha = 0
            UIView.animate(withDuration: 1) {
                cell.alpha = 1
            }
            animatedIndexPaths.insert(indexPath)
        }
        cell.configureWihtRestaurant(with: fetchData()[indexPath.row])
        return cell
    }
}

extension CafeListVM: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAt?(fetchData()[indexPath.row])
    }
}
