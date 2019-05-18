//
//  DogImage.swift
//  randog
//
//  Created by Ge on 5/13/19.
//  Copyright © 2019 Veronica Ge. All rights reserved.
//

import Foundation

//conforms the struct to the codable protocol.
//must make sure the property names of this struct is exactly the same with the key names of the JSON object in order for Codable to automatically parse the data. 
struct DogImage: Codable{
    let status:String
    let message: String
}
