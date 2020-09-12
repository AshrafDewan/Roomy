//
//  SignInController.swift
//  Roomy
//
//  Created by Ashraf on 3/12/20.
//  Copyright © 2020 Ashraf Dewan. All rights reserved.
//

import Alamofire
import NVActivityIndicatorView
import UIKit

class SignInController: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet private weak var emailLabel: UITextField!
    @IBOutlet private weak var passwordLabel: UITextField!
    
    private var loggingIn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - Private Functions

extension SignInController {
    
    @IBAction private func signUpButtonTapped(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpController") as? SignUpController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    @IBAction private func signInButtonTapped(_ sender: UIButton) {
        startAnimating()
        untouchable()
        
        guard let email = emailLabel.text else { return }
        guard let password = passwordLabel.text else { return }

        if checkEmailAndPassword(email: email, password: password) {
            sendSignInRequest(email: email, password: password)
        } else {
            stopAnimating()
        }
        
        untouchable()
    }
    
    private func sendSignInRequest(email: String, password: String) {
        RoomyRequests.signIn(email: email, password: password) { [weak self] (response: Result<SignInResponse, Error>) in
            self?.stopAnimating()
            
            switch response {
            case .success(let data):
                KeychainWrapper.standard.set(data.authToken, forKey: "SignInAuthToken")
                self?.goToListOfRoomsController()
                
            case .failure:
                self?.notRegistered()
            }
        }
    }
    
    private func goToListOfRoomsController() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ListOfRoomsController") as? ListOfRoomsController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    
    private func checkEmailAndPassword(email: String, password: String) -> Bool {
        if email.isEmpty || password.isEmpty {
            emptyField()
        } else if !email.contains("@") || !email.contains(".com") {
            wrongEmail()
        } else if email.contains(" ") || password.contains(" ") {
            emptySpace()
        } else {
            return true
        }
        
        return false
    }
    
    private func untouchable() {
        loggingIn = !loggingIn
        emailLabel.isEnabled = !loggingIn
        passwordLabel.isEnabled = !loggingIn
    }
    
    private func notRegistered() {
        let ac = UIAlertController(title: "Not registered or no internet", message: "The email you entered isn't registered or you lost connection;\nPlease sign up first.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
