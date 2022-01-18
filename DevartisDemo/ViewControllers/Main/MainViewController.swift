//
//  MainViewController.swift
//  DevartisDemo
//
//  Created by Diego Quimbo on 4/22/21.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // Private vars
    private let _viewModel = MainViewModel()
    private var _feeds = BehaviorRelay<[Feed]>(value: [])
    private let _disposeBag = DisposeBag()
    private enum MainSegue: String {
        case ShowArticles
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callGetFeedsService()
        setUpRxTableView()
    }
    
    // MARK: - IBActions
    @IBAction func addNewFeedAction(_ sender: Any) {
        showAddNewFeedAlert()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MainSegue.ShowArticles.rawValue {
            let articlesController = segue.destination as! ArticlesListViewController
            articlesController.viewModel = _viewModel.getArticlesViewModel()
        }
    }
}

// MARK: - Private methods UI
private extension MainViewController {
    func setUpRxTableView() {
        _feeds.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, feed, cell) in
                cell.textLabel?.text = feed.title
        }.disposed(by: _disposeBag)
        
        tableView.rx.modelSelected(Feed.self)
        .subscribe(onNext: { [unowned self] feed in
            _viewModel.setFeedSelected(feed: feed)
            performSegue(withIdentifier: MainSegue.ShowArticles.rawValue, sender: nil)
        }).disposed(by: _disposeBag)
    }
}

// MARK: - Private methods Services
private extension MainViewController {
    func refreshFeeds() {
        callGetFeedsService()
    }
    
    func callGetFeedsService() {
        showProgressHud(view: view)
        _viewModel.getRSSFeeds { [unowned self] success in
            hideProgressHud(view: view)
            if success {
                _feeds.accept(self._viewModel.feeds)
            } else {
                showAlert(title: "Error", message: "There is an error getting your Feeds RSS")
            }
        }
    }
    
    func showAddNewFeedAlert() {
        let alert = UIAlertController(title:"Add New Feed", message: "Include the URL of RSS Feed", preferredStyle:UIAlertController.Style.alert)
        
        alert.addTextField { (textField : UITextField!) in
            textField.placeholder = "URL"
        }
        
        let save = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { [unowned self] saveAction -> Void in
            let textField = alert.textFields![0] as UITextField
            callAddFeedService(url: textField.text)
        })
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(save)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func callAddFeedService(url: String?) {
        guard let urlValue = url?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            showAlert(title: "Error", message: "The url is not valid")
            return
        }
        showProgressHud(view: view)
        _viewModel.addFeed(url: urlValue) { [unowned self] success in
            hideProgressHud(view: view)
            if success {
                showAlert(title: "Success", message: "The RSS Feed has been aded")
                refreshFeeds()
            } else {
                showAlert(title: "Error", message: "We couldn't include the RSS Feed")
            }
        }
    }
}
