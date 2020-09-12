//
//  HomeController.swift
//  Roomy
//
//  Created by Ashraf on 3/12/20.
//  Copyright © 2020 Ashraf Dewan. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    private let signInAuthToken = KeychainWrapper.standard.string(forKey: "SignInAuthToken") ?? ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func StartButtonTapped(_ sender: UIButton) {        
        if signInAuthToken == "" {
            goToSignInController()
        } else {       
            goToListOfRoomsController()
        }
    }
    
    private func goToSignInController() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SignInController") as? SignInController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    private func goToListOfRoomsController() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ListOfRoomsController") as? ListOfRoomsController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}
