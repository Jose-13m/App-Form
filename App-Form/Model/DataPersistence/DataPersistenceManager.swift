//
//  DataPersistenceManager.swift
//  App-Form
//
//  Created by José Manuel De Jesús Martínez on 09/02/24.
//

import Foundation

enum DataPersistenceError: Error {
    case missingUserData
    case emptyUserData
    case invalidUserData
    case failJsonString
    case encodingFailed
    case decodingFailed
    
    var message: String {
        switch self{
        case .missingUserData:
            return "Sin datos guardados"
        case .invalidUserData:
            return "invalidUserData xD"
        case .failJsonString:
            return "Error al crear JSON"
        case .decodingFailed:
            return "Error al decodificar JSON"
        case .encodingFailed:
            return "Error al codificar JSON"
        case .emptyUserData:
            return "Sin usuarios guardados"
        }
        
    }
}


class DataPersistenceManager {
    static let shared = DataPersistenceManager()
    
    func  saveDataUsers(users: [ModelDataPersistence]) throws -> Bool {
        if let jsonUsersToSave = try? JSONEncoder().encode(users) {
            guard let jsonString = String(data: jsonUsersToSave, encoding: String.Encoding.utf8) else{
                print("c")
                throw DataPersistenceError.failJsonString
            }
            UserDefaults.standard.setValue(jsonString, forKey: "users")
            return true
        }else{
            throw DataPersistenceError.encodingFailed
        }
    }
    
    
    func getDataUsers() -> Result<[ModelDataPersistence], Error> {
        guard let usersString = UserDefaults.standard.string(forKey: "users") else {
            return .failure(DataPersistenceError.missingUserData as Error)
        }

        guard let jsonData = usersString.data(using: .utf8) else {
            return .failure(DataPersistenceError.invalidUserData as Error)
        }

        do {
            let users = try JSONDecoder().decode([ModelDataPersistence].self, from: jsonData)
            
            if users.isEmpty{
                return .failure(DataPersistenceError.missingUserData as Error)
            }else{
                return .success(users)
            }
        } catch {
            return .failure(DataPersistenceError.decodingFailed as Error)
        }
    }

}
