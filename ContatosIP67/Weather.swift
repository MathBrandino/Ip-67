//
//  Weather.swift
//  ContatosIP67
//
//  Created by Matheus Brandino on 3/24/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit
import ObjectMapper

class Weather: Mappable {

    var min : Double!
    var max : Double!
    var cond : String!
    var icon : String!
    
    required init(map:Map){
        
    }
    
    func mapping(map:Map){
        min <- map["main.temp.min"]
        max <- map["main.temp.max"]
        cond <- map["weather.0.main"]
        icon <- map["weather.0.icon"]
        
    }
    
}
