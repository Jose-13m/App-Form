//
//  UsersSavedViewController.swift
//  App-Form
//
//  Created by José Manuel De Jesús Martínez on 09/02/24.
//

import UIKit

protocol UsersSavedDelegate {
    func userSeleted(item: Int, users: [ModelDataPersistence])
}

class UsersSavedViewController: UIViewController {
    var usersArray: [ModelDataPersistence] = []
    
    //MARK: Properties
    var delegate: UsersSavedDelegate?
    lazy var usersTableView: UITableView = {
        let tb = UITableView()
        tb.dataSource = self
        tb.delegate = self
        tb.backgroundColor = colorView
        return tb
    }()
    
    //MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = colorView
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    //MARK: Helpers
    private func setupTableView(){
        view.addSubview(usersTableView)
        usersTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
}

extension UsersSavedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextStringsApp.defaultTableViewCell) ?? UITableViewCell(style: .default, reuseIdentifier: TextStringsApp.defaultTableViewCell)
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = .boldSystemFont(ofSize: 12)
        cell.backgroundColor = colorSubView
        
        if usersArray.count > 0 {
            let user = usersArray[indexPath.row]
            cell.textLabel?.text = "\(user.name ?? "") \(user.firstSurName ?? "") \(user.secondSurname ?? ""): \(user.email ?? "") \(user.cellPhone ?? "")"
        }else{
            cell.textLabel?.text = TextStringsApp.whitOutSavedUsers
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        }
        return cell
    }
    
    
}

extension UsersSavedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.userSeleted(item: indexPath.row, users: usersArray)
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if usersArray.count > 0 {
            let deleteSwipe = UIContextualAction(style: .destructive, title: TextStringsApp.delete) { [weak self] action, view, completion in
                
                if typeDataToUse == "Realm"{
                    RealmSwiftManager.shared.deleteUser(id: self?.usersArray[indexPath.row].idRealm ?? 0)
                    self?.usersArray.remove(at: indexPath.row)
                }else{
                    self?.usersArray.remove(at: indexPath.row)
                    do {
                        _ = try DataPersistenceManager.shared.saveDataUsers(users: self?.usersArray ?? [])
                    }catch let err as DataPersistenceError {
                        print("Error custom: ", err.message)
                    }catch {
                        print("Error generico: ", error.localizedDescription)
                    }
                }
                
                self?.delegate?.userSeleted(item: -1, users: self?.usersArray ?? [])
                self!.dismiss(animated: true)
                completion(true)
                
            }
            deleteSwipe.backgroundColor = .systemRed
            return UISwipeActionsConfiguration(actions: [deleteSwipe])
        }else{
            return UISwipeActionsConfiguration(actions: [])
        }
    }
}
