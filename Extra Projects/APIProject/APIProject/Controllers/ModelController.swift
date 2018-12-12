//
//  ModelController.swift
//  APIProject
//
//  Created by Justin Snider on 12/12/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import Foundation

struct ModelController {
    
    static var currentItems: [Any] = []
    static var currentType: modelType = .randomUser
    
    enum modelType {
        case randomUser
        case representative
        case nobelWinner
    }
    
    func fetchItems(matching query: [String: String], completion: @escaping ([Any]?) -> Void) {
        
        let baseURL = URL(string: "https://randomuser.me/api/")!
        
    guard let url = baseURL.withQueries(query) else {
            
            completion(nil)
            print("Unable to build URL with supplied queries.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data,
                let rawJSON = try? JSONSerialization.jsonObject(with: data),
                let json = rawJSON as? [String: Any],
                let resultsArray = json["results"] as? [[String: Any]] {
                var results: [Any] = []
                switch ModelController.currentType {
                case .randomUser:
                    results = resultsArray.compactMap { RandomUser(json: $0) }
                case .representative:
                    results = resultsArray.compactMap { Representative(json: $0) }
                case .nobelWinner:
                    results = resultsArray.compactMap { NobelWinner(json: $0) }
                }
                completion(results)
                
            } else {
                print("Either no data was returned, or data was not serialized.")
                
                completion(nil)
                return
            }
        }
        
        task.resume()
    }
}
