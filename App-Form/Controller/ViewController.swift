//
//  ViewController.swift
//  App-Form
//
//  Created by José Manuel De Jesús Martínez on 09/02/24.
//

import UIKit
import LBTATools
import MaterialComponents.MaterialTextControls_FilledTextFields

let typeDataToUse = "UserDefaults" // Realm or UserDefaults To use in the app

class ViewController: UIViewController {
    //MARK: Properties
    private let nameTextField = MDCFilledTextField(labelTitle: TextStringsApp.nameWithPoints, placeholder: TextStringsApp.name)
    private let firstSurnameTextField = MDCFilledTextField(labelTitle: TextStringsApp.firstSurNameWithPoints, placeholder: TextStringsApp.firstSurName)
    private let secondSurnameTextField = MDCFilledTextField(labelTitle: TextStringsApp.secondSurnameWithPoints, placeholder: TextStringsApp.secondSurname)
    private let emailTextField = MDCFilledTextField(labelTitle: TextStringsApp.emailWithPoints, placeholder: TextStringsApp.email, typeKeyboard: UIKeyboardType.emailAddress)
    private let phoneTextField = MDCFilledTextField(labelTitle: TextStringsApp.cellPhoneWithPoints, placeholder: TextStringsApp.cellPhone, typeKeyboard: UIKeyboardType.numberPad)
    private lazy var saveButton = UIButton(title: TextStringsApp.save, titleColor: .white, backgroundColor: .systemBlue, target: self, action:  #selector(saveDataUser))
    private lazy var getUsersButton = UIButton(title: TextStringsApp.getSavedUsers, titleColor: .white, backgroundColor: .systemCyan, target: self, action:  #selector(showController))
    private lazy var addNewUserButton = UIButton(title: TextStringsApp.addOtherUser, titleColor: .white, backgroundColor: .systemGreen, target: self, action:  #selector(clearView))
    private lazy var textFieldsArray = [nameTextField, firstSurnameTextField, secondSurnameTextField, emailTextField, phoneTextField]
    let sscrollView = UIScrollView(backgroundColor: colorBackground!)

    var usersArray: [ModelDataPersistence] = []
    var typeOfButton = TextStringsApp.save
    var itemSelected = -1
    
    //MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTitleNavBar(title: TextStringsApp.form)
        view.backgroundColor = colorBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataUsers()
        setupViewComponents()
    }


    //MARK: Helpers
    private func setupViewComponents(){
        let contentView = UIView(backgroundColor: colorBackground!)
        contentView.stack(nameTextField,
                          firstSurnameTextField,
                          secondSurnameTextField,
                          emailTextField,
                          phoneTextField,
                          phoneTextField,
                          saveButton,
                          getUsersButton,
                          addNewUserButton,
                          spacing: 20)
        
        sscrollView.addSubview(contentView)
        contentView.anchor(top: sscrollView.topAnchor, leading: sscrollView.leadingAnchor, bottom: sscrollView.bottomAnchor, trailing: sscrollView.trailingAnchor, padding: .allSides(20))
        contentView.centerXTo(sscrollView.centerXAnchor)
        
        view.addSubview(sscrollView)
        sscrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        sscrollView.centerXTo(view.centerXAnchor)
        
        
    }
    
    private func allDataFilled() -> Int {
        var emptys = 0
        textFieldsArray.forEach ({ textfiled in
            if textfiled.text?.isEmpty == true || textfiled.text == ""{
                textfiled.setError(textError: ""/*TextStringsApp.obligatoryField*/)
                emptys += 1
            }else{
                textfiled.setOk()
            }
        })
        
        return emptys == 0 ? 0 : 1
    }
    
    private func showAlert(tittle: String, message: String, actions: [UIAlertAction], type: UIAlertController.Style = .alert){
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: type)
        
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true)
    }
    
    private func getDataUsers(){
        if typeDataToUse == "Realm"{
            let aux = RealmSwiftManager.shared.consultarPersonas()
            usersArray.removeAll()
            for user in aux ?? [] {
                usersArray.append(ModelDataPersistence(name: user.name, firstSurName: user.firstSurName, secondSurname: user.secondSurname, email: user.email, cellPhone: user.cellPhone, idRealm: user.id ))
            }
        }else{
            usersArray = DataPersistenceManager.shared.getDataUsers() ?? []
        }
        
        getUsersButton.isHidden = usersArray.count > 0 ? false : true
        addNewUserButton.isHidden = itemSelected > 0 ? false : true
    }
    
    private func saveWithDataPersistence(){
        usersArray.append(ModelDataPersistence(name: textFieldsArray[0].text!, firstSurName: textFieldsArray[1].text!, secondSurname: textFieldsArray[2].text!, email: textFieldsArray[3].text!, cellPhone: textFieldsArray[4].text!))
        DataPersistenceManager.shared.saveDataUsers(users: usersArray)
    }
    
    private func updateDataPersistence(){
        usersArray[itemSelected].name = textFieldsArray[0].text!
        usersArray[itemSelected].firstSurName = textFieldsArray[1].text!
        usersArray[itemSelected].secondSurname = textFieldsArray[2].text!
        usersArray[itemSelected].email = textFieldsArray[3].text!
        usersArray[itemSelected].cellPhone = textFieldsArray[4].text!
        
        DataPersistenceManager.shared.saveDataUsers(users: usersArray)
    }
    
    private func saveWithRealmSwift(){
        let user = ModelUserRealmSwift()
        user.name = textFieldsArray[0].text!
        user.firstSurName = textFieldsArray[1].text!
        user.secondSurname = textFieldsArray[2].text!
        user.email = textFieldsArray[3].text!
        user.cellPhone = textFieldsArray[4].text!
        RealmSwiftManager.shared.add_User(user: user)
    }
    
    private func updateWithRealmSwift(){
        let user = ModelUserRealmSwift()
        user.name = textFieldsArray[0].text!
        user.firstSurName = textFieldsArray[1].text!
        user.secondSurname = textFieldsArray[2].text!
        user.email = textFieldsArray[3].text!
        user.cellPhone = textFieldsArray[4].text!
        RealmSwiftManager.shared.updateUser(UserToUpdate: user, id: usersArray[itemSelected].idRealm ?? 0)
    }
    
    //MARK: Selectors
    @objc private func saveDataUser(){
        if allDataFilled() == 0{
            if typeOfButton == TextStringsApp.save{ //To Add User Data
                if typeDataToUse == "Realm"{
                    saveWithRealmSwift()
                }else{
                    saveWithDataPersistence()
                }
                showAlert(tittle: TextStringsApp.atention, message: TextStringsApp.addedUser, actions: [.init(title: TextStringsApp.acept, style: .default)])
            }else{//To Update User Data
                if typeDataToUse == "Realm"{
                    updateWithRealmSwift()
                }else{
                    updateDataPersistence()
                }
                showAlert(tittle: TextStringsApp.atention, message: TextStringsApp.updatedUser, actions: [.init(title: TextStringsApp.acept, style: .default)])
            }
            
            getDataUsers()
            clearView()
        }else{
            showAlert(tittle: TextStringsApp.atention, message: TextStringsApp.allTextFieldsMustBeFilled, actions: [.init(title: TextStringsApp.acept, style: .default)])
        }
    }
    
    @objc private func showController(){
        clearView()
        let vc = UsersSavedViewController()
        vc.usersArray = self.usersArray
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @objc private func clearView(){
        for item in textFieldsArray {
            item.text = ""
        }
        saveButton.setTitle(TextStringsApp.save, for: .normal)
        typeOfButton = TextStringsApp.save
        itemSelected = -1
        addNewUserButton.isHidden = true
    }
}

//MARK: UsersSavedDelegate
extension ViewController: UsersSavedDelegate {
    func userSeleted(item: Int, users: [ModelDataPersistence]) {
        itemSelected = item
        if item >= 0{
            typeOfButton = TextStringsApp.update
            textFieldsArray[0].text = usersArray[item].name
            textFieldsArray[1].text = usersArray[item].firstSurName
            textFieldsArray[2].text = usersArray[item].secondSurname
            textFieldsArray[3].text = usersArray[item].email
            textFieldsArray[4].text = usersArray[item].cellPhone
            saveButton.setTitle(TextStringsApp.update, for: .normal)
        }
        self.usersArray = users
        
        addNewUserButton.isHidden = itemSelected > 0 ? false : true
        getUsersButton.isHidden = usersArray.count > 0 ? false : true
    }
}
