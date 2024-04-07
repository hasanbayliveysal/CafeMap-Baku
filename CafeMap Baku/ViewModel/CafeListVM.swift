//
//  CafeListVM.swift
//  CafeMap Baku
//
//  Created by Veysal on 04.04.24.
//

import UIKit
class CafeListVM: NSObject{
   
    func writeData() {
        DataBaseManager.shared.writeDataToRealm()
        DataBaseManager.shared.writeCustomCafeToRealm(with: Cafe(name: "Qayali Restaurant", location: "Quba Qechresh", desc: "this is the burger", websiteUrl: "mc.az"))
    }
    func fetchData() -> [Cafe] {
        return DataBaseManager.shared.loadDataFromRealm() 
    }
    var didSelectRowAt: ((Cafe)->())? = nil
    
}

extension CafeListVM: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchData().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleSubtitleTableViewCell.identifier, for: indexPath) as! TitleSubtitleTableViewCell
        cell.configureWihtRestaurant(with: fetchData()[indexPath.row])
        return cell
    }
}

extension CafeListVM: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAt?(fetchData()[indexPath.row])
    }
}
