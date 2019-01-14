//
//  RepresentativeController.swift
//  RepresentativeCoreData
//
//  Created by Justin Snider on 1/14/19.
//  Copyright © 2019 Justin Snider. All rights reserved.
//

import Foundation
import CoreData

class RepresentativeController {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    let baseURL = "https://whoismyrepresentative.com/getall_mems.php?&output=json&zip="
    
    static var sharedController = RepresentativeController()
    
    var representatives: [Representative] {
        let repFetchRequest = NSFetchRequest<Representative>(entityName: Representative.entityName)
        
        do {
            return try Stack.context.fetch(repFetchRequest)
        } catch {
            return []
        }
        
    }
    
    //========================================
    //MARK: - Network Methods
    //========================================
    
    func searchForReps(zipcode: String, completion: (([Representative]?) -> Void)? = nil) {
        
        guard let url = URL(string: baseURL + zipcode) else {
            print("Bad Zipcode")
            return
        }
        
        NetworkController.performNetworkRequest(for: url) { (data, error) in
            guard let data = data else { return }
            
            do {
                let jsonObjects = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let dictionary = jsonObjects as? Dictionary<String, [Dictionary<String, Any>]>,
                    let results = dictionary["results"] {
                    var reps: [Representative] = []
                    for rep in results {
                        if let representative = Representative(dictionary: rep) {
                            reps.append(representative)
                        }
                    }
                    
                    if let completion = completion {
                        completion(reps)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    //========================================
    //MARK: - Data Persistence Methods
    //========================================
    
    func deleteRep(rep: Representative) {
        Stack.context.delete(rep)
        saveToPersistentStorage()
    }
    
    func saveRep(rep: Representative) {
        
        for representative in representatives {
            Stack.context.delete(representative)
        }
        
        let newRep = Representative(context: Stack.context)
        newRep.name = rep.name
        newRep.address = rep.address
        newRep.phoneNumber = rep.phoneNumber
        
        saveToPersistentStorage()
    }
    
    private func saveToPersistentStorage() {
        do {
            try Stack.context.save()
        } catch {
            Stack.context.rollback()
            print("Save failed: \(error)")
        }
    }
}
