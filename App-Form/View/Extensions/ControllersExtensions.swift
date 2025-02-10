//
//  ControllersExtensions.swift
//  App-Form
//
//  Created by José Manuel De Jesús Martínez on 09/02/24.
//

import Foundation
import UIKit

extension UIViewController {
 
    func setupTitleNavBar(title: String) {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.label ]
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = colorView
       
        navigationController?.navigationBar.layer.shadowOpacity = 0.5
        navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        navigationItem.title = title
    }
    
    func printLocation(functionName: String, fileName: String, lineNumber: Int, columnNumber: Int, dsohandle: UnsafeRawPointer) {
        print("##### Function: \(functionName), File: \(fileName), Line: \(lineNumber), Column: \(columnNumber), dsohandle: \(dsohandle)")
    }
}
