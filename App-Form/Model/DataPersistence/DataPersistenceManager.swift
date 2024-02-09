//
//  DataPersistenceManager.swift
//  App-Form
//
//  Created by José Manuel De Jesús Martínez on 09/02/24.
//

import Foundation

class DataPersistenceManager {
    static let shared = DataPersistenceManager()
    
    func saveDataUsers(users: [ModelDataPersistence]) {
        if let jsonUsersToSave = try? JSONEncoder().encode(users) {
            guard let jsonString = String(data: jsonUsersToSave, encoding: String.Encoding.utf8) else{
                print("Fail jsonString")
                return
            }
            UserDefaults.standard.setValue(jsonString, forKey: "users")
        }
    }
    
    
    func getDataUsers() -> [ModelDataPersistence]? {
        if let usersString = UserDefaults.standard.string(forKey: "users") {
            guard let jsonString = usersString.data(using: .utf8) else { return nil }
            do {
                let users = try JSONDecoder().decode([ModelDataPersistence].self, from: jsonString)
                print("Saved Users: ", users)
                return users
            }catch {
                print("Fail Creation jsonString")
                return nil
            }
            
        }else{
            print("Fail Creation usersString")
            return nil
        }
    }
}
