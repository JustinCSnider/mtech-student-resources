//
//  RandomUser.swift
//  APIProject
//
//  Created by Justin Snider on 12/12/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import Foundation

struct RandomUser {
    var userName: String
    var firstName: String
    var lastName: String
    var age: Int
    var thumbNailURL: URL
    
    init?(json: [String : Any]) {
        
        guard let unwrappedLogin = json["login"] as? [String : Any],
            let unwrappedName = json["name"] as? [String : Any],
            let unwrappedDOB = json["dob"] as? [String : Any],
            let unwrappedPicture = json["picture"] as? [String : Any],
            let userName = unwrappedLogin["username"] as? String,
            let firstName = unwrappedName["first"] as? String,
            let lastName = unwrappedName["last"] as? String,
            let age = unwrappedDOB["age"] as? Int,
            let thumbNailString = unwrappedPicture["thumbnail"] as? String,
            let thumbNailURL = URL(string: thumbNailString) else { return nil }
        
        self.userName = userName
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.thumbNailURL = thumbNailURL
    }
}
