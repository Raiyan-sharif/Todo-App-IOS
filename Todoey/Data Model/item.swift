//
//  item.swift
//  Todoey
//
//  Created by raiyan sharif on 18/7/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

class Item{
    var title: String = ""
    var done: Bool = false
    init() {
        
    }
    init(title: String,done: Bool) {
        self.title = title
        self.done = done
    }
}
