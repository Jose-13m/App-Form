//
//  ModelDataPersistence.swift
//  App-Form
//
//  Created by José Manuel De Jesús Martínez on 09/02/24.
//

import Foundation

struct ModelDataPersistence: Codable {
    var name: String?
    var firstSurName: String?
    var secondSurname: String?
    var email: String?
    var cellPhone: String?
    
    var idRealm: Int?
}
