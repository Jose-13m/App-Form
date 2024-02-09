//
//  RealmSwiftManager.swift
//  App-Form
//
//  Created by José Manuel De Jesús Martínez on 09/02/24.
//

import Foundation
import RealmSwift

class RealmSwiftManager {
    static let shared = RealmSwiftManager()
    
    fileprivate let realm = try! Realm()
    
    func addUser(user: ModelUserRealmSwift) {
        do {
            try realm.write {
                let userToSave = ModelUserRealmSwift()
                userToSave.name = user.name
                userToSave.firstSurName = user.firstSurName
                userToSave.secondSurname = user.secondSurname
                userToSave.email = user.email
                userToSave.cellPhone = user.cellPhone
                realm.add(userToSave)
                print("Usuario agregado")
            }
        } catch {
            print("Error al guardar: \(error.localizedDescription)")
        }
    }
    
    func add_User(user: ModelUserRealmSwift) {
        if let lastUser = realm.objects(ModelUserRealmSwift.self).sorted(byKeyPath: "id", ascending: true).last {
            let currentId = lastUser.id + 1
            
            let userToSave = ModelUserRealmSwift()
            userToSave.id = currentId
            userToSave.name = user.name
            userToSave.firstSurName = user.firstSurName
            userToSave.secondSurname = user.secondSurname
            userToSave.email = user.email
            userToSave.cellPhone = user.cellPhone
            
            do {
                try realm.write {
                    realm.add(userToSave)
                    print("Usuario agregado: \(currentId)")
                }
            } catch {
                print("Error al agregar usuario: \(error.localizedDescription)")
            }
        } else {
            let userToSave = ModelUserRealmSwift()
            userToSave.id = 1
            userToSave.name = user.name
            userToSave.firstSurName = user.firstSurName
            userToSave.secondSurname = user.secondSurname
            userToSave.email = user.email
            userToSave.cellPhone = user.cellPhone
            
            do {
                try realm.write {
                    realm.add(userToSave)
                    print("Primer usuario agregado con ID: 1")
                }
            } catch {
                print("Error al agregar primer usuario: \(error.localizedDescription)")
            }
        }
    }


    func consultarPersonas() -> [ModelUserRealmSwift]? {
        do {
            let realm = try Realm()
            let personas = realm.objects(ModelUserRealmSwift.self)
            return Array(personas)
        } catch {
            print("Error al consultar: \(error.localizedDescription)")
            return nil
        }
    }

    func deleteUser(id: Int) {
        do {
            if let usuarioAEliminar = realm.object(ofType: ModelUserRealmSwift.self, forPrimaryKey: id) {
                try realm.write {
                    realm.delete(usuarioAEliminar)
                }
            } else {
                print("El usuario con ID \(id) no existe en la base de datos.")
            }
        } catch {
            print("Error al eliminar: \(error.localizedDescription)")
        }
    }

    func updateUser(UserToUpdate: ModelUserRealmSwift, id: Int) {
        do {
            if let userToUpdateInRealm = realm.object(ofType: ModelUserRealmSwift.self, forPrimaryKey: id) {
                try realm.write {
                    userToUpdateInRealm.name = UserToUpdate.name
                    userToUpdateInRealm.firstSurName = UserToUpdate.firstSurName
                    userToUpdateInRealm.secondSurname = UserToUpdate.secondSurname
                    userToUpdateInRealm.email = UserToUpdate.email
                    userToUpdateInRealm.cellPhone = UserToUpdate.cellPhone
                }
                print("Usuario con ID \(id) actualizado correctamente.")
            } else {
                print("El usuario con ID \(id) no existe en la base de datos.")
            }
        } catch {
            print("Error al actualizar: \(error.localizedDescription)")
        }
    }
}
