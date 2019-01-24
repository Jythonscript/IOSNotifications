//
//  Database.swift
//  notifications01
//
//  Created by 90302927 on 1/16/19.
//  Copyright © 2019 90302927. All rights reserved.
//

import Foundation

class Database: NSObject {
    
    let url = ""
    
    func downloadItems() {
        
        let url: URL = URL(string: self.url)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                print(data)
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
//            jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
//            print("catch let error as NSError")
            
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
//            let location = LocationModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let name = jsonElement["Name"] as? String,
                let address = jsonElement["Address"] as? String,
                let latitude = jsonElement["Latitude"] as? String,
                let longitude = jsonElement["Longitude"] as? String,
                let details = jsonElement["Detail"] as? String
                
            {
                
                print("Name:")
                print(name)
                
                print("Address:")
                print(address)
                
                print("Latitude:")
                print(latitude)
                
                print("Longitude:")
                print(longitude)
                
                print("Details:")
                print(details)
//                location.name = name
//                location.address = address
//                location.latitude = latitude
//                location.longitude = longitude
//                location.details = details
                
            }
            print("########################3")
//            locations.add(location)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
//            self.delegate.itemsDownloaded(items: locations)
            
        })
    }
    
}
