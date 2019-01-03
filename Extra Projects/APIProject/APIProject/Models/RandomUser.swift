//
//  RandomUser.swift
//  APIProject
//
//  Created by Justin Snider on 12/12/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import Foundation

struct RandomUser: Codable {
    var userName: String
    var firstName: String
    var lastName: String
    var age: Int
    var thumbNailURL: URL
    
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case firstName = "first"
        case lastName = "last"
        case age
        case thumbNailURL = "thumbnail"
    }
    
    enum AdditionalKeys: CodingKey {
        case login
        case name
        case dob
        case picture
    }
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: AdditionalKeys.self)
        let loginContainer = try rootContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: AdditionalKeys.login)
        let nameContainer = try rootContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: AdditionalKeys.name)
        let dobContainer = try rootContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: AdditionalKeys.dob)
        let pictureContainer = try rootContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: AdditionalKeys.picture)
        self.userName = try loginContainer.decode(String.self, forKey: CodingKeys.userName)
        self.firstName = try nameContainer.decode(String.self, forKey: CodingKeys.firstName)
        self.lastName = try nameContainer.decode(String.self, forKey: CodingKeys.lastName)
        self.age = try dobContainer.decode(Int.self, forKey: CodingKeys.age)
        let thumbNailString = try pictureContainer.decode(String.self, forKey: CodingKeys.thumbNailURL)
        self.thumbNailURL = URL(string: thumbNailString)!
    }
}

struct RandomUsers: Codable {
    let results: [RandomUser]
}
