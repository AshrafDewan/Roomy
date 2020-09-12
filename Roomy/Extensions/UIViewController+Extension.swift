//
//  UIViewController+Extension.swift
//  Roomy
//
//  Created by Ashraf Dewan on 9/2/20.
//  Copyright © 2020 Ashraf Dewan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func emptyField() {
        let ac = UIAlertController(title: "Empty field", message: "Your didn't enter an email or password", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Return", style: .cancel))
        present(ac, animated: true)
    }
    
    func wrongEmail() {
        let ac = UIAlertController(title: "Incorrect email format", message: "The email you entered doesn't contain (@) and (.com)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Return", style: .cancel))
        present(ac, animated: true)
    }
    
    func emptySpace() {
        let ac = UIAlertController(title: "Invalid", message: "Your shouldn't enter an empty space", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Return", style: .cancel))
        present(ac, animated: true)
    }
}
