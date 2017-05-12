//
//  Person.swift
//  NamesToFaces
//
//  Created by Tom Holland on 5/12/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        
        self.image = image
        self.name = name
    }
}
