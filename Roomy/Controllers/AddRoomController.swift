//
//  AddRoomController.swift
//  Roomy
//
//  Created by Ashraf Dewan on 9/3/20.
//  Copyright © 2020 Ashraf Dewan. All rights reserved.
//

import NVActivityIndicatorView
import UIKit

class AddRoomController: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet private weak var titleLabel: UITextField!
    @IBOutlet private weak var placeLabel: UITextField!
    @IBOutlet private weak var priceLabel: UITextField!
    @IBOutlet private weak var descriptionLabel: UITextField!
    
    var adding = false
    let signInAuthToken = KeychainWrapper.standard.string(forKey: "SignInAuthToken") ?? ""

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - Private Functions

extension AddRoomController {
    @IBAction private func backButtonTapped(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ListOfRoomsController") as? ListOfRoomsController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    @IBAction private func addRoomButtonTapped(_ sender: UIButton) {
        startAnimating()
        untouchable()
        
        let title = titleLabel.text
        let place = placeLabel.text
        let price = priceLabel.text
        let description = descriptionLabel.text
        
        if title == "" || place == "" || price == "" || description  == "" {
            someEmptyField()
        } else {
            uploadRooms(title: title!, place: place!, price: price!, description: description!)
        }
        
        stopAnimating()
        untouchable()
    }
    
    private func uploadRooms(title: String, place: String, price: String, description: String) {
        RoomyRequests.addRooms(authToken: signInAuthToken, title: title, place: place, price: price, description: description) { [weak self] (response: Result<Data, Error>) in
            self?.stopAnimating()
            
            switch response {
            case .success:
                self?.roomUploaded()
            case .failure:
                self?.failure()
            }
        }
    }
    
    private func someEmptyField() {
        let ac = UIAlertController(title: "Empty Field", message: "All fields are required", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
    
    private func roomUploaded() {
        let ac = UIAlertController(title: "Successful", message: "Room was updated successfully", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
    
    private func failure() {
        let ac = UIAlertController(title: "Failed", message: "Room wasn't updated \nPlease try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
    
    private func untouchable() {
        adding = !adding
        titleLabel.isEnabled = !adding
        placeLabel.isEnabled = !adding
        priceLabel.isEnabled = !adding
        descriptionLabel.isEnabled = !adding
    }
}
