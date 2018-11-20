//
//  ExtensionsAndProtocols.swift
//  ScoreKeeper
//
//  Created by Justin Snider on 11/15/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import Foundation
import CoreData

protocol ManagedObjectContextDependentType {
    var managedObjectContext: NSManagedObjectContext! { get set }
}

protocol currentGameDelegate {
    func didSelect(game: Game)
}

