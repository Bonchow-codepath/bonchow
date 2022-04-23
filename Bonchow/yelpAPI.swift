//
//  yelpAPI.swift
//  Bonchow
//
//  Created by Yvonne511 on 2022/4/20.
//

//
//  File.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation


struct yelpAPI {
    
//    var latitude = 0
//    var longitude = 0
    
    func changeCoordinates(latitude: Double, longitude : Double) {
        
    }
    
    static func getRestaurants(latitude : Double, longitude : Double, completion: @escaping ([[String:Any]]?) -> Void) {
        
        //Yvonne's API
        let apikey = "eT8Uqx2sMSBPt0sGoQ5m3ZnbMMLoKEDPpruVLpGgdWzr1a7D9dR051vB3ppqjkRM1BjtgikzWpm-Kw4vEEUiSDbbp0-Fc4M59QXyizD4Q9LsjNPFAAxaHmRcqKhgYnYx"
        
        // Coordinates for San Francisco
//        let lat = 37.773972
//        let long = -122.431297
        
        let lat = latitude
        let long = longitude
        
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Insert API Key to request
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print("API fail")
                print(error.localizedDescription)
            } else if let data = data {
                
    

//        print(data)
        
        let dataDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as! [String:Any]
                
        let restaurants = dataDictionary["businesses"] as! [[String:Any]]
                
        return completion(restaurants)
                
                }
            }
        
            task.resume()
        
        }
    }
