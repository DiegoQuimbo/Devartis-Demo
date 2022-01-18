//
//  URLs.swift
//  DevartisDemo
//
//  Created by Diego Quimbo on 4/22/21.
//

import Foundation

struct URLs {
    
    static var baseURL : URL = URL(string: "http://167.99.162.146/")!
    static var baseUserURL : URL = URL(string: "\(baseURL)users")!
    static var baseFeedURL : URL = URL(string: "\(baseURL)feeds")!
    
    struct User {
        static let register = baseUserURL.appendingPathComponent("/register")
        static let login = baseUserURL.appendingPathComponent("/login")
    }
    
    struct Feed {
        static let list = baseFeedURL
        static let add = baseFeedURL.appendingPathComponent("/add")
        
        static func listArticles(idFeed: Int) -> String {
            return "\(list)/\(idFeed)/articles"
        }
        
        static func markRead(idFeed: Int, idArticle: Int) -> String {
            return "\(list)/\(idFeed)/articles/\(idArticle)/toggle_read"
        }
    }
}
