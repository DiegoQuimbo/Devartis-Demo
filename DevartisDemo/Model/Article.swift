//
//  Articles.swift
//  DevartisDemo
//
//  Created by Diego Quimbo on 4/22/21.
//

import SwiftyJSON

class Article: NSObject {
    let id: Int
    let title: String
    let url: String
    
    init(jsonOBject: JSON) {
        self.id = jsonOBject["id"].int ?? 0
        self.title = jsonOBject["title"].string ?? ""
        self.url = jsonOBject["url"].string ?? ""
    }
}
