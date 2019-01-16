//
//  NetworkController.swift
//  slapJack
//
//  Created by Justin Snider on 1/15/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import UIKit

struct NetworkController {
    
    static func performNetworkRequest(for url: URL, completion: ((Data?, Error?) -> Void)? = nil) {
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let completion = completion {
                
                completion(data, error)
            }
        }
        dataTask.resume()
    }
}
