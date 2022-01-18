//
//  ArticleViewController.swift
//  DevartisDemo
//
//  Created by Diego Quimbo on 4/22/21.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    // Public vars
    var viewModel: ArticleViewModel?
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadArticleInView()
        markArticleAsRead()
    }
    
    // MARK: - Private methods
    private func loadArticleInView() {
        titleLabel.text = viewModel?.title
        guard let urlRequest = viewModel?.url else {
            return
        }        
        webView.load(urlRequest)
    }
    
    private func markArticleAsRead() {
        viewModel?.markArticleAsRead()
    }

}
