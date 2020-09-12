//
//  RoomCell.swift
//  Roomy
//
//  Created by Ashraf Dewan on 4/21/20.
//  Copyright © 2020 Ashraf Dewan. All rights reserved.
//

import UIKit

class RoomCell: UITableViewCell {
    @IBOutlet private weak var streetLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    
    func setRoom(room: Room) {
        streetLabel.text = room.title
        cityLabel.text = room.place
        priceLabel.text = room.price
    }
}
