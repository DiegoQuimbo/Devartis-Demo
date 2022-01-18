//
//  MainViewModel.swift
//  DevartisDemo
//
//  Created by Diego Quimbo on 4/22/21.
//

import Foundation

final class MainViewModel {
    //Private Vars
    private var _feeds: [Feed] = []
    private var _feedSelected: Feed?
    
    // MARK: - Public Vars
    var feeds: [Feed] {
        return _feeds
    }
    
    // MARK: - Public Functions
    func setFeedSelected(feed: Feed) {
        _feedSelected = feed
    }
    
    func getArticlesViewModel() -> ArticlesListViewModel? {
        return ArticlesListViewModel(feed: _feedSelected)
    }
}

// MARK: - Call Network
extension MainViewModel {
    // Get RSS Feds
    func getRSSFeeds(completion :@escaping (_ success: Bool) -> ()) {
        ConnectionManager_Feed.listElements { [unowned self] (success, feedList) in
            self._feeds = feedList
            completion(success)
        }
    }
    
    // Call Register service API
    func addFeed(url: String, completion :@escaping (_ success: Bool) -> ()) {
        ConnectionManager_Feed.add(url: url) { success in
            completion(success)
        }
    }
}
