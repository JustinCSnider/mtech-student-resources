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
            if let state = stateList[searchText] {
                url = URL(string: "https://whoismyrepresentative.com/getall_reps_bystate.php?output=json&state=" + state)!
            } else {
                url = URL(string: "https://whoismyrepresentative.com/getall_reps_bystate.php?output=json&state=" + searchText)!
            }
        case .nobelWinner:
            url = URL(string: "http://api.nobelprize.org/v1/prize.json?year=" + searchText)!
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            
            if let data = data,
                let rawJSON = try? JSONSerialization.jsonObject(with: data),
                let json = rawJSON as? [String: Any] {
                var results: [Any] = []
                
                if let randomUsers = try? decoder.decode(RandomUsers.self, from: data) {
                    results = randomUsers.results
                } else if let representatives = try? decoder.decode(Representatives.self, from: data) {
                    results = representatives.results
                } else if let resultsArray = json["prizes"] as? [[String: Any]] {
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
