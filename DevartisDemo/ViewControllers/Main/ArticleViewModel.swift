//
//  ArticleViewModel.swift
//  DevartisDemo
//
//  Created by Diego Quimbo on 4/22/21.
//

import WebKit

final class ArticleViewModel {
    private var _feed: Feed?
    private var _article: Article?
    
    // MARK: - Init
    init(feed: Feed?, article: Article?) {
        _feed = feed
        _article = article
    }
    
    var title: String {
        return _article?.title ?? ""
    }
    
    var url: URLRequest? {
        guard let url = URL(string: _article?.url ?? "") else {
            return nil
        }
        
        return URLRequest(url: url)
    }
}

// MARK: - Call Network
extension ArticleViewModel {
    func markArticleAsRead() {
        guard let idFeed = _feed?.id, let idArticle = _article?.id else {
            return
        }
        ConnectionManager_Feed.markReadArticle(idFeed: idFeed, idArticle: idArticle) { success in }
    }
}
