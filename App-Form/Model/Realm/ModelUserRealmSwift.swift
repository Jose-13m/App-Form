//
//  ModelUserRealmSwift.swift
//  App-Form
//
//  Created by José Manuel De Jesús Martínez on 09/02/24.
//

import Foundation
import RealmSwift

class ModelUserRealmSwift: Object {
    @objc dynamic var id = 0
    @objc dynamic var name: String = ""
    @objc dynamic var firstSurName: String = ""
    @objc dynamic var secondSurname: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var cellPhone: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
