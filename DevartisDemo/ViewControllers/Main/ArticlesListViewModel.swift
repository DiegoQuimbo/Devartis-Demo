//
//  ArticlesListViewModel.swift
//  DevartisDemo
//
//  Created by Diego Quimbo on 4/22/21.
//

final class ArticlesListViewModel {
    // Private Vars
    private var _feed: Feed?
    private var _articles: [Article] = []
    private var _articleSelected: Article?
    
    // MARK: - Init
    init(feed: Feed?) {
        _feed = feed
    }
    
    // MARK: - Public Vars
    var articles: [Article] {
        return _articles
    }
    
    // MARK: - Public Functions
    func setArticleSelected(article: Article) {
        _articleSelected = article
    }
    
    func getArticleViewModel() -> ArticleViewModel? {
        return ArticleViewModel(feed: _feed, article: _articleSelected)
    }
    
}


// MARK: - Call Network
extension ArticlesListViewModel {
    func getArticles(completion :@escaping (_ success: Bool) -> ()) {
        guard let feedID = _feed?.id else {
            completion(false)
            return
        }
        ConnectionManager_Feed.listArticles(idFeed: feedID) { (success, articles) in
            self._articles = articles
            completion(success)
        }
    }
}
