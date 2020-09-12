//
//  RoomyDatabaseManager.swift
//  Roomy
//
//  Created by Ashraf Dewan on 5/11/20.
//  Copyright © 2020 Ashraf Dewan. All rights reserved.
//

import Foundation
import RealmSwift

class RoomyDatabaseManager {
    private static let realm = try! Realm()
    
    static func saveRooms(rooms: [Room]) {
        try! realm.write {
            realm.add(rooms)
        }
    }
    
    static func loadRooms() -> [Room] {
        let roomsArray = realm.objects(Room.self)
        var rooms = [Room]()
        
        for room in roomsArray {
            rooms.append(room)
        }
        
        return rooms
    }
    
    static func deleteRooms() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
