//
//  ListOfRoomsController.swift
//  Roomy
//
//  Created by Ashraf on 3/12/20.
//  Copyright © 2020 Ashraf Dewan. All rights reserved.
//

import Alamofire
import NVActivityIndicatorView
import UIKit

class ListOfRoomsController: UIViewController, NVActivityIndicatorViewable {
    @IBOutlet private weak var tableView: UITableView!
    
    var downloadedRooms = [[String: Any]]()
    var rooms = [Room]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downloadRooms()
    }
}

// MARK: - UITableViewDataSource Functions

extension ListOfRoomsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let room = rooms[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell") as! RoomCell
        
        cell.setRoom(room: room)
        return cell
    }
}

// MARK: - UITableViewDelegate Functions

extension ListOfRoomsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "RoomDetailsController") as? RoomDetailsController {
            vc.details = rooms[indexPath.row].details
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}

// MARK: - Private Functions

extension ListOfRoomsController {
    private func loadRooms() {
        let rooms = RoomyDatabaseManager.loadRooms()
        self.rooms = rooms
        self.tableView.reloadData()
    }
    
    private func createRoom() {
        for room in downloadedRooms {
            let room = Room(title: room["title"] as? String ?? "", place: room["place"] as? String ?? "", price: room["price"] as? String ?? "", description: room["description"] as? String ?? "")
            rooms.append(room)
        }
        
        deleteLocalRooms()
        
        RoomyDatabaseManager.saveRooms(rooms: self.rooms)
    }
    
    private func deleteLocalRooms() {
        let rooms = RoomyDatabaseManager.loadRooms()
        
        if !(rooms.isEmpty) {
            RoomyDatabaseManager.deleteRooms()
        }
    }
    
    private func downloadRooms() {
        startAnimating()
        
        guard let signInAuthToken = KeychainWrapper.standard.string(forKey: "SignInAuthToken") else { return }
        
        RoomyRequests.getRooms(authToken: signInAuthToken) { [weak self] (response: Result<Any, Error>) in
            self?.stopAnimating()
            
            switch response {
            case .success(let rooms):
                guard let rooms = rooms as? [[String: Any]] else { return }
                self?.downloadedRooms = rooms
                self?.createRoom()
                self?.tableView.reloadData()
                
            case .failure:
                self?.loadRooms()
                self?.noConnection()
            }
        }
    }
    
    private func noConnection() {
        let ac = UIAlertController(title: "Oops!", message: "This is an old data\nThe internet connection appears to be offline.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    private func enterDeveloperPassword() {
        let ac = UIAlertController(title: "Enter Password", message: nil, preferredStyle: .alert)
        ac.addTextField() { field in
            field.placeholder = "Password: 12345"
        }
        ac.addAction(UIAlertAction(title: "Enter", style: .default) { [weak self, weak ac] _ in
            guard ac?.textFields?[0].text == "12345" else {
                self?.wrongDeveloperPassword()
                return
            }
            
            self?.goToAddRoomController()
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    private func goToAddRoomController() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddRoomController") as? AddRoomController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    private func wrongDeveloperPassword() {
        let ac = UIAlertController(title: "Wrong Password", message: "This isn't the write password", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    private func goToSignInController() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SignInController") as? SignInController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    @IBAction private func logOutButtonTapped(_ sender: UIButton) {
        KeychainWrapper.standard.set("", forKey: "SignInAuthToken")
        
        goToSignInController()
    }
    
    @IBAction private func developerButtonTapped(_ sender: UIButton) {
        enterDeveloperPassword()
    }
}
