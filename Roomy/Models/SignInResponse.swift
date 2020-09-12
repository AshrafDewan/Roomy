//
//  LogInResponse.swift
//  Roomy
//
//  Created by Ashraf Dewan on 5/3/20.
//  Copyright © 2020 Ashraf Dewan. All rights reserved.
//

import Foundation

struct SignInResponse: Codable {
    var authToken: String
    
    enum CodingKeys: String, CodingKey {
        case authToken = "auth_token"
    }
}
