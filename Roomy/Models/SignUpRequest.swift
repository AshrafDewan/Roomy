//
//  SignUpRequest.swift
//  Roomy
//
//  Created by Ashraf Dewan on 5/3/20.
//  Copyright © 2020 Ashraf Dewan. All rights reserved.
//

import Foundation

struct SignUpRequest: Codable {
    var username: String
    var email: String
    var password: String
}
