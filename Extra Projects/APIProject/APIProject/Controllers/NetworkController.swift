//
//  NetworkController.swift
//  APIProject
//
//  Created by Justin Snider on 12/14/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

struct NetworkController {
    
    func fetchItems(_ searchText: String, completion: @escaping ([Any]?) -> Void) {
        var url: URL
        switch ModelController.currentType {
        case .randomUser:
            url = URL(string: "https://randomuser.me/api/?results=" + searchText)!
        case .representative:
            url = URL(string: "http://whoismyrepresentative.com/getall")!
        case .nobelWinner:
            url = URL(string: "http://api.nobelprize.org/v1/prize.json")!
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
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
                
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
