//
//  LaunchScreenViewController.swift
//  App-Form
//
//  Created by José Manuel De Jesús Martínez on 09/02/24.
//

import UIKit
import LBTATools

//MARK: Global Colors
var colorBackground = UIColor(named: "ColorBackground")
var colorView = UIColor(named: "ColorView")
var colorSubView = UIColor(named: "ColorSubView")


class LaunchScreenViewController: UIViewController {
    //MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = colorBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLaunchImage()
    }
    
    override func viewDidLayoutSubviews() {
        goToFirtsAppView()
    }
    
    //MARK: Helpers
    private func setupLaunchImage(){
        let launchImageView = UIImageView(image: UIImage(named: "AppIcon"))
        launchImageView.contentMode = .scaleAspectFit
        
        view.addSubview(launchImageView)
        launchImageView.centerInSuperview(size: .init(width: 360, height: 360))
    }
    
    
    
    private func goToFirtsAppView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let mainWindow = windowScene.windows.filter({ $0.isKeyWindow}).first {
                mainWindow.rootViewController = UINavigationController(rootViewController: ViewController())
            }
        })
    }
}
