//
//  CafeObject.swift
//  CafeMap Baku
//
//  Created by Veysal on 04.04.24.
//

import RealmSwift



class Cafe: Object, Decodable {
       @Persisted var name: String = ""
       @Persisted var location: String = ""
       @Persisted var desc: String = ""
       @Persisted var websiteUrl: String?

    convenience init(name: String, location: String, desc: String, websiteUrl: String?) {
           self.init()
           self.name = name
           self.location = location
           self.desc = desc
           self.websiteUrl = websiteUrl
       }
}
