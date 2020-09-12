//
//  SignUpController.swift
//  Roomy
//
//  Created by Ashraf Dewan on 9/2/20.
//  Copyright © 2020 Ashraf Dewan. All rights reserved.
//

import Alamofire
import NVActivityIndicatorView
import UIKit

class SignUpController: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet private weak var usernameLabel: UITextField!
    @IBOutlet private weak var emailLabel: UITextField!
    @IBOutlet private weak var passwordLabel: UITextField!
    
    private var signingUp = false

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - Private Functions

extension SignUpController {
    
    @IBAction private func signUpButtonTapped(_ sender: UIButton) {
        startAnimating()
        untouchable()
        
        guard let name = usernameLabel.text else { return }
        guard let email = emailLabel.text else { return }
        guard let password = passwordLabel.text else { return }
            
        if checkEmailAndPassword(username: name, email: email, password: password) {
            sendSignUpRequest(name: name, email: email, password: password)
        } else {
            stopAnimating()
        }
        
        untouchable()
    }
    
    private func sendSignUpRequest(name: String, email: String, password: String) {
        RoomyRequests.signUp(name: name, email: email, password: password) { [weak self] (response: Result<SignUpResponse, Error>) in
            self?.stopAnimating()
            
            switch response {
            case .success:
                self?.registered()
            case .failure:
                self?.registeredFailed()
            }
        }
    }
    
    @IBAction private func signInButtonTapped(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SignInController") as? SignInController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    private func untouchable() {
        signingUp = !signingUp
        usernameLabel.isEnabled = !signingUp
        emailLabel.isEnabled = !signingUp
        passwordLabel.isEnabled = !signingUp
    }
    
    private func checkEmailAndPassword(username: String, email: String, password: String) -> Bool {
        if username.isEmpty || email.isEmpty || password.isEmpty {
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
    
    private func registered() {
        let ac = UIAlertController(title: "Congratulations", message: "Account registered successfully", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
    private func registeredFailed() {
        let ac = UIAlertController(title: "Oops!", message: "Sorry something went wrong\nPlease try to register again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

