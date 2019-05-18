//
//  BreedsListResponse.swift
//  randog
//
//  Created by Ge on 5/18/19.
//  Copyright © 2019 Veronica Ge. All rights reserved.
//

import Foundation


struct BreedListResponse: Codable{
    let status: String
    let message: [String:[String]]  //construct this to follow the structure of the breeds list JSON object.
    
    //message is the property name, the value is a dictionary.
    //In this dictionary, the key is a string (the breed names), the value is an array of strings (the sub breed names.
    
    //MARK: Swift use [:] to represent dictionaries, instead of using {}
}
