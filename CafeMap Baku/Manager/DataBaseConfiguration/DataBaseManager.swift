//
//  DataBaseManager.swift
//  CafeMap Baku
//
//  Created by Veysal on 04.04.24.
//

import UIKit
import RealmSwift

protocol DataBaseManagerProtocol {
    func writeDataToRealm()
    func loadDataFromRealm() -> [Cafe]
    func updateDescription(with cafeName: String, and description: String)
    func writeCustomCafeToRealm(with model: Cafe)
}

class DataBaseManager: DataBaseManagerProtocol {
    static var shared = DataBaseManager()
    private var realm : Realm?
    private init() {}
    //    MARK: - Write Data To Realm Database
    func writeDataToRealm() {
        do {
            realm = try Realm()
        } catch {
            print("Error initializing Realm: \(error)")
        }
        
        if let path = Bundle.main.url(forResource: "restaurantmock", withExtension: "json") { do {
            let data = try Data(contentsOf: path)
            let cafes = try JSONDecoder().decode([Cafe].self, from: data)
            for cafe in cafes {
                let existingCafe = realm?.objects(Cafe.self).filter("name == %@", cafe.name).first
                if existingCafe == nil {
                    do {
                        try realm?.write({
                            realm?.add(cafes)
                        })
                        print("Cafes added to Realm successfully.")
                    }catch {
                        print("Error adding cafes to Realm: \(error)")
                    }
                }
            }
        } catch {
            print("Error reading JSON data: \(error)")
        }
        }else {
            print("JSON file not found.")
        }
    }
    //    MARK: - Fetch Data From Realm Database
    func loadDataFromRealm() -> [Cafe] {
        var cafeList: [Cafe] = []
        var cafes: Results<Cafe>?
        do {
            realm = try Realm()
        }catch {
            print("Error initializing Realm: \(error)")
        }
        cafes = realm?.objects(Cafe.self)
        if let cafes = cafes {
            for cafe in cafes {
                cafeList.append(cafe)
            }
        }
        return cafeList
    }
    
    //    MARK: - Update Cafe Desc From Realm Database
    
    func updateDescription(with cafeName: String, and description: String) {
        do {
            realm = try Realm()
        }catch {
            print("Error initializing Realm: \(error)")
        }
        if let cafe = realm?.objects(Cafe.self).filter("name == %@", cafeName).first {
            do {
                if !description.isEmpty, cafe.desc != description  {
                    try realm?.write({
                        cafe.desc = description
                    })
                    print("Cafe description updated successfully.")
                } else {
                    print("There is no any changes")
                }
            }catch {
                print("Cafe not found.")
            }
        }
    }
    //    MARK: - Write Custom Data To Realm Database
    func writeCustomCafeToRealm(with model: Cafe) {
        do {
            realm = try Realm()
        }catch {
            print("Error initializing Realm: \(error)")
        }
        let existingCafe = realm?.objects(Cafe.self).filter("name == %@", model.name).first
        if existingCafe == nil {
            do {
                try realm?.write({
                    realm?.add(model)
                })
                print("Custom Cafe added to Realm successfully.")
            }catch {
                print("Error adding cafes to Realm: \(error)")
            }
        } else {
            print("This cafe is already exist")
        }
    }
}
