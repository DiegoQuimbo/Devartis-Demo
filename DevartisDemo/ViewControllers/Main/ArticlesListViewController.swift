//
//  ArticlesListViewController.swift
//  DevartisDemo
//
//  Created by Diego Quimbo on 4/22/21.
//

import UIKit
import RxSwift
import RxCocoa

class ArticlesListViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // Public vars
    var viewModel: ArticlesListViewModel?
    private var _articles = BehaviorRelay<[Article]>(value: [])
    private let _disposeBag = DisposeBag()
    private enum ArticleListSegue: String {
        case ShowArticle
    }

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        callGetArticles()
        setUpRxTableView()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ArticleListSegue.ShowArticle.rawValue {
            let controller = segue.destination as! ArticleViewController
            controller.viewModel = viewModel?.getArticleViewModel()
        }
    }
}

// MARK: - Private methods Services
private extension ArticlesListViewController {
    func callGetArticles() {
        showProgressHud(view: view)
        viewModel?.getArticles(completion: { [unowned self] (success) in
            hideProgressHud(view: view)
            if success {
                _articles.accept(viewModel?.articles ?? [])
            } else {
                showAlert(title: "Error", message: "There is an error getting your Articles")
            }
        })
    }
    
    func setUpRxTableView() {
        _articles.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, article, cell) in
                cell.textLabel?.text = article.title
        }.disposed(by: _disposeBag)
        
        tableView.rx.modelSelected(Article.self)
        .subscribe(onNext: { [unowned self] article in
            viewModel?.setArticleSelected(article: article)
            performSegue(withIdentifier: ArticleListSegue.ShowArticle.rawValue, sender: nil)
        }).disposed(by: _disposeBag)
    }
}
