//
//  ConnectionManager_Feed.swift
//  DevartisDemo
//
//  Created by Diego Quimbo on 4/22/21.
//

import SwiftyJSON
import Alamofire

class ConnectionManager_Feed: ConnectionManager {
    
    class func listElements(completion :@escaping (_ success: Bool, _ elements: [Feed]) -> ()) {
        var headers = ConnectionManager.headers
        headers.add(.authorization(ConnectionManager.sharedInstance.token))
        
        AF.request(URLs.Feed.list, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    var feeds: [Feed] = []
                    let dataJSON = JSON(data)
                    for feedJson in dataJSON.arrayValue {
                        let feed = Feed(jsonOBject: feedJson)
                        feeds.append(feed)
                    }
                    completion(true, feeds)
                case .failure( _):
                    completion(false, [])
                }
            }
    }
    
    class func add(url: String, completion :@escaping (_ success: Bool) -> ()) {
        var headers = ConnectionManager.headers
        headers.add(.authorization(ConnectionManager.sharedInstance.token))
        
        let parameters = [
            "url": url
        ]
        
        AF.request(URLs.Feed.add, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success( _):
                    completion(true)
                case .failure( _):
                    completion(false)
                }
            }
    }
    
    class func listArticles(idFeed: Int, completion :@escaping (_ success: Bool, _ elements: [Article]) -> ()) {
        var headers = ConnectionManager.headers
        headers.add(.authorization(ConnectionManager.sharedInstance.token))
        
        AF.request(URLs.Feed.listArticles(idFeed: idFeed), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    var articles: [Article] = []
                    let dataJSON = JSON(data)
                    for articleJson in dataJSON["articles"].arrayValue {
                        let article = Article(jsonOBject: articleJson)
                        articles.append(article)
                    }
                    completion(true, articles)
                case .failure( _):
                    completion(false, [])
                }
            }
    }
    
    class func markReadArticle(idFeed: Int, idArticle: Int, completion :@escaping (_ success: Bool) -> ()) {
        var headers = ConnectionManager.headers
        headers.add(.authorization(ConnectionManager.sharedInstance.token))
        
        AF.request(URLs.Feed.markRead(idFeed: idFeed, idArticle: idArticle), method: .put, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success( _):
                    completion(true)
                case .failure( _):
                    completion(false)
                }
            }
    }
}

