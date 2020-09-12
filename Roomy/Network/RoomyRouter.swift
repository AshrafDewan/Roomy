//
//  RoomyRouter.swift
//  Roomy
//
//  Created by Ashraf Dewan on 5/3/20.
//  Copyright © 2020 Ashraf Dewan. All rights reserved.
//

import Alamofire
import Foundation

enum RoomyRouter: URLRequestConvertible {
    
    case signIn(email: String, password: String)
    case signUp(name: String, email: String, password: String)
    case addRooms(authToken: String, title: String, place: String, price: String, description: String)
    case getRooms(String)
        
    var url: URL {
        switch self {
        case .signIn:
            return URL(string: "https://roomy-application.herokuapp.com/auth/login")!
        case .signUp:
            return URL(string: "https://roomy-application.herokuapp.com/signup")!
        case .addRooms:
            return URL(string: "https://roomy-application.herokuapp.com/rooms")!
        case .getRooms:
            return URL(string: "https://roomy-application.herokuapp.com/rooms")!
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .signIn:
            return .post
        case .signUp:
            return .post
        case .addRooms:
            return .post
        case .getRooms:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .signIn(let email, let password):
            return ["email": email, "password": password]
        case .signUp(let name, let email, let password):
            return ["name": name, "email": email, "password": password]
        case .addRooms(_, let title, let place, let price, let description):
            return ["title": title, "place": place, "price": price, "description": description]
        case .getRooms:
            return nil
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .signIn:
            return nil
        case .signUp:
            return nil
        case .addRooms(let authToken, _, _, _, _):
            return ["Authorization": authToken]
        case .getRooms(let authToken):
            return ["Authorization": authToken]
        }
    }
        
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        
        let encoding: ParameterEncoding = {
            switch self.method {
            case .get:
                return JSONEncoding.default
            default:
                return URLEncoding.default
            }
        }()
        
        urlRequest.allHTTPHeaderFields = headers
        
        return try! encoding.encode(urlRequest, with: parameters)
    }
}
