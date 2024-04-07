//
//  SearchVM.swift
//  CafeMap Baku
//
//  Created by Veysal Hasanbayli on 07.04.24.
//

import UIKit
import MapKit


class SearchVM: NSObject {
    var reloadTableViewClosure: (() -> ())?
    var didSelectLocation: ((String, CLLocationCoordinate2D)->())?
    var searchResults: [MKMapItem] = []{
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    func searchLocation(_ locationName: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = locationName
        let search = MKLocalSearch(request: request)
        search.start { [weak self] (response, error) in
            guard let self = self else { return }
            if let response = response {
                self.searchResults = response.mapItems
            } else if let error = error {
                print("Error searching for location: \(error.localizedDescription)")
            }
        }
    }
}

extension SearchVM: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            searchResults.removeAll()
            return
        }
        searchLocation(searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchResults.count)
        searchBar.resignFirstResponder()
    }
}

extension SearchVM: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = searchResults[indexPath.row].placemark
        didSelectLocation?(selectedItem.title ?? "", selectedItem.coordinate)
    }
}

extension SearchVM: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleSubtitleTableViewCell.identifier, for: indexPath) as! TitleSubtitleTableViewCell
        let item = searchResults[indexPath.row]
        cell.configureWihtSearchItems(with: item)
        return cell
    }
}



