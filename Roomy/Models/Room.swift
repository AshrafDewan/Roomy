//
//  Room.swift
//  Roomy
//
//  Created by Ashraf Dewan on 4/23/20.
//  Copyright © 2020 Ashraf Dewan. All rights reserved.
//

import Foundation
import RealmSwift

class Room: Object, Codable {
    @objc dynamic var title: String = ""
    @objc dynamic var place: String = ""
    @objc dynamic var price: String = ""
    @objc dynamic var details: String = ""
    
    convenience init(title: String, place: String, price: String, description: String) {
        self.init()
        self.title = title
        self.place = place
        self.price = price
        self.details = description
    }
}

