//
//  ViewController.swift
//  Weather
//
//  Created by Simon Wilson on 30/08/2020.
//  Copyright © 2020 Simon Wilson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //http://api.openweathermap.org/data/2.5/weather?lat=35.2809&lon=149.1300&appid=c6450fbf674a6265a015d0ca9c1edbc0
    
    //http://api.openweathermap.org/data/2.5/weather?q=port+talbot&appid=c6450fbf674a6265a015d0ca9c1edbc0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadDataAndParseJSONRESponse(url: "http://api.openweathermap.org/data/2.5/weather?q=port+talbot&appid=c6450fbf674a6265a015d0ca9c1edbc0")
        
    }

    
    func downloadDataAndParseJSONRESponse(url: String) {
        
        let url = URL(string: url)
        
        let session = URLSession.shared
        
        if let newUrl = url {
        
            let task = session.dataTask(with: newUrl) { (data, response, error) in
                
                if error != nil {
                    
                    //alert
                    
                } else {
                    
                    if data != nil {
                        
                        do {
                            
                            let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                            
                            //print(jsonResponse)
                            
                            DispatchQueue.main.async {
                                
                                if let responseData = jsonResponse["sys"] as? [String: Any] {
                                    
                                    if let sunrise = responseData["sunrise"] {
                                        
                                        print(sunrise as! Int)
                                        
                                    }
                                    
                                    if let sunset = responseData["sunset"] {
                                        
                                        print(sunset as! Int)
                                        
                                    }
                                    
                                }
                                
                                if let weatherResponse = jsonResponse["main"] as? [String: Any] {
                                    
                                    if let temp = weatherResponse["temp"] as? Double {
                                        
                                        print("temp: \(temp)")
                                        
                                    }
                                    
                                    if let humiidty = weatherResponse["humidity"] as? Int {
                                        
                                        print("humidity: \(humiidty)")
                                        
                                    }
                                    
                                    if let pressure = weatherResponse["pressure"] as? Int {
                                        
                                        print("pressure: \(pressure)")
                                        
                                    }
                                    
                                }
                                
                                
                                
                                if let summary = jsonResponse["weather"] as? [[String: Any]] {
                                    
                                    if let decription = summary[0]["description"] as? String {
                                        
                                        print(decription)
                                        
                                    }
                                    
                                }
                                
                                if let wind = jsonResponse["wind"] as? [String: Any] {
                                    
                                    if let windSpeed = wind["speed"] as? Double {
                                        
                                        print(windSpeed)
                                        
                                    }
                                    
                                }
                                
                                if let visibility = jsonResponse["visibility"] {
                                    
                                    print(visibility as! Int)
                                    
                                }
                                
                                
                            }
                            
                            
                        } catch {
                            
                            print(error.localizedDescription)
                            
                        }
                        
                    }
                    
                }
                
            }
            
            task.resume()
        
    }
        
    }

}

