//
//  DogAPI.swift
//  randog
//
//  Created by Ge on 5/13/19.
//  Copyright © 2019 Veronica Ge. All rights reserved.
//

import Foundation
import UIKit

//create a class to be used in the VCs.
class DogAPI{
    //create an enum to hold all the dog images from the URLs.
    enum Endpoint: String {
        case randomeImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random" //dont shy away from long names
        
       //we will use string interpolation to modify this URL so that it won't just be the hound breed by could be any breed we select. 
        
        var url: URL{
            return URL(string: self.rawValue)! //only force unwrap if you know this string will indeed generate an URL
            
        }
        
    }
    
    class func requestRandomImage(completionHandler: @escaping(DogImage?, Error?) -> Void){
        
        //take the URL from the random generator in dogAPI
        let randomImageEndpoint = DogAPI.Endpoint.randomeImageFromAllDogsCollection.url
        
        
        //make network request through a URLSession data task
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
            //guard the data in case it's nil
            guard let data = data else{
                completionHandler(nil, error)
                return
            }
            //the data returned is a JSON file, not really the image itself.
            //Need to parse the JSON data into a struct, or a dictionary, etc.
            print(data)
            
            //MARK: parsing json object with JSONSerialization through converting the json object into a DICTIONARY (older way;can't handle more complex json objects)
            //            do{
            //            //create a json object with the returned data.
            //                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any] //use the as! to force json to be a dictionary where keys are strings and values can be any.
            //                //access the "message" part of the dogAPI json object and set that as the url for the UIImage.
            //                let url = json["message"] as! String
            //                print(url)
            //            } catch {
            //                print(error)
            //            } //wrap the jsonObject creation funciton with a do and cathc statement in case of nil/error
            
            
         
            
            //MARK: new Codable protocol; better than JSONSerialization. Converting the JSON object into a STRUCT. Therefore no need to map the keys to dictionary manually.
            //use a JSON decoder to convert the JSON object into a Struct
            let decoder = JSONDecoder()
            //let the decoder access the DogImage struct we created under the Model folder.
            let imageData = try! decoder.decode(DogImage.self, from: data)
            //imageData is a struct that contains status and message.
            print(imageData)
            
            //REMEMBER!!!!! use completion handler to pass the data back to the VC.
            completionHandler(imageData,nil)
        }
        task.resume()
    }
    
    

    //make a class func. (use class func so that we don't need an instance of DogAPI class in order to use this function).
    class func requestImageFile(url:URL, completionHandler: @escaping (UIImage?, Error?) -> Void){
        //mark both UIImage and Error optional in case they are nil.
        //must do @escaping otherwise the next function will be executed automatically after executing requestImageFile.
        
        //use the results returned from one network call to make another network call. (Therefore we are nesting one completion handler into ahother completion handler).
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else {
                //add in case there's an error.
                completionHandler(nil, error)
                print("no data; error")
                return
            }
            let downloadedImg = UIImage(data: data)
            //REMEMBER!!!!! use completion handler to pass the data back to the VC.
            completionHandler(downloadedImg, nil)
        })
        task.resume()
    }
    
    
    
}

