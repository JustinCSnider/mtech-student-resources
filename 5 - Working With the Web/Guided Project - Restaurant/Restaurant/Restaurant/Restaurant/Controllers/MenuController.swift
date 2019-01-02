//
//  NetworkController.swift
//  Restaurant
//
//  Created by Justin Snider on 12/19/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import UIKit

class MenuController {
    
    //========================================
    //MARK: - Properties
    //========================================
    
    static var shared = MenuController()
    static let orderUpdatedNotification = Notification.Name("MenuController.orderUpdated")
    static let menuDataUpdatedNotification = Notification.Name("MenuController.menuDataUpdated")
    
    
    var order = Order() {
        didSet {
            NotificationCenter.default.post(name: MenuController.orderUpdatedNotification, object: nil)
        }
    }
    var categories: [String] {
        get {
            return itemsByCategory.keys.sorted()
        }
    }
    
    let baseURL = URL(string: "http://localhost:8090/")!
    
    private var itemsByID = [Int : MenuItem]()
    private var itemsByCategory = [String : [MenuItem]]()
    
    //========================================
    //MARK: - Network Methods
    //========================================
    
    func loadRemoteData() {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        let components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        let menuURL = components.url!
        
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                self.process(menuItems.items)
            }
        }
        task.resume()
    }
    
    func submitOrder(forMenuIDs menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data: [String : [Int]] = ["menuIds" : menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    //========================================
    //MARK: - Data Persistance Methods
    //========================================
    
    func loadItems() {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let menuItemsFileURL = documentDirectoryURL.appendingPathComponent("menuItems").appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: menuItemsFileURL) else { return }
        let items = (try? JSONDecoder().decode([MenuItem].self, from: data)) ?? []
        process(items)
    }
    
    func saveItems() {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let menuItemsFileURL = documentDirectoryURL.appendingPathComponent("menuItems").appendingPathExtension("json")
        
        let items = Array(itemsByID.values)
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: menuItemsFileURL)
        }
    }
    
    func loadOrder() {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let orderFileURL = documentDirectoryURL.appendingPathComponent("order").appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: orderFileURL) else { return }
        order = (try? JSONDecoder().decode(Order.self, from: data)) ?? Order(menuItems: [])
        
    }
    
    func saveOrder() {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let orderFileURL = documentDirectoryURL.appendingPathComponent("order").appendingPathExtension("json")
        
        if let data = try? JSONEncoder().encode(order) {
            try? data.write(to: orderFileURL)
        }
    }
    
    //========================================
    //MARK: - Helper Methods
    //========================================
    
    private func process(_ items: [MenuItem]) {
        itemsByID.removeAll()
        itemsByCategory.removeAll()
        
        for item in items {
            itemsByID[item.id] = item
            itemsByCategory[item.category, default: []].append(item)
        }
        
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: MenuController.menuDataUpdatedNotification, object: nil)
        }
    }
    
    func item(withID itemID: Int) -> MenuItem? {
        return itemsByID[itemID]
    }
    
    func items(forCategory category: String) -> [MenuItem]? {
        return itemsByCategory[category]
    }
}
