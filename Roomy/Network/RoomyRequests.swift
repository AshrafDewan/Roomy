//
//  RoomyRequest.swift
//  Roomy
//
//  Created by Ashraf Dewan on 5/3/20.
//  Copyright © 2020 Ashraf Dewan. All rights reserved.
//

import Alamofire
import Foundation

class RoomyRequests {
    
    static func signIn(email: String, password: String, _ completionHandler: @escaping (Result<SignInResponse, Error>) -> Void) {
        
        let signInRequest = RoomyRouter.signIn(email: email, password: password)
        
        AF.request(signInRequest).responseData { (response: AFDataResponse<Data>) in
            
            switch response.result {
            case .success(let data):
                do {
                    let signInResponse = try JSONDecoder().decode(SignInResponse.self, from: data)
                    completionHandler(.success(signInResponse))
                } catch let error {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    static func signUp(name: String, email: String, password: String, _ completionHandler: @escaping (Result<SignUpResponse, Error>) -> Void) {
        
        let signUpRequest = RoomyRouter.signUp(name: name, email: email, password: password)
        
        AF.request(signUpRequest).responseData { (response: AFDataResponse<Data>) in
            
            switch response.result {
            case .success(let data):
                do {
                    let signUpResponse = try JSONDecoder().decode(SignUpResponse.self, from: data)
                    completionHandler(.success(signUpResponse))
                } catch let error {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    static func addRooms(authToken: String, title: String, place: String, price: String, description: String, _ completionHandler: @escaping (Result<Data, Error>) -> Void) {
        
        let addRoomsRequest = RoomyRouter.addRooms(authToken: authToken, title: title, place: place, price: price, description: description)
        
        AF.request(addRoomsRequest).responseData { (response: AFDataResponse<Data>) in
            
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    static func getRooms(authToken: String, _ completionHandler: @escaping (Result<Any, Error>) -> Void) {
        
        let getRoomsRequest = RoomyRouter.getRooms(authToken)
        AF.request(getRoomsRequest).responseJSON { (response: AFDataResponse<Any>) in
            
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
